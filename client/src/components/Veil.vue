<template>
  <main id="dairMap-main" @click="globalClick">
    <div class="background" :style="{ '--background-before-url': backgroundImage}"></div>
    <span class="footer top-panel">
      <div v-for="(action, index) in globalActions"
           :style="{'background-image': action.url, 'height': '40px'}"
           :key="index" :class="['top-panel-item', 'top-panel-item-actions', action.id === selectedGlobalAction.id ? 'top-panel-item-actions-selected' : action.id === preSelectedGlobalAction.id ? 'top-panel-item-actions-pre-selected' : '' ]"
           @mouseover="preSelectedGlobalAction = action" @mouseleave="preSelectedGlobalAction = {}" @click="selectGlobalAction">
          <p>{{ action.name }}</p>
      </div>
    </span>
    <span class="footer top-panel sub-top-panel" v-if="selectedGlobalAction.id === 1">
      <div v-for="(subAction1, index) in globalSubActions1"
           :style="{'background-image': subAction1.url}"
           :key="index" :class="['top-panel-item', 'top-panel-item-sub-actions-1', subAction1.id === selectedGlobalSubAction1.id ? 'top-panel-item-sub-actions-1-selected' : subAction1.id === preSelectedGlobalSubAction1.id ? 'top-panel-item-sub-actions-1-pre-selected' : '' ]"
           @mouseover="preSelectedGlobalSubAction1 = subAction1" @mouseleave="preSelectedGlobalSubAction1 = {}" @click="selectGlobalSubAction1">
          <p>{{ subAction1.name }}</p>
        </div>
    </span>
    <span class="footer top-panel sub-top-panel" v-if="selectedGlobalAction.id === 2">
      <div :style="{'background-image': globalSubActions2[1].url}"
           :class="['top-panel-item', 'top-panel-item-sub-actions-2', globalSubActions2[1].id === selectedGlobalSubAction2.id ? 'top-panel-item-sub-actions-2-selected' : globalSubActions2[1].id === preSelectedGlobalSubAction2.id ? 'top-panel-item-sub-actions-2-pre-selected' : '' ]"
           @mouseover="preSelectedGlobalSubAction2 = globalSubActions2[1]" @mouseleave="preSelectedGlobalSubAction2 = {}" @click="selectGlobalSubAction2">
          <p>{{ globalSubActions2[1].name }}</p>
      </div>
      <i class='bx bx-minus bx-rotate-90' style="margin: 0 5px 0 5px !important; font-size: 1.8em"/>
      <div class="top-panel-container" style="width: 80%;">
        <div v-for="(subAction2, index) in globalSubActions2" v-if="subAction2.id !== 1"
             :style="{'background-image': subAction2.url}"
             :key="index" :class="['top-panel-item', 'top-panel-item-sub-actions-2', subAction2.id === selectedGlobalSubAction2.id ? 'top-panel-item-sub-actions-2-selected' : subAction2.id === preSelectedGlobalSubAction2.id ? 'top-panel-item-sub-actions-2-pre-selected' : '' ]"
             @mouseover="preSelectedGlobalSubAction2 = subAction2" @mouseleave="preSelectedGlobalSubAction2 = {}" @click="selectGlobalSubAction2">
          <p>{{ subAction2.name }}</p>
        </div>
      </div>
    </span>
    <div class="dairMap-container">
      <div id="container" :style="{ width: '100%',
                     height: '100%'}">
        <canvas id="canvas"
                v-bind:style="{cursor: cursorForm}"
                @mousemove="move"
                @mouseleave="leave"
                @mouseup="up"
                @mousedown="down"/>
      </div>
    </div>
    <span class="footer">
      <div v-if="selectedGlobalAction.id === 1" class="footerResources">
         <div class="footerResourcesSettings" @click="newRoom">
          <i :class="['bx', 'bx-plus']" style="font-size: 1.2em; margin-left: 0; color: inherit"/>
          <div style="color: inherit">Комната</div>
        </div>
        <div class="footerResourcesSettings" @click="newLine">
          <i :class="['bx', 'bx-plus']" style="font-size: 1.2em; margin-left: 0; color: inherit"/>
          <div style="color: inherit">Переход</div>
        </div>
      </div>
    </span>
    <div id="itemMenu" :style="{ 'opacity' : menu.visible ? '1' : '0', 'right' : menu.visible ? '30px' : '-300px',
                      'overflow': collapsedMenu ? 'hidden' : 'scroll',
                      'width' : collapsedMenu ? '60px' : '320px',
                      'max-height': 'calc(100% - 100px)',
                      'height': 'fit-content',
                      'min-height': '31px',
                      '--first-color': isEmpty(menu.room) ? '2px solid rgba(0, 0, 0, 0)' : '2px solid ' + menu.room.color,
                      '--second-color': isEmpty(menu.room) ? '' : '0 0 0 5px ' + menu.room.colorSecond }" @click="stopPropagation">
      <i @click="up" class='bx bx-x close' style="margin: 0 5px 0 5px !important; font-size: 1.1em; transform: scale(1.4); position: absolute; right: 0;"/>
      <i @click="collapseMenu" :class="['bx', collapsedMenu ? 'bx-window' : 'bx-windows', 'close']" style="margin: 0 5px 0 5px !important; font-size: 1.1em; position: absolute; right: 1.3em;"/>
      <p style="margin-bottom: 1em;" v-if="!collapsedMenu && !isEmpty(menu.room)">параметры комнаты</p>
      <p style="margin-bottom: 0em;" v-if="!collapsedMenu && !isEmpty(menu.dot)">точка</p>

      <div class="itemMenuInfo" v-if="!collapsedMenu && !isEmpty(menu.room)">
        <input @keyup="renameRoom" class="title" style="margin-bottom: 0.5em; background: transparent; border: none;" v-model="menu.room.name">
        <div :class="['instrument-panel-item']" style="display: flex; flex-direction: row; justify-content: space-around; align-items: center;">
          <div v-for="(d, index) in colors" :key="index"
               :style="{'--first-color': '1px solid ' + d.color, '--second-color': '1px solid ' + d.colorSecond}"
               :class="['instrument-panel-item-hover', 'instrument-panel-item-dair', menu.room.color === d.id ? 'instrument-panel-item-dair-selected' : '']"
               @click="setColor(d.id)">
            <div class="instrument-panel-item-dair-text" :style="{ '--first-color': d.color, '--second-color':  d.colorSecond }"></div>
          </div>
        </div>
      </div>
      <div class="itemMenuSubActions" v-if="!collapsedMenu && !isEmpty(menu.room)">
        <div class="actions"
             :style="{ 'margin-top': '10px' }">
          <div @click="deleteRoom" class="itemMenuSubActionsManage deleteResource">Удалить комнату</div>
        </div>
      </div>
      <div class="itemMenuSubActions" v-if="!collapsedMenu && !isEmpty(menu.dot)">
        <div class="actions"
             :style="{ 'margin-top': '10px' }">
          <div @click="deleteLine" class="itemMenuSubActionsManage deleteResource">Удалить точку</div>
        </div>
      </div>
    </div>
  </main>
</template>

<script>
import axios from 'axios';
import 'vue-slider-component/theme/antd.css';
import VueSlider from 'vue-slider-component';
import '../assets/css/custom-dot.css';

export default {
  name: 'Dair',
  components: { 'vue-slider': VueSlider },
  data() {
    return {
      documentTitle: 'DND',
      dairMap: [],
      backgroundImage: `url(${require('../assets/images/dairs/meisters.jpg')})`,
      pathSave: 'http://localhost:5050/saveDair',
      pathGet: 'http://localhost:5050/getDair',

      minDairZoom: 30,
      dairZoom: 30,
      maxDairZoom: 90,
      canvas: null,
      context: null,
      isResizing: false,
      dairSizeY: 25,
      dairSizeX: 40,
      isDrawing: false,
      collapsedMenu: false,

      preSelectedGlobalAction: {},
      preSelectedGlobalSubAction1: {},
      preSelectedGlobalSubAction2: {},
      selectedGlobalAction: {
        id: 1,
      },
      selectedGlobalSubAction1: {
        id: 1,
      },
      selectedGlobalSubAction2: {
        id: 1,
      },
      globalSubActions1: {
        1: {
          id: 1,
          name: 'Карта',
          url: `url(${require('../assets/images/subactions/create.jpg')})`,
        },
        2: {
          id: 2,
          name: 'Персонажи',
          url: `url(${require('../assets/images/subactions/units.png')})`,
        },
      },
      globalSubActions2: {
        1: {
          id: 1,
          name: 'Общий вид',
          url: `url(${require('../assets/images/subactions/global.jpg')})`,
        },
        2: {
          id: 2,
          name: 'Ресурсы',
          url: `url(${require('../assets/images/subactions/resources.jpg')})`,
        },
        3: {
          id: 3,
          name: 'Здания',
          url: `url(${require('../assets/images/subactions/buildings.png')})`,
        },
        4: {
          id: 4,
          name: 'Специальные места',
          url: `url(${require('../assets/images/subactions/special.jpg')})`,
        },
        5: {
          id: 5,
          name: 'Юниты',
          url: `url(${require('../assets/images/subactions/units.png')})`,
        },
      },
      globalActions: {
        1: {
          id: 1,
          name: 'Подготовка',
          url: `url(${require('../assets/images/subactions/global.jpg')})`,
        },
        2: {
          id: 2,
          name: 'DND',
          url: `url(${require('../assets/images/subactions/resources.jpg')})`,
        },
      },

      rooms: [],
      lines: [],
      selectedRoom: {},
      selectedLine: {},
      selectedDot: {},
      preSelectedRoom: {},
      preSelectedLine: {},
      preSelectedDot: {},
      preSelectedIndex: -1,
      cursor: {
        selected: false,
        dot: false,
        dotCenter: false,
        upLeft: false,
        upRight: false,
        downRight: false,
        downLeft: false,
      },
      movingRoom: false,
      movingLine: false,
      defaultRoomW: 150,
      defaultRoomH: 150,
      defaultLineH: 10,
      defaultRoomS: 6,
      defaultFont: '18px serif',
      defaultSelectedColor: 'rgba(76, 185, 231, 0.3)',
      defaultCircleColor: 'rgba(76, 185, 231, 0.9)',
      defaultSelectedCircleColor: 'rgba(255,72,72,0.82)',
      defaultSubCircleColor: 'rgba(76, 185, 231, 0.5)',
      defaultCircleSize: 3,
      minRoomSize: 40,

      color: 0,
      colors: {
        1: {
          id: 1,
          color: '#e18ffd',
          colorSecond: 'rgba(185,54,255,0.26)',
        },
        2: {
          id: 2,
          color: '#91ff8f',
          colorSecond: 'rgba(74,255,54,0.26)',
        },
        3: {
          id: 3,
          color: '#8ad3fd',
          colorSecond: 'rgba(54,171,255,0.25)',
        },
        4: {
          id: 4,
          color: '#fdc98d',
          colorSecond: 'rgba(255,188,54,0.26)',
        },
        5: {
          id: 5,
          color: '#fd8d8d',
          colorSecond: 'rgba(255,54,54,0.26)',
        },
        6: {
          id: 6,
          color: 'rgb(222,222,222)',
          colorSecond: 'rgba(180, 180, 179, 0.3)',
        },
        7: {
          id: 7,
          color: 'rgb(153,153,153)',
          colorSecond: 'rgba(180, 180, 179, 0.3)',
        },
      },
    };
  },
  methods: {
    loadAll() {
      let container = document.getElementById('container');
      this.canvas = document.getElementById('canvas');
      this.context = this.canvas.getContext('2d');
      this.canvas.width = container.clientWidth;
      this.canvas.height = container.clientHeight;
      this.redraw();
    },
    newRoom() {
      this.up();
      let num = this.rooms.length + 1;
      let room = {
        x: this.canvas.width / 2 - this.defaultRoomW / 2,
        y: this.canvas.height / 2 - this.defaultRoomH / 2,
        name: 'Комната ' + num,
        width: this.defaultRoomW,
        height: this.defaultRoomH,
        color: 6,
        minRoomSize: 0,
      };
      this.updateRoomFont(room);
      this.rooms.push(room);
      this.selectedRoom = room;
      this.redraw();
    },
    newLine() {
      this.up();
      let line = {
        dots: [
          {
            x: this.canvas.width / 2 - this.defaultRoomW / 2,
            y: this.canvas.height / 2,
          },
          {
            x: this.canvas.width / 2 + this.defaultRoomW / 2,
            y: this.canvas.height / 2,
          },
        ],
        color: 7,
        width: this.defaultLineH,
      };
      this.lines.push(line);
      this.selectedLine = line;
      this.redraw();
    },
    drawLines() {
      for (let i = 0; i < this.lines.length; i++) {
        let line = this.lines[i];
        this.context.lineJoin = 'round';
        this.context.lineCap = 'round';
        this.context.beginPath();
        this.context.moveTo(line.dots[0].x, line.dots[0].y);
        for (let j = 1; j < line.dots.length; j++) {
          this.context.lineWidth = line.width;
          this.context.strokeStyle = this.colors[line.color].color;
          this.context.lineTo(line.dots[j].x, line.dots[j].y);
          this.context.stroke();
        }
        for (let j = 0; j < line.dots.length; j++) {
          if (line === this.selectedLine && j !== line.dots.length - 1) {
            this.context.beginPath();
            this.context.lineWidth = 1;
            this.context.fillStyle = this.defaultSubCircleColor;
            this.context.strokeStyle = 'black';
            this.context.arc((line.dots[j].x + line.dots[j + 1].x) / 2, (line.dots[j].y + line.dots[j + 1].y) / 2, this.defaultLineH / 2 - 1, 0, Math.PI * 2, false);
            this.context.fill();
            this.context.stroke();
          }
          if (line === this.selectedLine && !this.movingLine) {
            this.context.beginPath();
            this.context.fillStyle = this.selectedDot === line.dots[j] ? this.defaultSelectedCircleColor : this.defaultCircleColor;
            this.context.arc(line.dots[j].x, line.dots[j].y, this.defaultLineH / 2, 0, Math.PI * 2, false);
            this.context.fill();
          }
          this.context.beginPath();
          this.context.lineWidth = 1;
          this.context.strokeStyle = 'black';
          this.context.arc(line.dots[j].x, line.dots[j].y, this.defaultLineH / 2, 0, Math.PI * 2, false);
          this.context.stroke();
        }
      }
      this.context.lineWidth = 1;
    },
    drawRooms() {
      for (let i = 0; i < this.rooms.length; i++) {
        let room = this.rooms[i];
        this.context.fillStyle = (room === this.selectedRoom) ? this.defaultSelectedColor : this.colors[room.color].colorSecond;
        this.context.fill(new Path2D(this.roundedRectPath(room.x - this.defaultRoomS, room.y - this.defaultRoomS, room.width + this.defaultRoomS * 2, room.height + this.defaultRoomS * 2, 5)));
        this.context.fillStyle = 'white';
        this.context.fill(new Path2D(this.roundedRectPath(room.x, room.y, room.width, room.height, 5)));
        this.context.fillStyle = this.colors[room.color].color;
        this.context.fill(new Path2D(this.roundedRectPath(room.x, room.y, room.width, room.height, 5)));
        this.context.fillStyle = 'black';
        this.context.font = this.defaultFont;
        let text = this.context.measureText(room.name);
        this.context.fillText(room.name, room.x + (room.width - text.width) / 2, room.y + (room.height) / 2 - text.ideographicBaseline);
        this.context.strokeStyle = 'black';
        this.context.stroke(new Path2D(this.roundedRectPath(room.x, room.y, room.width, room.height, 5)));
        if (room === this.selectedRoom && !this.movingRoom) {
          this.context.beginPath();
          this.context.fillStyle = this.defaultCircleColor;
          this.context.arc(room.x, room.y, this.defaultCircleSize, 0, Math.PI * 2, false);
          this.context.fill();
          this.context.stroke();

          this.context.beginPath();
          this.context.fillStyle = this.defaultCircleColor;
          this.context.arc(room.x + room.width, room.y, this.defaultCircleSize, 0, Math.PI * 2, false);
          this.context.fill();
          this.context.stroke();

          this.context.beginPath();
          this.context.fillStyle = this.defaultCircleColor;
          this.context.arc(room.x + room.width, room.y + room.height, this.defaultCircleSize, 0, Math.PI * 2, false);
          this.context.fill();
          this.context.stroke();

          this.context.beginPath();
          this.context.fillStyle = this.defaultCircleColor;
          this.context.arc(room.x, room.y + room.height, this.defaultCircleSize, 0, Math.PI * 2, false);
          this.context.fill();
          this.context.stroke();
        }
      }
    },
    move(e) {
      if (this.cursor.selected && this.movingRoom) {
        let x = this.selectedRoom.x + e.movementX;
        let y = this.selectedRoom.y + e.movementY;
        if (x >= 0 && x + this.selectedRoom.width <= this.canvas.width) {
          this.selectedRoom.x += e.movementX;
        }
        if (y >= 0 && y + this.selectedRoom.height <= this.canvas.height) {
          this.selectedRoom.y += e.movementY;
        }
        this.redraw();
      } else if (this.cursor.upLeft && this.movingRoom) {
        let params = this.getMousePosition(e);
        if (this.selectedRoom.width - e.movementX >= this.selectedRoom.minRoomSize && params.x <= this.selectedRoom.x + e.movementX + this.selectedRoom.minRoomSize / 4) {
          this.selectedRoom.x += e.movementX;
          this.selectedRoom.width -= e.movementX;
        }
        if (this.selectedRoom.height - e.movementY >= this.minRoomSize && params.y <= this.selectedRoom.y + e.movementY + this.minRoomSize / 4) {
          this.selectedRoom.y += e.movementY;
          this.selectedRoom.height -= e.movementY;
        }
        this.redraw();
      } else if (this.cursor.upRight && this.movingRoom) {
        let params = this.getMousePosition(e);
        if (this.selectedRoom.width + e.movementX >= this.selectedRoom.minRoomSize && params.x >= this.selectedRoom.x + this.selectedRoom.width + e.movementX - this.selectedRoom.minRoomSize / 4) {
          this.selectedRoom.width += e.movementX;
        }
        if (this.selectedRoom.height - e.movementY >= this.minRoomSize && params.y <= this.selectedRoom.y + e.movementY + this.minRoomSize / 4) {
          this.selectedRoom.y += e.movementY;
          this.selectedRoom.height -= e.movementY;
        }
        this.redraw();
      } else if (this.cursor.downRight && this.movingRoom) {
        let params = this.getMousePosition(e);
        if (this.selectedRoom.width + e.movementX >= this.selectedRoom.minRoomSize && params.x >= this.selectedRoom.x + this.selectedRoom.width + e.movementX - this.selectedRoom.minRoomSize / 4) {
          this.selectedRoom.width += e.movementX;
        }
        if (this.selectedRoom.height + e.movementY >= this.minRoomSize && params.y >= this.selectedRoom.y + this.selectedRoom.height + e.movementY - this.minRoomSize / 4) {
          this.selectedRoom.height += e.movementY;
        }
        this.redraw();
      } else if (this.cursor.downLeft && this.movingRoom) {
        let params = this.getMousePosition(e);
        if (this.selectedRoom.width - e.movementX >= this.selectedRoom.minRoomSize && params.x <= this.selectedRoom.x + e.movementX + this.selectedRoom.minRoomSize / 4) {
          this.selectedRoom.x += e.movementX;
          this.selectedRoom.width -= e.movementX;
        }
        if (this.selectedRoom.height + e.movementY >= this.minRoomSize && params.y >= this.selectedRoom.y + this.selectedRoom.height + e.movementY - this.minRoomSize / 4) {
          this.selectedRoom.height += e.movementY;
        }
        this.redraw();
      } else if ((this.cursor.dot || this.cursor.dotCenter) && this.movingLine) {
        this.selectedDot.x += e.movementX;
        this.selectedDot.y += e.movementY;
        this.redraw();
      } else {
        this.updateCursor(e);
      }
    },
    leave() {
      this.movingRoom = false;
      this.movingLine = false;
      this.redraw();
    },
    up() {
      if (!this.cursor.selected && !this.cursor.upLeft && !this.cursor.upRight && !this.cursor.downRight && !this.cursor.downLeft) {
        this.selectedRoom = {};
        this.preSelectedRoom = {};
      }
      if (!this.cursor.dot && !this.cursor.dotCenter) {
        this.selectedLine = {};
        this.selectedDot = {};
        this.preSelectedLine = {};
        this.preSelectedDot = {};
        this.preSelectedIndex = -1;
      }
      this.leave();
    },
    down() {
      this.up();
      if (this.cursor.selected || this.cursor.upLeft || this.cursor.upRight || this.cursor.downRight || this.cursor.downLeft) {
        this.selectedRoom = this.preSelectedRoom;
        this.movingRoom = true;
        this.redraw();
      } else if (this.cursor.dot) {
        this.selectedDot = this.preSelectedDot;
        this.selectedLine = this.preSelectedLine;
        this.movingLine = true;
      } else if (this.cursor.dotCenter) {
        this.selectedDot = this.preSelectedDot;
        this.selectedLine = this.preSelectedLine;
        this.selectedLine.dots.splice(this.preSelectedIndex, 0, this.selectedDot);
        this.movingLine = true;
      }
    },
    redraw() {
      this.context.fillStyle = 'rgba(255, 255, 255, 1)';
      this.context.clearRect(0, 0, this.canvas.width, this.canvas.height);
      this.context.fillRect(0, 0, this.canvas.width, this.canvas.height);
      this.context.fill();
      this.drawLines();
      this.drawRooms();
    },
    setColor(color) {
      this.selectedRoom.color = color;
      this.redraw();
    },
    renameRoom() {
      this.updateRoomFont(this.selectedRoom);
      if (this.selectedRoom.width < this.selectedRoom.minRoomSize) {
        if (this.selectedRoom.x + this.selectedRoom.minRoomSize > this.canvas.width) {
          this.selectedRoom.x -= (this.selectedRoom.x + this.selectedRoom.minRoomSize) - this.canvas.width + 10;
        }
        this.selectedRoom.width = this.selectedRoom.minRoomSize;
      }
      this.redraw();
    },
    deleteRoom() {
      let index = this.rooms.indexOf(this.selectedRoom);
      this.rooms.splice(index, 1);
      this.up();
    },
    deleteLine() {
      if (this.selectedLine.dots.length === 2) {
        let index = this.lines.indexOf(this.selectedLine);
        this.lines.splice(index, 1);
      } else {
        let index = this.selectedLine.dots.indexOf(this.selectedDot);
        this.selectedLine.dots.splice(index, 1);
      }
      this.up();
    },
    collapseMenu() {
      this.collapsedMenu = !this.collapsedMenu;
    },
    updateRoomFont(room) {
      this.context.font = this.defaultFont;
      room.minRoomSize = this.context.measureText(room.name).width + 20;
    },
    isRoomSelected(room, params) {
      return params.x >= room.x && params.x <= room.x + room.width &&
        params.y >= room.y && params.y <= room.y + room.height;
    },
    isDotSelected(dot, params) {
      return params.x >= dot.x - this.defaultLineH / 2 - 0.5 && params.x <= dot.x + this.defaultLineH / 2 + 0.5 &&
        params.y >= dot.y - this.defaultLineH / 2 - 0.5 && params.y <= dot.y + this.defaultLineH / 2 + 0.5;
    },
    isDotCenterSelected(x, y, params) {
      return params.x >= x - this.defaultLineH / 2 + 0.5 && params.x <= x + this.defaultLineH / 2 - 0.5 &&
        params.y >= y - this.defaultLineH / 2 + 0.5 && params.y <= y + this.defaultLineH / 2 - 0.5;
    },
    isTopLeftSelected(room, params) {
      return params.x >= room.x - (this.defaultCircleSize + 2) && params.x <= room.x + (this.defaultCircleSize + 2) &&
        params.y >= room.y - (this.defaultCircleSize + 2) && params.y <= room.y + (this.defaultCircleSize + 2);
    },
    isTopRightSelected(room, params) {
      return params.x >= room.x + room.width - (this.defaultCircleSize + 2) && params.x <= room.x + room.width + (this.defaultCircleSize + 2) &&
        params.y >= room.y - (this.defaultCircleSize + 2) && params.y <= room.y + (this.defaultCircleSize + 2);
    },
    isBottomRightSelected(room, params) {
      return params.x >= room.x + room.width - (this.defaultCircleSize + 2) && params.x <= room.x + room.width + (this.defaultCircleSize + 2) &&
        params.y >= room.y + room.height - (this.defaultCircleSize + 2) && params.y <= room.y + room.height + (this.defaultCircleSize + 2);
    },
    isBottomLeftSelected(room, params) {
      return params.x >= room.x - (this.defaultCircleSize + 2) && params.x <= room.x + (this.defaultCircleSize + 2) &&
        params.y >= room.y + room.height - (this.defaultCircleSize + 2) && params.y <= room.y + room.height + (this.defaultCircleSize + 2);
    },
    clearCursorParams() {
      this.cursor.upLeft = false;
      this.cursor.upRight = false;
      this.cursor.downRight = false;
      this.cursor.downLeft = false;
      this.cursor.selected = false;
      this.cursor.dot = false;
      this.cursor.dotCenter = false;
    },
    isClearCursorParams() {
      return this.cursor.upLeft === false &&
      this.cursor.upRight === false &&
      this.cursor.downRight === false &&
      this.cursor.downLeft === false &&
      this.cursor.selected === false &&
      this.cursor.dot === false &&
      this.cursor.dotCenter === false;
    },
    updateCursor(e) {
      let params = this.getMousePosition(e);
      this.clearCursorParams();
      for (let i = 0; i < this.rooms.length; i++) {
        let room = this.rooms[i];
        if (this.isTopLeftSelected(room, params)) {
          this.clearCursorParams();
          this.cursor.upLeft = true;
          this.preSelectedRoom = room;
        } else if (this.isTopRightSelected(room, params)) {
          this.clearCursorParams();
          this.cursor.upRight = true;
          this.preSelectedRoom = room;
        } else if (this.isBottomRightSelected(room, params)) {
          this.clearCursorParams();
          this.cursor.downRight = true;
          this.preSelectedRoom = room;
        } else if (this.isBottomLeftSelected(room, params)) {
          this.clearCursorParams();
          this.cursor.downLeft = true;
          this.preSelectedRoom = room;
        } else if (this.isRoomSelected(room, params)) {
          this.clearCursorParams();
          this.cursor.selected = true;
          this.preSelectedRoom = room;
        }
      }
      if (!this.isClearCursorParams()) {
        return;
      }
      for (let i = 0; i < this.lines.length; i++) {
        let line = this.lines[i];
        for (let j = 0; j < line.dots.length; j++) {
          if (j !== line.dots.length - 1) {
            let x = line.dots[j].x + (line.dots[j + 1].x - line.dots[j].x) / 2;
            let y = line.dots[j].y + (line.dots[j + 1].y - line.dots[j].y) / 2;
            if (this.isDotCenterSelected(x, y, params)) {
              this.clearCursorParams();
              this.cursor.dotCenter = true;
              this.preSelectedDot = { x, y };
              this.preSelectedIndex = j + 1;
              this.preSelectedLine = line;
            }
          }
          if (this.isDotSelected(line.dots[j], params)) {
            this.clearCursorParams();
            this.cursor.dot = true;
            this.preSelectedDot = line.dots[j];
            this.preSelectedLine = line;
          }
        }
      }
    },
    getMousePosition(e) {
      let x;
      let y;
      if (e.pageX !== undefined && e.pageY !== undefined) {
        x = e.pageX;
        y = e.pageY;
      } else {
        x = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
        y = e.clientY + document.body.scrollTop + document.documentElement.scrollTop;
      }

      x -= this.canvas.getBoundingClientRect().left;
      y -= this.canvas.getBoundingClientRect().top;

      return { x, y };
    },
    roundedRectPath(x, y, w, h, ro) {
      let r = (Math.min(w, h) / 2 > ro) ? ro : Math.min(w, h) / 2;
      return `M ${x + r} ${y} l ${w - 2 * r} 0 q ${r} 0 ${r} ${r}
        l 0 ${h - 2 * r} q 0 ${r} ${-r} ${r}
        l ${-w + 2 * r} 0 q ${-r} 0 ${-r} ${-r}
        l 0 ${-h + 2 * r} q 0 ${-r} ${r} ${-r}`;
    },
    isEmpty(object) {
      return object === undefined || Object.keys(object).length === 0;
    },
    selectGlobalAction() {
      this.selectedGlobalAction = this.preSelectedGlobalAction;
      this.selectedGlobalSubAction1 = this.globalSubActions1[1];
      this.selectedGlobalSubAction2 = this.globalSubActions2[1];
    },
    selectGlobalSubAction1() {
      this.selectedGlobalSubAction1 = this.preSelectedGlobalSubAction1;
    },
    selectGlobalSubAction2() {
      this.selectedGlobalSubAction2 = this.preSelectedGlobalSubAction2;
    },
    globalClick(event) {},
    stopPropagation(event) {
      event.stopPropagation();
    },
  },
  computed: {
    cursorForm() {
      let result = '';
      if (this.cursor.upLeft) {
        result = 'nw-resize';
      } else if (this.cursor.upRight) {
        result = 'ne-resize';
      } else if (this.cursor.downRight) {
        result = 'nw-resize';
      } else if (this.cursor.downLeft) {
        result = 'ne-resize';
      } else if (this.cursor.selected) {
        result = 'move';
      } else if (this.cursor.dot) {
        result = 'pointer';
      } else if (this.cursor.dotCenter) {
        result = 'crosshair';
      }
      return result;
    },
    menu() {
      return {
        visible: !this.isEmpty(this.selectedRoom) || !this.isEmpty(this.selectedDot),
        room: this.selectedRoom,
        dot: this.selectedDot,
      };
    },
  },
  created() {
    document.title = this.documentTitle;
    window.addEventListener('resize', this.loadAll);
  },
  mounted() {
    this.loadAll();
  },
};
</script>
<style scoped>
@import url('https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css');
* {
  user-select:none;
  color: #F5F5F5;
}
#dairMap-main {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  position: fixed;
}
.dairMap-container {
  display: -webkit-box;
  overflow: hidden;
  /*padding-top: 10px;*/
  min-width: 100%;
  height: 100%;
  justify-content: center;
  align-items: start;
}
.dairMap-rooms {
  /*display: -webkit-box;*/
  /*overflow: scroll;*/
  /*padding-top: 10px;*/
  min-width: 100%;
  height: calc(100% - 50px);
  position: absolute;
  background: rebeccapurple;
  /*justify-content: center;*/
  /*align-items: start;*/
}
.dairMap-container::-webkit-scrollbar {
  display: block !important;
}
.modalContainer {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: max-content;
  /*height: 60%;*/
  /*border: 1px solid rgba(255, 214, 0, 0.8);*/
  /*box-shadow: 0 0 0 5px rgba(201, 255, 54, 0.2);*/
  /*border: 1px solid rgba(255, 255, 255, 1);*/
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border-radius: 12px;
  background: rgba(17, 16, 29, 0.85);
  padding: 10px;
}
.nextPeriodContainerItemResourcesContainer {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
  margin: 0 10px;
}
.nextPeriodContainerItemResources {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-evenly;
}
.nextPeriodContainerItem {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  margin-bottom: 20px;
  padding: 5px 10px;
  border-radius: 12px;
  /*border: var(--first-color);*/
}
.marketOwnersItem{
  font-size: 0.9em;
  margin: 7px;
  border-radius: 8px;
  display: flex;
  justify-content: center;
  width: 80%;
  padding: 1px 5px;
  position: relative;
  transition: all 0.1s ease;
  border: 2px solid rgba(0, 0, 0, 0);
}
.canSelectedMarketOwnersItem:hover {
  border-color:  var(--first-color) !important;
  color: rgba(255, 255, 255, 1) !important;
  cursor: pointer;
}
.marketOwners {
  display: flex;
  width: 200px;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  border-radius: 12px;
  margin: 5px;
}
.marketPlaceSubContainer {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: left;
  width: 100%;
}
.marketPlaceSubContainerTime {
  position: absolute;
  font-size: 0.9em;
  top: -1.1em;
  left: 0;
  opacity: 0.7;
}
.marketPlaceContainer {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: left;
  width: 100%;
}
.marketPlace {
  border: 1px solid;
  height: max-content;
  width: 350px;
  padding: 0 20px;
}
.modalContainerContainer {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-evenly;
  /*margin: 0 10px;*/
}
.marketOwnersSelected {
  border: var(--border-color) !important;
  box-shadow: var(--second-color) !important;
}
.modalWindow {
  position: fixed;
  width: 100%;
  height: 100%;
  background: rgba(17, 16, 29, 0.46);
  z-index: 100;
}
#itemMenu {
  position: absolute;
  background: rgba(17, 16, 29, 0.85);
  transition: all 0.15s ease;
  border-radius: 12px;
  bottom: 80px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: right;
  padding: 5px 10px 5px 10px;
  border: var(--first-color);
  box-shadow: var(--second-color);
}
.close:hover {
  color: #F5F5F5;
}
.save {
  font-size: 1.8em;
  position: absolute;
  right: 15px;
  opacity: .5;
  color: #F5F5F5;
}
.save:hover {
  opacity: 1;
  cursor: pointer;
  color: #46cd42 !important;
}
.itemMenuInfo {
  width: 100%;
  /*height: 100%;*/
  font-size: 0.9em;
}
.itemMenuManageActions i {
  font-size: 1.8em;
  padding: 6px;
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 8px;
  color: rgba(255, 255, 255, 0.7);
}
.itemMenuManageActions .actions {
  display: flex;
  flex-direction: column;
}
.itemMenuManageActions {
  width: 100%;
  display: flex;
  flex-direction: row;
  justify-content: space-evenly;
}
.itemMenuSubActionsResourcesContainer {
  position: absolute;
  bottom: -20px;
  width: 100%;
  display: flex;
  justify-content: space-evenly;
}
.itemMenuSubActionsManage, .itemMenuSubActionsManageOwner {
  font-size: 0.9em;
  margin: 3px;
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 8px;
  display: flex;
  justify-content: center;
  width: 90%;
  padding: 1px 5px;
  position: relative;
  transition: all 0.1s ease;
}
.itemMenuSubActionsManageOwner:hover {
  border-color:  var(--first-color) !important;
  color: rgba(255, 255, 255, 1) !important;
  cursor: pointer;
}
.itemMenuSubActionsManage:hover, .itemMenuSubActionsManageSelected {
  border-color:  rgba(255, 255, 255, 1);
  color: rgba(255, 255, 255, 1);
  cursor: pointer;
}
.cannotBuild, .deleteResource {
  border: 1px solid rgba(255, 0, 0, 0.4) !important;
  color: #ff4242 !important;
}
.deleteResource:hover {
  cursor: pointer;
  border: 1px solid red !important;
}
.cannotBuild:hover {
  cursor: unset !important;
}
.itemMenuSubActions {
  width: 100%;
  /*height: 100%;*/
  font-size: 0.9em;
  display: flex;
  flex-direction: column;
  justify-content: space-around;
}
.subtitle {
  font-size: 1em;
  margin-top: 15px;
  margin-bottom: 5px;
  width: 80%;
}
.title {
  font-size: 1.3em;
  margin-bottom: 15px;
  width: 100%;
  text-align: center;
}
.instrument-panel-title {
  position: relative;
  height: 0;
  padding-left: 10px;
  line-height: 0;
  font-size: 0.6em;
}
.instrument-panel-item {
  width: 100%;
  height: fit-content;
  border-radius: 15px;
  padding: 5px 15px 5px 15px;
  min-height: 30px;
  background: rgba(17, 16, 29, 0.5);
}
.instrument-panel-item-hover {
  transition: all 0.15s ease;
}
.instrument-panel-item-hover:hover {
  cursor: pointer;
  transform: scale(1.15);
  opacity: 1;
}
.instrument-panel-item-right:hover {
  cursor: pointer;
}
.instrument-panel-title-right {
  left: 50%;
  top: -10px;
  padding-left: 0;
  width: calc(100% + 20px);
  transform: translate(-50%, 0);
  font-size: 0.6em;
  text-align: center
}
.instrument-panel-item i {
  height: 32px;
  min-width: 32px;
  font-size: 32px;
  opacity: 0.5;
}
.instrument-panel-item-hover {
  transition: all 0.15s ease;
}
.instrument-panel-item-dair-selected {
  /*border: 1px solid #F5F5F5 !important;*/
  border: var(--first-color) !important;
}
.instrument-panel-item-dair-selected .instrument-panel-item-dair-text, .instrument-panel-item-dair-text:hover {
  background: var(--first-color);
}
.instrument-panel-item-dair:hover .instrument-panel-item-dair-text {
  border: var(--second-color);
}
.instrument-panel-item-dair-text {
  background: var(--second-color);
  border-radius: 3px;
  height: 32px;
  width: 32px;
  display: flex;
  justify-content: center;
  align-items: center;
  transition: all 0.15s ease;
}
.instrument-panel-item-dair {
  width: 40px;
  height: 40px;
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 5px;
  /*transition: none;*/
}
.monster {
  background-position: center;
  background-repeat: no-repeat;
  background-size: contain !important;
  width: 100%;
  height: 200px;
  position: relative;
  top: 20px;
  z-index: 1;
}
.itemMenuSubActions .actions {
  transition: all 0.22s ease;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  margin-bottom: 7px;
  /*height: 100%;*/
}
.itemMenuSubActions .actions p {
  margin: 0;
}
.submit:hover {
  cursor: pointer;
  filter: none;
}
.submit {
  border-radius: 5px;
  padding: 3px 10px 3px 10px;
  margin-top: 23px !important;
  margin-bottom: 5px !important;
  color: inherit;
  line-height: 0.9em;
  text-align: center;
  background: rgba(74,255,54,0.2);
  border: 1px solid rgba(74,255,54,0.5);
  transition: all 0.15s ease;
  font-size: 1.2em;
}
.submitYes:hover, submitNo:hover {
  border-color: #26ee20;
  /*border-color: #F5F5F5;*/
  /*background: linear-gradient(to right, rgba(0, 65, 106, 0.5), rgba(121, 159, 12, 0.5), rgba(255, 224, 0, 0.5));*/
}
#destroy {
  font-size: 0.9em;
}
.itemMenuActions {
  width: 100%;
  height: 100%;
  font-size: 0.9em;
  display: flex;
  justify-content: space-around;
}
.itemMenuActions .actions, .marketActions {
  border: 1px solid rgba(255, 255, 255, 0.2);
  transition: all 0.15s ease;
  color: rgba(255, 255, 255, 0.7);
  border-radius: 8px;
  margin: 6px;
  padding: 6px;
  font-size: 2.3em;
}
.itemMenuActions .actions:hover, .itemMenuActionsSelected, .itemMenuManageActions i:hover, .footerResourcesSettings:hover, .marketActionsTradable:hover, .top-panel-item-actions:hover, .footerResourcesMap:hover {
  border-color:  rgba(255, 255, 255, 1) !important;
  color: rgba(255, 255, 255, 1) !important;
  cursor: pointer;
}
.itemMenuText {
  position: absolute;
  top: -1.3em;
  left: 5px;
  font-size: 0.8em;
}
.itemMenuTextAction {
  font-size: 0.8em;
}
.itemMenuTextSubAction {
  font-size: 0.8em;
}
.itemMenuValue {
  margin-left: 10px;
  font-size: 1em;
}
.itemMenuContainer {
  /*height: 30px;*/
  display : flex;
  align-items: center;
  margin-bottom: 1.3em;
  position: relative;
}
.itemMenuContainerActions {
  display : flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  /*margin-bottom: 1.3em;*/
  position: relative;
}
.itemMenuContainer i {
  font-size: 1.3em;
  cursor: unset;
  margin-left: 5px;
}
.top-panel {
  height: 80px;
  padding: 0 10px !important;
  justify-content: space-evenly !important;
  width: 100%;
}
.sub-top-panel {
  height: 80px;
}
.top-panel-container {
  height: 100%;
  width: 80%;
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-evenly !important;
}
.top-panel-item-sub-actions-1 {
  width: 42% !important;
}
.top-panel-item-sub-actions-1-selected {
  width: 53% !important;
}
.top-panel-item-sub-actions-1-pre-selected {
  width: 45% !important;
}
.top-panel-item-sub-actions-2 {
  width: 28% !important;
}
.top-panel-item-sub-actions-2-selected {
  width: 37% !important;
}
.top-panel-item-sub-actions-2-pre-selected {
  width: 30% !important;
}
.top-panel-item-sub-actions-3 {
  width: 17% !important;
}
.top-panel-item-sub-actions-4 {
  width: 17% !important;
}
.top-panel-item-sub-actions-4-selected {
  width: 33% !important;
}
.top-panel-item-sub-actions-4-pre-selected {
  width: 19% !important;
}
.top-panel-item-sub-actions-3-selected, .top-panel-item-sub-actions-4-selected {
  width: 25% !important;
  filter: none !important;
  border: var(--first-color);
  box-shadow: var(--second-color);
}
.top-panel-item-sub-actions-3-pre-selected, .top-panel-item-sub-actions-4-pre-selected {
  width: 20% !important;
  cursor: pointer;
  filter: none !important;
  box-shadow: var(--second-color);
}
.top-panel-item-sub-actions-1, .top-panel-item-sub-actions-2, .top-panel-item-sub-actions-3, .top-panel-item-sub-actions-4 {
  height: 66% !important;
}
.top-panel-item-actions {
  width: 40% !important;
}
.top-panel-item-actions-selected {
  width: 50% !important;
}
.top-panel-item-actions-pre-selected {
  width: 45% !important;
}
.top-panel-item-actions-pre-selected, .top-panel-item-sub-actions-1-pre-selected, .top-panel-item-sub-actions-2-pre-selected {
  cursor: pointer;
  filter: none !important;
  box-shadow: 0 0 0 5px rgba(255, 255, 255, 0.2);
}
.top-panel-item-actions-selected, .top-panel-item-sub-actions-1-selected, .top-panel-item-sub-actions-2-selected {
  filter: none !important;
  border: 2px solid #F5F5F5;
  box-shadow: 0 0 0 5px rgba(255, 255, 255, 0.2);
}
.top-panel-item {
  transition: all 0.22s ease;
  width: 15%;
  height: 63%;
  border-radius: 12px;
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
  margin-left: 5px;
  margin-right: 5px;
  background-position: center;
  background-size: cover;
  filter: grayscale(100%);
}
.top-panel-item-selected {
  width: 30% !important;
  filter: none;
  border: var(--first-color);
  box-shadow: var(--second-color);
}
.top-panel-item-pre-selected {
  width: 20% !important;
  cursor: pointer;
  filter: none;
  box-shadow: var(--second-color);
}
.dairMap-first-selected {
  width: 100% !important;
  filter: none;
  border: var(--first-color);
  box-shadow: var(--second-color);
}
.dairMap-first-pre-selected {
  width: 100% !important;
  cursor: pointer;
  filter: none;
  box-shadow: var(--second-color);
}
.top-panel p {
  width: fit-content !important;
  padding: 3px;
  border-radius: 3px;
  background: rgba(17, 16, 29, 0.85);
}
.footerResourcesSettings {
  display: flex;
  align-items: center;
  margin-left: 25px;
  padding: 5px 10px;
  color: rgba(255, 255, 255, 0.8);
  border: 1px solid rgba(255, 255, 255, 0.35);
  transition: all 0.15s ease;
  border-radius: 6px;
}
.footerResourcesMap {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  margin: 5px;
  padding: 3px;
  color: rgba(255, 255, 255, 0.8);
  border: 1px solid rgba(255, 255, 255, 0.35);
  transition: all 0.15s ease;
  border-radius: 6px;
}
.footerResources {
  display: flex;
  align-items: center;
  justify-content: space-around;
  position: absolute;
  left: 0;
  width: fit-content;
}
.footer {
  min-height: 50px;
  background: rgba(17, 16, 29, 0.85);
  padding-right: 20px;
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: right;
  z-index: 10;
}
.footer i {
  margin: 0 10px;
}
.footer p {
  width: 70px;
  margin: 0 0 0 5px;
  font-size: 0.9em;
  text-align: center;
  line-height: 1em;
}
.background {
  background: black;
  position: fixed;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: hidden;
  z-index: -1;
}
.background:before {
  content: '';
  background-image: var(--background-before-url);
  background-position: center;
  background-size: cover;
  transition: all 0.25s ease;
  position: absolute;
  margin: 0;
  padding: 0;
  width: 130%;
  height: 130%;
  /*left: -15%;*/
  /*top: -15%;*/
  filter: blur(4px);
}
</style>
