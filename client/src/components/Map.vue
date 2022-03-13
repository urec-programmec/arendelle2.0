<template>
  <main id="map-main" @mouseup="onDrawEnd">
    <instrument-panel @changeParameters="changeCursorParameters"
                      :style="hideIfTesting"/>
    <left-menu @changeParameters="changeColorParameters"
               @openCloseMenu="openCloseMenu"
               :style="hideIfTesting"
               :imagesSrc="imagesSrc"/>
    <div class="map-container" :style="mapStyle">
      <div :style="{ minWidth: getMapSizeX() + 'px',
                     maxWidth: getMapSizeX() + 'px',
                     minHeight: getMapSizeY() + 'px',
                     maxHeight: getMapSizeY() + 'px',
                     margin: isTesting ? 0 : '15px'}">
        <canvas id="mapCanvas"
                :style="{width: getMapSizeX() + 'px',
                         height: getMapSizeY() + 'px',
                         backgroundColor: 'hsl(222, 25%, 20%)'}"
                @mousemove="move"
                @mouseleave="clearSelection"
                @mousedown="draw"/>
      </div>
    </div>
    <save-map @testMap="testMap"/>
    <div class="footer" :style="hideIfTesting">
      <vue-slider v-model="mapZoom"
                  :tooltip-formatter="val => val + ' px'"
                  :min="minMapZoom"
                  :max="maxMapZoom"
                  @drag-start="() => isResizing = true"
                  @drag-end="() => {isResizing = false; drawCanvas();}"
                  @change="() => {if(!isResizing) drawCanvas()}">
        <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
          <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ value }}</div>
        </template>
      </vue-slider>
    </div>
    <div ref="hero" class="hero" :style="{display: isTesting ? 'block' : 'none',
                                          top: heroTop + 'px',
                                          left: heroLeft + 'px'}"/>
  </main>
</template>

<script>
import 'vue-slider-component/theme/antd.css';
import VueSlider from 'vue-slider-component';
import Menu from './Menu';
import SaveMap from './SaveMap';
import InstrumentPanel from './InstrumentPanel';

import '../assets/css/custom-dot.css';

export default {
  name: 'Map',
  components: { 'vue-slider': VueSlider, 'left-menu': Menu, 'instrument-panel': InstrumentPanel, 'save-map': SaveMap },
  data() {
    return {
      mapSizeX: 50,
      mapSizeY: 50,
      map: [],

      oldSelectedItems: [],
      selectedItems: [],
      cursorSizeDelta: 1.5,
      savedCursorSize: 1,
      cursorSize: 1,
      cursorSolid: false,
      cursorForm: 'circle',
      isMenuOpen: false,

      minMapZoom: 6,
      mapZoom: 6,
      maxMapZoom: 32,

      canvas: null,
      context: null,
      spaceSize: 1,
      rowIndex: -1,
      itemIndex: -1,
      foneSrc: 'special/fone.jpeg',
      selectionSrc: 'special/selection.jpeg',

      drawValue: '',
      drawType: '',
      drawLocation: '',

      images: [],
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

        'special/selection.jpeg',
        'special/fone.jpeg',
      ],
      isResizing: false,
      isDrawing: false,

      isTesting: false,
      heroTop: 0,
      heroLeft: 0,
      cellSize: 32,
      roomType: 'room',
    };
  },
  methods: {
    getMap() {
      // const path = 'http://localhost:5000/mapSettings';
      let row = [];
      for (let y = 0; y < this.mapSizeY; y++) {
        row = [];
        for (let x = 0; x < this.mapSizeX; x++) {
          row.push({
            type: '',
            location: '',
            task: false,
            src: '',
          });
        }
        this.map.push(row);
      }
      this.canvas = document.getElementById('mapCanvas');
      this.context = this.canvas.getContext('2d');
      for (let i of this.imagesSrc) {
        let image = new Image(this.mapZoom - this.spaceSize, this.mapZoom - this.spaceSize);
        image.src = require(`../assets/images/${i}`);
        this.images.push(image);
      }
      this.images.at(-1).onload = () => {
        this.drawCanvas();
      };
    },
    move(e) {
      let params = this.getItemPosition(e);
      let rowIndex = Math.floor(params.y / this.mapZoom);
      let itemIndex = Math.floor(params.x / this.mapZoom);
      if (rowIndex < 0) rowIndex = 0;
      if (rowIndex >= this.mapSizeY) rowIndex = this.mapSizeY - 1;
      if (itemIndex < 0) itemIndex = 0;
      if (itemIndex >= this.mapSizeX) itemIndex = this.mapSizeX - 1;

      if (this.rowIndex === rowIndex && this.itemIndex === itemIndex) {
        return;
      }
      this.rowIndex = rowIndex;
      this.itemIndex = itemIndex;
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
      this.rowIndex = -1;
      this.itemIndex = -1;
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
      this.drawLocation = data['location'];
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
                  task: false,
                  src: '',
                });
              } else {
                this.map[y].unshift({
                  type: '',
                  location: '',
                  task: false,
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
        this.mapSizeX = newMapSizeX;
        if (newMapSizeY > this.mapSizeY) {
          for (let y = this.mapSizeY; y < newMapSizeY; y++) {
            let row = [];
            for (let x = 0; x < this.mapSizeX; x++) {
              row.push({
                type: '',
                location: '',
                task: false,
                src: '',
              });
            }
            if (y % 2 === 0){
              this.map.push(row);
            } else {
              this.map.unshift(row);
            }
          }
        } else if (newMapSizeY < this.mapSizeY) {
          let cut = Math.floor((this.mapSizeY - newMapSizeY) / 2);
          this.map = this.map.slice(cut, newMapSizeY + cut);
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
          this.context.drawImage(image,
            x * this.mapZoom,
            y * this.mapZoom,
            this.mapZoom - this.spaceSize,
            this.mapZoom - this.spaceSize);
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
        this.context.drawImage(image,
          i.x * this.mapZoom,
          i.y * this.mapZoom,
          this.mapZoom - this.spaceSize,
          this.mapZoom - this.spaceSize);
      }
      for (let i of this.selectedItems) {
        this.context.clearRect(i.x * this.mapZoom,
          i.y * this.mapZoom,
          this.mapZoom - this.spaceSize,
          this.mapZoom - this.spaceSize);
        let image = this.images.at(this.imagesSrc.indexOf(this.drawValue === '' ? this.selectionSrc : this.drawSrc()));
        this.context.drawImage(image,
          i.x * this.mapZoom,
          i.y * this.mapZoom,
          this.mapZoom - this.spaceSize,
          this.mapZoom - this.spaceSize);
      }
    },
    drawSrc() {
      return this.drawValue === '' ? '' : this.drawType + '/' + this.drawLocation + '/' + this.drawValue;
    },
    testMap(data) {
      this.isTesting = data['isTesting'];
      if (this.isTesting) {
        this.mapZoom = this.maxMapZoom;
        this.savedCursorSize = this.cursorSize;
        this.cursorSize = 0;
        this.$emit('closeMenu');
      } else {
        this.mapZoom = this.minMapZoom;
        this.cursorSize = this.savedCursorSize;
      }
      this.drawCanvas();

      let testPosition = [];
      if (this.isTesting) {
        for (let y = 0; y < this.mapSizeY; y++) {
          for (let x = 0; x < this.mapSizeX; x++) {
            if (this.map[y][x].type === this.roomType) {
              testPosition.push({ x, y });
            }
          }
        }
        if (testPosition.length !== 0) {
          let testIndex = Math.round(Math.random() * testPosition.length);
          this.heroLeft = testPosition[testIndex].x * this.cellSize;
          this.heroTop = testPosition[testIndex].y * this.cellSize;
          this.$nextTick(() => this.$refs.hero.scrollIntoView({ behavior: 'smooth', block: 'center', inline: 'center' }));
        }
      }
    },
    onScroll(e) {
      if (this.isTesting) {
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
      let newHeroLeft = this.heroLeft;
      let newHeroTop = this.heroTop;
      switch (code) {
        case 'ArrowUp':
          newHeroTop -= this.cellSize;
          break;
        case 'ArrowDown':
          newHeroTop += this.cellSize;
          break;
        case 'ArrowLeft':
          newHeroLeft -= this.cellSize;
          break;
        case 'ArrowRight':
          newHeroLeft += this.cellSize;
          break;
        default:
          break;
      }
      if (this.map[newHeroTop / this.cellSize][newHeroLeft / this.cellSize].type === this.roomType) {
        this.heroLeft = newHeroLeft;
        this.heroTop = newHeroTop;
      }
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
  },
  created() {
    window.addEventListener('wheel', this.onScroll, { passive: false });
    window.addEventListener('keydown', this.onScrollKey);
  },
  mounted() {
    this.getMap();
  },
  destroyed() {
    window.removeEventListener('wheel', this.onScroll);
    window.removeEventListener('keydown', this.onScrollKey);
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
  min-height: 40px;
  border-top: 1px solid black;
  padding-left: 5%;
  padding-right: 5%;
  display: flex;
  flex-direction: column;
  justify-content: center;
}
.hero {
  height: 31px;
  width: 31px;
  background: red;
  position: absolute;
}
</style>
