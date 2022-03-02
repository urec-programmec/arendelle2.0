<template>
  <main id="map-main" @mouseup="onDrawEnd">
    <instrument-panel @changeParameters="changeParameters" :style="getTestingDisplay"/>
    <left-menu @changeColor="changeColor" @openCloseMenu="openCloseMenu" :style="getTestingDisplay" ref="menu"
               :imagesSrc="imagesSrc"
               :imagesDirectory="imagesDirectory"/>
    <div :class="['container']" :style="getTestingMapStyles">
      <div :style="{ minWidth: getMapSize() + 'px',
                     maxWidth: getMapSize() + 'px',
                     minHeight: getMapSize() + 'px',
                     maxHeight: getMapSize() + 'px',
                     margin: isTesting ? 0 : '15px'}">
        <canvas id="mapCanvas"
                :style="{width: getMapSize() + 'px',
                         height: getMapSize() + 'px',
                         backgroundColor: 'hsl(222, 25%, 20%)'}"
                @mousemove="onItemSelect"
                @mouseleave="onItemLeave"
                @mousedown="draw"/>
      </div>
    </div>
    <save-map @testMap="testMap"/>
    <div class="footer" :style="getTestingDisplay">
      <vue-slider v-model="mapSliderValue"
                  :tooltip-formatter="val => val + ' px'"
                  :min="minMapSliderValue"
                  :max="maxMapSliderValue"
                  @drag-start="() => isResizing = true"
                  @dragging="() => isResizing = true"
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
import axios from 'axios';
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
      mapCount: 0,
      mapColors: [],
      map: [],
      minMapItemSize: 0,

      oldSelectedItems: [],
      selectedItems: [],
      cursorSolid: false,
      onTestCursorSize: 1,
      cursorSize: 1,
      cursorForm: 'circle',
      cursorSizeDelta: 1.5,
      isMenuOpen: false,

      minMapSliderValue: 0,
      mapSliderValue: 0,
      maxMapSliderValue: 100,

      canvas: null,
      context: null,
      spaceSize: 1,
      rowIndex: -1,
      itemIndex: -1,
      imagesDirectory: '../assets/images/',
      foneSrc: 'special/fone.jpeg',
      selectionSrc: 'special/selection.jpeg',
      drawValue: '',
      drawType: '',
      location: '',
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
      const path = 'http://localhost:5000/mapSettings';
      axios.get(path)
        .then((res) => {
          this.mapCount = res.data.mapCount;
          this.mapColors = res.data.mapColors;
          this.minMapItemSize = 6;
          this.mapSliderValue = 6;
          this.minMapSliderValue = 6;
          this.maxMapSliderValue = this.cellSize;
          let row = [];
          for (let i = 0; i < this.mapCount; i++) {
            row = [];
            for (let j = 0; j < this.mapCount; j++) {
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
            let image = new Image(this.mapSliderValue - this.spaceSize, this.mapSliderValue - this.spaceSize);
            image.src = require(`../assets/images/${i}`);
            this.images.push(image);
          }
          this.images.at(-1).onload = () => {
            this.drawCanvas();
          };
        })
        .catch((error) => {
          console.error(error);
        });
    },
    onItemSelect(e) {
      let params = this.getItemPosition(e);
      let rowIndex = Math.floor(params.x / this.mapSliderValue);
      let itemIndex = Math.floor(params.y / this.mapSliderValue);
      if (rowIndex < 0) rowIndex = 0;
      if (rowIndex >= this.mapCount) rowIndex = this.mapCount - 1;
      if (itemIndex < 0) itemIndex = 0;
      if (itemIndex >= this.mapCount) itemIndex = this.mapCount - 1;

      if (this.rowIndex === rowIndex && this.itemIndex === itemIndex) {
        return;
      }
      this.rowIndex = rowIndex;
      this.itemIndex = itemIndex;
      this.oldSelectedItems = this.selectedItems;
      this.selectedItems = [];
      let tempCursorSize = this.cursorSize - 1;
      for (let i = rowIndex - tempCursorSize; i <= rowIndex + tempCursorSize; i++) {
        for (let j = itemIndex - tempCursorSize; j <= itemIndex + tempCursorSize; j++) {
          if (i < 0 || j < 0 || i >= this.mapCount || j >= this.mapCount) {
            continue;
          }

          let delta = (rowIndex === i && itemIndex === j) ?
            0 :
            Math.sqrt((rowIndex - i) ** 2 + (itemIndex - j) ** 2);

          let isCircle = this.cursorForm === 'circle' &&
            (this.cursorSolid && delta <= tempCursorSize ||
              !this.cursorSolid && tempCursorSize - delta <= this.cursorSizeDelta && tempCursorSize - delta >= 0 &&
              !(tempCursorSize === 1 && (rowIndex === i && itemIndex === j)));

          let isSquare = this.cursorForm !== 'circle' &&
            (this.cursorSolid ||
              i === rowIndex - tempCursorSize ||
              i === rowIndex + tempCursorSize ||
              j === itemIndex - tempCursorSize ||
              j === itemIndex + tempCursorSize);

          if (isCircle || isSquare) {
            this.selectedItems.push({ x: i, y: j });
          }
        }
      }
      this.drawSelection();
      if (this.isDrawing) {
        this.draw();
      }
    },
    onItemLeave() {
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
        this.map[i.y][i.x].location = this.location;
      }
    },
    onDrawEnd() {
      this.isDrawing = false;
    },
    changeColor(data) {
      this.drawValue = data['drawValue'];
      this.drawType = data['drawType'];
      this.location = data['location'];
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
    changeParameters(data) {
      this.cursorSolid = data['cursorSolid'];
      this.cursorForm = data['cursorForm'];
      this.cursorSize = data['cursorSize'];
    },
    getMapSize() {
      return this.mapCount * this.mapSliderValue;
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
      this.canvas.width = this.getMapSize();
      this.canvas.height = this.getMapSize();
      for (let y = 0; y < this.mapCount; y++) {
        for (let x = 0; x < this.mapCount; x++) {
          let image = this.images.at(this.imagesSrc.indexOf(this.map[y][x].src === '' ? this.foneSrc : this.map[y][x].src));
          this.context.drawImage(image,
            x * this.mapSliderValue,
            y * this.mapSliderValue,
            this.mapSliderValue - this.spaceSize,
            this.mapSliderValue - this.spaceSize);
        }
      }
    },
    drawSelection() {
      for (let i of this.oldSelectedItems) {
        this.context.clearRect(i.x * this.mapSliderValue,
          i.y * this.mapSliderValue,
          this.mapSliderValue - this.spaceSize,
          this.mapSliderValue - this.spaceSize);
        let image = this.images.at(this.imagesSrc.indexOf(this.map[i.y][i.x].src === '' ? this.foneSrc : this.map[i.y][i.x].src));
        this.context.drawImage(image,
          i.x * this.mapSliderValue,
          i.y * this.mapSliderValue,
          this.mapSliderValue - this.spaceSize,
          this.mapSliderValue - this.spaceSize);
      }
      for (let i of this.selectedItems) {
        this.context.clearRect(i.x * this.mapSliderValue,
          i.y * this.mapSliderValue,
          this.mapSliderValue - this.spaceSize,
          this.mapSliderValue - this.spaceSize);
        let image = this.images.at(this.imagesSrc.indexOf(this.drawValue === '' ? this.selectionSrc : this.drawSrc()));
        this.context.drawImage(image,
          i.x * this.mapSliderValue,
          i.y * this.mapSliderValue,
          this.mapSliderValue - this.spaceSize,
          this.mapSliderValue - this.spaceSize);
      }
    },
    drawSrc() {
      return this.drawValue === '' ? '' : this.drawType + '/' + this.location + '/' + this.drawValue;
    },
    testMap(data) {
      this.isTesting = data['isTesting'];
      if (this.isTesting) {
        this.mapSliderValue = this.maxMapSliderValue;
        this.onTestCursorSize = this.cursorSize;
        this.cursorSize = 0;
        this.$emit('closeMenu');
      } else {
        this.mapSliderValue = this.minMapSliderValue;
        this.cursorSize = this.onTestCursorSize;
      }
      this.drawCanvas();

      let testPosition = [];
      if (this.isTesting) {
        for (let y = 0; y < this.mapCount; y++) {
          for (let x = 0; x < this.mapCount; x++) {
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
    getTestingDisplay() {
      return this.isTesting ? {
        'display': 'none',
      } : {};
    },
    getTestingMapStyles() {
      return {
        'padding': this.isTesting ? '0' : '0 0 0 78px',
        'overflow': this.isTesting ? '' : 'scroll',
      };
    },
    isItemSelected() {
      return (item) => {
        return item;
        // const rowItemIndex = this.getRowItemIndex(item);
        // return this.selectedItems.includes(rowItemIndex.rowIndex + ' ' + rowItemIndex.itemIndex);
      };
    },
  },
  created() {
    this.getMap();
  },
  mounted() {
    window.addEventListener('wheel', this.onScroll, { passive: false });
    window.addEventListener('keydown', this.onScrollKey);
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
.container {
  display: -webkit-box;
  min-width: 100%;
  height: 100%;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.container::-webkit-scrollbar {
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
