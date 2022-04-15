<template>
  <main id="map-main" @mouseup="onDrawEnd">
    <div class="background"></div>
    <instrument-panel @changeParameters="changeCursorParameters"
                      :style="hideIfTesting"/>
    <left-menu @changeParameters="changeColorParameters"
               @openCloseMenu="openCloseMenu"
               @exitMap="exitMap"
               @changeMapName="changeMapName"
               :style="hideIfTesting"
               :imagesSrc="imagesSrc"
               :mapName="mapName"/>
    <div class="map-container" :style="mapStyle">
      <div :style="{ minWidth: getMapSizeX() + 'px',
                     maxWidth: getMapSizeX() + 'px',
                     minHeight: getMapSizeY() + 'px',
                     maxHeight: getMapSizeY() + 'px',
                     margin: isTesting ? 0 : '15px'}">
        <canvas id="mapCanvas"
                :style="{width: getMapSizeX() + 'px',
                         height: getMapSizeY() + 'px'}"
                @mousemove="move"
                @mouseleave="clearSelection"
                @mousedown="draw"/>
      </div>
    </div>
    <test-map @testMap="testMap"/>
    <message/>
    <span class="footer" :style="footerStyle">
      <div :class="['color-blindness', {'color-blindness-selected' : isColorBlindness}]"
            @click="changeColorBlindness">
        <div id="color-blindness-1"/>
        <div id="color-blindness-2"/>
      </div>
      <i class="bx bx-minus"/>
      <vue-slider v-model="mapZoom"
                  :tooltip-formatter="val => val + ' px'"
                  :min="minMapZoom"
                  :max="maxMapZoom"
                  :style="{margin: '0',
                           width: '200px'}"
                  @drag-start="() => isResizing = true"
                  @drag-end="() => {isResizing = false; drawCanvas();}"
                  @change="() => {if(!isResizing) drawCanvas()}">
        <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
          <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ value }}</div>
        </template>
      </vue-slider>
      <i class="bx bx-plus"/>
      <div :style="{ display: 'flex',
                     flexDirection: 'column'}">
        <p>w: {{ mapSizeX }}</p>
        <p>h: {{ mapSizeY }}</p>
      </div>
      <div :style="{ display: 'flex',
                     flexDirection: 'column'}">
        <p>x: {{ cursorPositionX + 1 }}</p>
        <p>y: {{ cursorPositionY + 1 }}</p>
      </div>
      <i class="bx bx-log-in save-map"
        @click="saveMap"/>
    </span>
    <div ref="hero" class="hero" :style="{display: isTesting ? 'block' : 'none',
                                          top: heroTop + 'px',
                                          left: heroLeft + 'px',
                                          '--hero-url': 'url(' + require(`../../assets/images/${heroDirections[heroDirection]}`) + ')'}"/>
  </main>
</template>

<script>
import 'vue-slider-component/theme/antd.css';
import Vue from 'vue';
import axios from 'axios';
import VueSlider from 'vue-slider-component';
import ModalWizard from 'vue-modal-wizard';
import Menu from './Menu';
import TestMap from './TestMap';
import Message from '../Main/Message';
import modal from '../Main/TaskDialog';
import InstrumentPanel from './InstrumentPanel';
import '../../assets/css/custom-dot.css';

Vue.use(ModalWizard);

export default {
  name: 'Map',
  components: { 'vue-slider': VueSlider, 'left-menu': Menu, 'instrument-panel': InstrumentPanel, 'test-map': TestMap, 'message': Message, ModalWizard },
  data() {
    return {
      pathSaveMap: 'http://localhost:5050/saveMap',
      documentTitle: 'Создание карты',
      mapSizeX: 50,
      mapSizeY: 50,
      taskCellCount: 10,
      map: [],
      currentMapName: '',

      oldSelectedItems: [],
      selectedItems: [],
      cursorSizeDelta: 1.5,
      cursorSize: 1,
      cursorSolid: false,
      cursorForm: 'circle',
      isMenuOpen: false,

      minMapZoom: 6,
      savedMapZoom: 6,
      mapZoom: 6,
      maxMapZoom: 32,

      canvas: null,
      context: null,
      spaceSize: 1,
      cursorPositionY: -1,
      cursorPositionX: -1,
      foneSrc: 'special/fone.jpeg',
      taskSrc: 'special/task.png',
      selectionSrc: 'special/selection.jpeg',

      drawValue: '',
      drawType: '',
      drawLocation: '',
      taskCount: 0,

      images: [],
      loadedCount: 0,
      imagesSrc: ['border/air_air/1.png',
        'border/air_air/2.png',
        'border/dungeon/1.gif',
        'border/dungeon/2.gif',
        'border/forest/1.png',
        'border/forest/2.png',
        'border/lake_kingdom/1.png',
        'border/lake_kingdom/2.jpeg',
        'border/village/1.jpeg',

        'room/air_air/1.png',
        'room/dungeon/1.png',
        'room/forest/1.png',
        'room/lake_kingdom/1.png',
        'room/village/1.png',
        'room/village/2.png',

        'trip/air_air/1.png',
        'trip/dungeon/1.png',
        'trip/forest/1.png',
        'trip/lake_kingdom/1.png',
        'trip/village/1.png',

        'hero/left.png',
        'hero/right.png',
        'hero/top.png',
        'hero/bottom.png',

        'special/selection.jpeg',
        'special/task.png',
        'special/fone.jpeg',
      ],
      colorBlindnessRoom: 'rgba(19,136,8,1)',
      colorBlindnessBorder: 'rgba(204,0,0,1)',
      isColorBlindness: false,
      isTesting: false,
      isTaskOpened: false,
      isResizing: false,
      isDrawing: false,
      cellSize: 32,
      borderType: 'border',
      roomType: 'room',
      roomTypes: ['room', 'trip'],
      heroTop: 0,
      heroLeft: 0,
      heroDirections: {
        'left': 'hero/left.png',
        'right': 'hero/right.png',
        'top': 'hero/top.png',
        'bottom': 'hero/bottom.png',
      },
      heroDirection: 'bottom',
    };
  },
  methods: {
    getMap() {
      if (this.linkedMap !== {} && this.linkedMap !== undefined) {
        this.mapSizeX = this.linkedMap.sizeX;
        this.mapSizeY = this.linkedMap.sizeY;
        this.$emit('initMapSize', { sizeX: this.mapSizeX, sizeY: this.mapSizeY });
        for (let y = 0; y < this.mapSizeY; y++) {
          let row = [];
          for (let x = 0; x < this.mapSizeX; x++) {
            row.push({
              type: this.linkedMap.map[y][x].type,
              location: this.linkedMap.map[y][x].location,
              task: this.linkedMap.map[y][x].task,
              taskCell: this.linkedMap.map[y][x].taskCell,
              heroPosition: this.linkedMap.map[y][x].heroPosition,
              src: this.linkedMap.map[y][x].src,
            });
          }
          this.map.push(row);
        }
      } else {
        let row = [];
        for (let y = 0; y < this.mapSizeY; y++) {
          row = [];
          for (let x = 0; x < this.mapSizeX; x++) {
            row.push({
              type: '',
              location: '',
              task: -1,
              taskCell: false,
              heroPosition: false,
              src: '',
            });
          }
          this.map.push(row);
        }
      }
      this.currentMapName = this.mapName;
      this.canvas = document.getElementById('mapCanvas');
      this.context = this.canvas.getContext('2d');
      this.loadedImages = 0;
      for (let i of this.imagesSrc) {
        let image = new Image(this.mapZoom - this.spaceSize, this.mapZoom - this.spaceSize);
        image.src = require(`../../assets/images/${i}`);
        image.onload = () => {
          this.loadedCount++;
          if (this.loadedCount === this.images.length) {
            this.drawCanvas();
            this.showMessage('создание карты',
              'правила: перемещение по карте - по комнатам и переходам. фон и стены - не проходимы.',
              'special',
              12000);
          }
        };
        this.images.push(image);
      }
    },
    move(e) {
      if (this.isTesting) {
        return;
      }
      let params = this.getItemPosition(e);
      let rowIndex = Math.floor(params.y / this.mapZoom);
      let itemIndex = Math.floor(params.x / this.mapZoom);
      if (rowIndex < 0) rowIndex = 0;
      if (rowIndex >= this.mapSizeY) rowIndex = this.mapSizeY - 1;
      if (itemIndex < 0) itemIndex = 0;
      if (itemIndex >= this.mapSizeX) itemIndex = this.mapSizeX - 1;

      if (this.cursorPositionY === rowIndex && this.cursorPositionX === itemIndex) {
        return;
      }
      this.cursorPositionY = rowIndex;
      this.cursorPositionX = itemIndex;
      this.oldSelectedItems = this.selectedItems;
      this.selectedItems = [];
      let tempCursorSize = this.cursorSize - 1;
      for (let y = rowIndex - tempCursorSize; y <= rowIndex + tempCursorSize; y++) {
        for (let x = itemIndex - tempCursorSize; x <= itemIndex + tempCursorSize; x++) {
          if (y < 0 || x < 0 || y >= this.mapSizeY || x >= this.mapSizeX) {
            continue;
          }

          let delta = (rowIndex === y && itemIndex === x) ?
            0 :
            Math.sqrt((rowIndex - y) ** 2 + (itemIndex - x) ** 2);

          let isCircle = this.cursorForm === 'circle' &&
            (this.cursorSolid && delta <= tempCursorSize ||
              !this.cursorSolid && tempCursorSize - delta <= this.cursorSizeDelta && tempCursorSize - delta >= 0 &&
              !(tempCursorSize === 1 && (rowIndex === y && itemIndex === x)));

          let isSquare = this.cursorForm !== 'circle' &&
            (this.cursorSolid ||
              y === rowIndex - tempCursorSize ||
              y === rowIndex + tempCursorSize ||
              x === itemIndex - tempCursorSize ||
              x === itemIndex + tempCursorSize);

          if (isCircle || isSquare) {
            this.selectedItems.push({ x, y });
          }
        }
      }
      this.drawSelection();
      if (this.isDrawing) {
        this.draw();
      }
    },
    clearSelection() {
      this.cursorPositionY = -1;
      this.cursorPositionX = -1;
      this.oldSelectedItems = this.selectedItems;
      this.selectedItems = [];
      this.drawSelection();
    },
    draw() {
      this.isDrawing = true;
      for (let i of this.selectedItems) {
        this.map[i.y][i.x].src = this.drawSrc();
        this.map[i.y][i.x].type = this.drawType;
        this.map[i.y][i.x].location = this.drawLocation;
      }
    },
    onDrawEnd() {
      this.isDrawing = false;
    },
    changeColorParameters(data) {
      this.drawValue = data['drawValue'];
      this.drawType = data['drawType'];
      if (this.drawLocation !== data['location']) {
        this.showMessage('смена локации',
          'новая локация: ' + data['locationText'],
          'info',
          1500);
      }
      this.drawLocation = data['location'];
      if (this.taskCount !== data['taskCount']) {
        this.showMessage('смена параметров',
          'ячеек для задач на карте: ' + data['taskCount'],
          'info',
          1500);
      }
      this.taskCount = data['taskCount'];
      let newMapSizeX = data['mapSizeX'];
      let newMapSizeY = data['mapSizeY'];
      if (this.mapSizeX !== newMapSizeX || this.mapSizeY !== newMapSizeY) {
        if (newMapSizeX > this.mapSizeX) {
          for (let y = 0; y < this.mapSizeY; y++) {
            for (let x = this.mapSizeX; x < newMapSizeX; x++) {
              if (x % 2 === 0) {
                this.map[y].push({
                  type: '',
                  location: '',
                  task: -1,
                  taskCell: false,
                  heroPosition: false,
                  src: '',
                });
              } else {
                this.map[y].unshift({
                  type: '',
                  location: '',
                  task: -1,
                  taskCell: false,
                  heroPosition: false,
                  src: '',
                });
              }
            }
          }
        } else if (newMapSizeX < this.mapSizeX) {
          for (let y = 0; y < this.mapSizeY; y++) {
            let cut = Math.floor((this.mapSizeX - newMapSizeX) / 2);
            this.map[y] = this.map[y].slice(cut, newMapSizeX + cut);
          }
        }
        if (this.mapSizeX !== newMapSizeX) {
          this.showMessage('смена параметров',
            'новая ширина: ' + newMapSizeX + ' блоков',
            'info',
            1500);
        }
        this.mapSizeX = newMapSizeX;
        if (newMapSizeY > this.mapSizeY) {
          for (let y = this.mapSizeY; y < newMapSizeY; y++) {
            let row = [];
            for (let x = 0; x < this.mapSizeX; x++) {
              row.push({
                type: '',
                location: '',
                task: -1,
                taskCell: false,
                heroPosition: false,
                src: '',
              });
            }
            if (y % 2 === 0) {
              this.map.push(row);
            } else {
              this.map.unshift(row);
            }
          }
        } else if (newMapSizeY < this.mapSizeY) {
          let cut = Math.floor((this.mapSizeY - newMapSizeY) / 2);
          this.map = this.map.slice(cut, newMapSizeY + cut);
        }
        if (this.mapSizeY !== newMapSizeY) {
          this.showMessage('смена параметров',
            'новая высота: ' + newMapSizeY + ' блоков',
            'info',
            1500);
        }
        this.mapSizeY = newMapSizeY;
        this.drawCanvas();
      }
    },
    openCloseMenu(data) {
      this.isMenuOpen = data['isOpen'];
    },
    getItemPosition(e) {
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
    changeCursorParameters(data) {
      this.cursorSolid = data['cursorSolid'];
      this.cursorForm = data['cursorForm'];
      this.cursorSize = data['cursorSize'];
    },
    getMapSizeX() {
      return this.mapSizeX * this.mapZoom;
    },
    getMapSizeY() {
      return this.mapSizeY * this.mapZoom;
    },
    getSrc(mapItem) {
      if (mapItem.src === '') {
        return this.foneSrc;
      }
      return `${mapItem.type}/${mapItem.location}/${mapItem.src}`;
    },
    drawCanvas() {
      this.oldSelectedItems = [];
      this.selectedItems = [];
      this.context.clearRect(0, 0, this.canvas.width, this.canvas.height);
      this.canvas.width = this.getMapSizeX();
      this.canvas.height = this.getMapSizeY();
      for (let y = 0; y < this.mapSizeY; y++) {
        for (let x = 0; x < this.mapSizeX; x++) {
          let image = this.images.at(this.imagesSrc.indexOf(this.map[y][x].src === '' ? this.foneSrc : this.map[y][x].src));
          this.drawImage(image, x, y, this.map[y][x].type);
        }
      }
    },
    drawSelection() {
      for (let i of this.oldSelectedItems) {
        this.context.clearRect(i.x * this.mapZoom,
          i.y * this.mapZoom,
          this.mapZoom - this.spaceSize,
          this.mapZoom - this.spaceSize);
        let image = this.images.at(this.imagesSrc.indexOf(this.map[i.y][i.x].src === '' ? this.foneSrc : this.map[i.y][i.x].src));
        this.drawImage(image, i.x, i.y, this.map[i.y][i.x].type);
      }
      for (let i of this.selectedItems) {
        this.context.clearRect(i.x * this.mapZoom,
          i.y * this.mapZoom,
          this.mapZoom - this.spaceSize,
          this.mapZoom - this.spaceSize);
        let image = this.images.at(this.imagesSrc.indexOf(this.drawValue === '' ? this.selectionSrc : this.drawSrc()));
        this.drawImage(image, i.x, i.y, this.drawType);
      }
    },
    drawSrc() {
      return this.drawValue === '' ? '' : this.drawType + '/' + this.drawLocation + '/' + this.drawValue;
    },
    drawImage(image, x, y, type) {
      if (this.isColorBlindness) {
        if (this.roomTypes.includes(type)) {
          this.context.fillStyle = this.colorBlindnessRoom;
        } else {
          this.context.fillStyle = this.colorBlindnessBorder;
        }
        this.context.fillRect(x * this.mapZoom,
          y * this.mapZoom,
          this.mapZoom - this.spaceSize,
          this.mapZoom - this.spaceSize);
      } else {
        this.context.drawImage(image,
          x * this.mapZoom,
          y * this.mapZoom,
          this.mapZoom - this.spaceSize,
          this.mapZoom - this.spaceSize);
      }
      if (this.map[y][x].taskCell) {
        this.context.clearRect(x * this.mapZoom,
          y * this.mapZoom,
          this.mapZoom - this.spaceSize,
          this.mapZoom - this.spaceSize);
        let taskImage = this.images.at(this.imagesSrc.indexOf(this.taskSrc));
        this.context.drawImage(taskImage,
          x * this.mapZoom,
          y * this.mapZoom,
          this.mapZoom - this.spaceSize,
          this.mapZoom - this.spaceSize);
      }
    },
    testMap(data) {
      if (data['isTesting']) {
        let testPosition = [];
        for (let y = 0; y < this.mapSizeY; y++) {
          for (let x = 0; x < this.mapSizeX; x++) {
            if (this.map[y][x].type === this.roomType) {
              testPosition.push({ x, y });
            }
          }
        }
        if (testPosition.length !== 0) {
          if (this.resetTasks()) {
            this.isTesting = data['isTesting'];
            this.savedMapZoom = this.mapZoom;
            this.mapZoom = this.maxMapZoom;
            this.$emit('closeMenu');
            this.$emit('setTesting', { isTesting: this.isTesting });
            this.showMessage('тестирование карты',
              'режим тестирования: перемещайтесь при помощи стрелок ← ↑ → ↓',
              'info',
              3000);
            this.drawCanvas();
            let testIndex = Math.round(Math.random() * testPosition.length);
            if (testIndex === testPosition.length && testPosition.length !== 0) {
              testIndex = testPosition.length - 1;
            }
            this.heroLeft = testPosition[testIndex].x * this.cellSize;
            this.heroTop = testPosition[testIndex].y * this.cellSize;
            this.$nextTick(() => this.$refs.hero.scrollIntoView({ behavior: 'smooth', block: 'center', inline: 'center' }));
          }
        } else {
          this.showMessage('ошибка смены режима',
            'для тестирования на карте должна быть хотя бы одна комната',
            'error',
            5000);
        }
      } else if (this.isTesting) {
        this.isTesting = data['isTesting'];
        this.mapZoom = this.savedMapZoom;
        this.$emit('setTesting', { isTesting: this.isTesting });
        this.showMessage('редактирование карты',
          'режим редактирования',
          'info',
          3000);
        this.clearTasks();
        this.drawCanvas();
      }
    },
    onScroll(e) {
      if (this.isTesting && !this.isTaskOpened) {
        e.preventDefault();
        e.stopPropagation();
        return false;
      }
      return true;
    },
    onScrollKey(e) {
      if (this.isTesting && ['Space', 'ArrowUp', 'ArrowDown', 'ArrowLeft', 'ArrowRight'].indexOf(e.code) > -1) {
        e.preventDefault();
        this.heroMove(e.code);
        return false;
      }
      return true;
    },
    heroMove(code) {
      let newHeroDocumentTop = this.heroTop;
      let newHeroDocumentLeft = this.heroLeft;
      let newHeroWindowTop = this.$refs.hero.getBoundingClientRect().top + this.cellSize / 2;
      let newHeroWindowLeft = this.$refs.hero.getBoundingClientRect().left + this.cellSize / 2;
      switch (code) {
        case 'ArrowUp':
          newHeroDocumentTop -= this.cellSize;
          newHeroWindowTop -= this.cellSize;
          if (newHeroDocumentTop < 0) {
            return;
          }
          this.heroDirection = 'top';
          break;
        case 'ArrowDown':
          newHeroDocumentTop += this.cellSize;
          newHeroWindowTop += this.cellSize;
          if (newHeroDocumentTop > (this.mapSizeY - 1) * this.cellSize) {
            return;
          }
          this.heroDirection = 'bottom';
          break;
        case 'ArrowLeft':
          newHeroDocumentLeft -= this.cellSize;
          newHeroWindowLeft -= this.cellSize;
          if (newHeroDocumentLeft < 0) {
            return;
          }
          this.heroDirection = 'left';
          break;
        case 'ArrowRight':
          newHeroDocumentLeft += this.cellSize;
          newHeroWindowLeft += this.cellSize;
          if (newHeroDocumentLeft > (this.mapSizeX - 1) * this.cellSize) {
            return;
          }
          this.heroDirection = 'right';
          break;
        default:
          break;
      }
      if ((this.roomTypes.includes(this.map[newHeroDocumentTop / this.cellSize][newHeroDocumentLeft / this.cellSize].type) ||
        this.map[newHeroDocumentTop / this.cellSize][newHeroDocumentLeft / this.cellSize].taskCell) && !this.isTaskOpened) {
        this.heroTop = newHeroDocumentTop;
        this.heroLeft = newHeroDocumentLeft;
        if (newHeroWindowTop < this.cellSize || newHeroWindowTop > window.innerHeight - this.cellSize ||
          newHeroWindowLeft < this.cellSize || newHeroWindowLeft > window.innerWidth - this.cellSize) {
          this.$nextTick(() => this.$refs.hero.scrollIntoView({ behavior: 'smooth', block: 'center', inline: 'center' }));
        }
        if (this.map[newHeroDocumentTop / this.cellSize][newHeroDocumentLeft / this.cellSize].task === 1) {
          this.isTaskOpened = true;
          ModalWizard.open(modal, {
            props: {
              // taskName: this.url,
              taskAnswer: { 0: '1' },
              showHintOnSubmit: true,
              hintErrorMessageOnSubmit: 'ответ - 1',
              hintDelayOnSubmit: 3000,
              showHintInitial: true,
              hintMessageInitial: 'ответ - 1',
              hintDelayInitial: 3000,
            },
            onClose: () => { this.isTaskOpened = false; },
          });
        }
      }
    },
    showMessage(title, message, messageType, delay, functionConfirm) {
      this.$emit('showMessage', { title, message, messageType, delay, functionConfirm });
    },
    changeColorBlindness() {
      this.isColorBlindness = !this.isColorBlindness;
      this.drawCanvas();
      if (this.isColorBlindness) {
        this.showMessage('цветовая слепота',
          'специальный режим: комнаты и переходы выделены зеленым. стены и фон - красным.',
          'info',
          5000);
      } else {
        this.showMessage('обычное отображение',
          'комнаты, переходы и стены отображаются как есть',
          'info',
          3000);
      }
    },
    clearTasks() {
      for (let y = 0; y < this.mapSizeY; y++) {
        for (let x = 0; x < this.mapSizeX; x++) {
          this.map[y][x].task = false;
          this.map[y][x].taskCell = false;
        }
      }
    },
    resetTasks() {
      let testTasks = [];
      for (let y = 0; y < this.mapSizeY; y++) {
        for (let x = 0; x < this.mapSizeX; x++) {
          this.map[y][x].task = false;
          this.map[y][x].taskCell = false;
          if (this.map[y][x].type === this.borderType &&
            ((y !== 0 && this.map[y - 1][x].type === this.roomType && !this.map[y - 1][x].task) ||
            (y !== this.mapSizeY - 1 && this.map[y + 1][x].type === this.roomType && !this.map[y + 1][x].task) ||
            (x !== 0 && this.map[y][x - 1].type === this.roomType && !this.map[y][x - 1].task) ||
            (x !== this.mapSizeX - 1 && this.map[y][x + 1].type === this.roomType && !this.map[y][x + 1].task))) {
            testTasks.push({ x, y });
          }
        }
      }
      if (testTasks.length < this.taskCount) {
        this.showMessage('ошибка смены режима',
          'для тестирования на карте должно быть ' + this.taskCount + ' ячеек-стен, граничащих с комнатами. имеется ' + testTasks.length + '.',
          'error',
          5000);
        return false;
      }
      while (testTasks.length > this.taskCount) {
        let testIndex = Math.floor(Math.random() * testTasks.length);
        testTasks.splice(testIndex, 1);
      }
      for (let task of testTasks) {
        this.map[task.y][task.x].taskCell = true;
      }
      for (let i = 0; i < 10; i++) {
        let task = testTasks.splice(Math.floor(Math.random() * testTasks.length), 1)[0];
        this.map[task.y][task.x].task = 1;
      }
      return true;
    },
    validateMap() {
      let testPosition = [];
      for (let y = 0; y < this.mapSizeY; y++) {
        for (let x = 0; x < this.mapSizeX; x++) {
          if (this.map[y][x].type === this.roomType) {
            testPosition.push({ x, y });
          }
        }
      }
      if (testPosition.length === 0) {
        this.showMessage('ошибка сохранения',
          'на карте должна быть хотя бы одна комната',
          'error',
          5000);
        return false;
      }

      let testTasks = [];
      this.taskCellCount = 10;
      for (let y = 0; y < this.mapSizeY; y++) {
        for (let x = 0; x < this.mapSizeX; x++) {
          this.map[y][x].task = false;
          this.map[y][x].taskCell = false;
          if (this.map[y][x].type === this.borderType &&
            ((y !== 0 && this.map[y - 1][x].type === this.roomType && !this.map[y - 1][x].task) ||
              (y !== this.mapSizeY - 1 && this.map[y + 1][x].type === this.roomType && !this.map[y + 1][x].task) ||
              (x !== 0 && this.map[y][x - 1].type === this.roomType && !this.map[y][x - 1].task) ||
              (x !== this.mapSizeX - 1 && this.map[y][x + 1].type === this.roomType && !this.map[y][x + 1].task))) {
            testTasks.push({ x, y });
          }
        }
      }
      if (testTasks.length < this.taskCount) {
        this.showMessage('ошибка сохранения',
          'на карте должно быть как минимум ' + this.taskCount + ' ячеек-стен, граничащих с комнатами. имеется ' + testTasks.length + '.',
          'error',
          5000);
        return false;
      }
      this.taskCellCount = testTasks.length;
      return true;
    },
    saveMap() {
      this.showMessage('сохранить карту',
        'закончить редактирование и сохранить карту?',
        'confirm',
        15000,
        this.sendSaveMap);
    },
    sendSaveMap() {
      if (!this.validateMap()) {
        return;
      }
      let data = {
        mapName: this.currentMapName.trim(),
        map: this.map,
        sizeX: this.mapSizeX,
        sizeY: this.mapSizeY,
        taskCellCount: this.taskCellCount,
        author: JSON.parse(localStorage.getItem('user')).id,
      };
      axios.post(this.pathSaveMap, data)
        .then(() => {
          this.$router.push('/maps');
        })
        .catch((error) => {
          console.error(error);
          this.showMessage('ошибка при сохранении',
            'подробности в консоли браузера',
            'error',
            5000);
        });
    },
    exitMap() {
      this.showMessage('выйти',
        'прервать редактирование и выйти?',
        'confirm-error',
        15000,
        () => { this.$router.push('/maps'); });
    },
    changeMapName(data) {
      this.currentMapName = data['newMapName'];
    },
  },
  computed: {
    hideIfTesting() {
      return this.isTesting ? {
        'display': 'none',
      } : {};
    },
    mapStyle() {
      return {
        'padding': this.isTesting ? '0' : '0 0 0 78px',
        'overflow': this.isTesting ? '' : 'scroll',
      };
    },
    footerStyle() {
      return {
        'margin-left': this.isMenuOpen ? '238px' : '78px',
        'display': this.isTesting ? 'none' : '',
        'transition': 'all 0.5s ease',
      };
    },
  },
  created() {
    window.addEventListener('wheel', this.onScroll, { passive: false });
    window.addEventListener('keydown', this.onScrollKey);
    document.title = this.documentTitle;
  },
  mounted() {
    if (!localStorage.getItem('user')) {
      this.$router.push('/login');
    } else if (JSON.parse(localStorage.getItem('user')).role === 1) {
      this.$router.push('/main');
    } else {
      window.onbeforeunload = () => true;
      this.getMap();
    }
  },
  destroyed() {
    window.removeEventListener('wheel', this.onScroll);
    window.removeEventListener('keydown', this.onScrollKey);
  },
  props: {
    linkedMap: {
      type: Object,
      default: () => {},
    },
    mapName: {
      type: String,
      default: 'новая карта',
    },
  },
};
</script>
<style scoped>
* {
  user-select:none
}
#map-main {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
}
/* div::-webkit-scrollbar {*/
/*  display: none;*/
/*}*/
.map-container {
  display: -webkit-box;
  min-width: 100%;
  height: 100%;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.map-container::-webkit-scrollbar {
  display: block !important;
}
.footer {
  color: #F5F5F5;
  min-height: 30px;
  border-top: 1px solid black;
  padding-left: 5%;
  padding-right: 10px;
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: right;
}
.footer i {
  margin: 0 10px;
}
.footer p {
  width: 36px;
  margin: 0 0 0 5px;
  font-size: 0.7em;
  text-align: center;
  line-height: 1em;
}
.hero {
  height: 31px;
  width: 31px;
  /*background: red;*/
  position: absolute;
}
.hero:after {
  content: '';
  background: var(--hero-url);
  top: -27px;
  left: 50%;
  transform: translate(-50%, 0);
  height: 54px;
  width: 21px;
  background-size: contain;
  background-repeat: no-repeat;
  position: absolute;
}
.hero:before {
  content: '';
  background: rgba(17, 16, 29, 0.85);
  -webkit-box-shadow: 0 0 12px 12px rgb(17 16 29 / 85%);
  box-shadow: 0 0 20px 20px rgb(17 16 29 / 85%);
  top: -27px;
  left: 50%;
  transform: translate(-50%, 0);
  height: 52px;
  width: 22px;
  border: none;
  border-radius: 5px;
  position: absolute;
}
.background {
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
  background-image: url('../../assets/images/special/background.jpg');
  position: absolute;
  margin: 0;
  padding: 0;
  width: 130%;
  height: 130%;
  left: -15%;
  top: -15%;
  filter: blur(10px);
}
.color-blindness #color-blindness-1,
.color-blindness #color-blindness-2 {
  margin: 0;
  width: 16px;
  height: 16px;
  border-radius: 50%;
  border: 1px solid rgba(17, 16, 29, 0.85);
}
.color-blindness {
  display: flex;
}
.color-blindness:hover {
  cursor: pointer;
}
#color-blindness-1 {
  transform: translate(8px, 0);
  z-index: 1;
  background: linear-gradient(to right, rgba(155, 23, 4, 0.99), rgba(255, 115, 0, 1));
}
#color-blindness-2 {
  background: linear-gradient(to right, #00416a, #799f0c, #ffe000);
}
#color-blindness-1:before,
#color-blindness-2:before {
  content: '';
  background: #F5F5F5;
  border: 1px solid rgba(17, 16, 29, 0.85);
  border-radius: 50%;
  transition: all .2s ease;
  opacity: 1;
  position: absolute;
  width: inherit;
  height: inherit;
  transform: translate(-1px, -1px);
}
.color-blindness-selected #color-blindness-1:before,
.color-blindness:hover #color-blindness-1:before,
.color-blindness-selected #color-blindness-2:before,
.color-blindness:hover #color-blindness-2:before {
  opacity: 0;
}
.save-map {
  font-size: 24px;
  transition: all 0.2s ease;
  background: linear-gradient(to right, #00416a, #799f0c, #ffe000);
  background-clip: text;
  -webkit-background-clip: text;
}
.save-map:hover {
  color:rgba(1,1,1,0);
  cursor: pointer;
}
</style>
