<template>
  <main id="map-main">
    <instrument-panel @changeParameters="changeParameters"/>
    <right-menu/>
    <div class="container">
      <div :style="{ minWidth: getMapSize() + 'px',
                     maxWidth: getMapSize() + 'px',
                     minHeight: getMapSize() + 'px',
                     maxHeight: getMapSize() + 'px'}">
        <canvas id="mapCanvas"
                :style="{width: getMapSize() + 'px', height: getMapSize() + 'px'}"
                @mousemove="onItemSelect"
                @mouseleave="onItemLeave"/>
      </div>
    </div>
    <div class="footer">
      <vue-slider v-model="mapSliderValue"
                  :tooltip-formatter="val => val + ' px'"
                  :min="minMapSliderValue"
                  :max="maxMapSliderValue"
                  :interval="1"
                  @change="() => paintCanvas()">
        <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
          <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ value }}</div>
        </template>
      </vue-slider>
    </div>
  </main>
</template>

<script>
import 'vue-slider-component/theme/antd.css';
import VueSlider from 'vue-slider-component';
import axios from 'axios';
import Menu from './Menu';
import InstrumentPanel from './InstrumentPanel';

export default {
  name: 'Map',
  components: { VueSlider, 'right-menu': Menu, 'instrument-panel': InstrumentPanel },
  data() {
    return {
      mapCount: 0,
      mapColors: [],
      map: [],
      minMapItemSize: 0,

      oldSelectedItems: [],
      selectedItems: [],
      hoveredItem: '',
      cursorSolid: false,
      cursorSize: 1,
      cursorSizeDelta: 1.5,
      cursorForm: 'circle',

      minMapSliderValue: 0,
      mapSliderValue: 0,
      maxMapSliderValue: 100,

      canvas: null,
      context: null,
      spaceSize: 1,
      rowIndex: -1,
      itemIndex: -1,
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
          this.maxMapSliderValue = 32;
          let row = [];
          for (let i = 0; i < this.mapCount; i++) {
            row = [];
            for (let j = 0; j < this.mapCount; j++) {
              row.push(1);
            }
            this.map.push(row);
          }
          this.canvas = document.getElementById('mapCanvas');
          this.context = this.canvas.getContext('2d');
          this.paintCanvas();
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
            this.selectedItems.push(i + ' ' + j);
          }
        }
      }
      this.paintSelection();
    },
    onItemLeave() {
      this.rowIndex = -1;
      this.itemIndex = -1;
      this.oldSelectedItems = this.selectedItems;
      this.selectedItems = [];
      this.paintSelection();
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
    paintCanvas() {
      this.oldSelectedItems = [];
      this.selectedItems = [];
      this.context.clearRect(0, 0, this.canvas.width, this.canvas.height);
      let size = this.mapSliderValue;
      this.canvas.width = this.getMapSize();
      this.canvas.height = this.getMapSize();
      for (let i = 0; i < this.mapCount; i++) {
        for (let j = 0; j < this.mapCount; j++) {
          this.context.fillStyle = this.mapColors[this.map[i][j]];
          this.context.fillRect(j * size, i * size, size - this.spaceSize, size - this.spaceSize);
        }
      }
    },
    paintSelection() {
      let x = -1;
      let y = -1;
      let size = this.mapSliderValue;
      for (let i of this.oldSelectedItems) {
        if (!this.selectedItems.includes(i)) {
          x = parseInt(i.split(' ')[0], 10);
          y = parseInt(i.split(' ')[1], 10);
          this.context.clearRect(x * size, y * size, size - this.spaceSize, size - this.spaceSize);
          this.context.fillStyle = this.mapColors[this.map[x][y]];
          this.context.fillRect(x * size, y * size, size - this.spaceSize, size - this.spaceSize);
        }
      }
      for (let i of this.selectedItems) {
        if (!this.oldSelectedItems.includes(i)) {
          x = parseInt(i.split(' ')[0], 10);
          y = parseInt(i.split(' ')[1], 10);
          this.context.clearRect(x * size, y * size, size - this.spaceSize, size - this.spaceSize);
          this.context.fillStyle = '#9CC6FF';
          this.context.fillRect(x * size, y * size, size - this.spaceSize, size - this.spaceSize);
        }
      }
    },
  },
  computed: {
    isItemSelected() {
      return (item) => {
        return item;
        // const rowItemIndex = this.getRowItemIndex(item);
        // return this.selectedItems.includes(rowItemIndex.rowIndex + ' ' + rowItemIndex.itemIndex);
      };
    },
    isItemHovered() {
      return (item) => {
        return item;
        // const rowItemIndex = this.getRowItemIndex(item);
        // return this.hoveredItem === rowItemIndex.rowIndex + ' ' + rowItemIndex.itemIndex;
      };
    },
  },
  created() {
    this.getMap();
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
.container {
  display: -webkit-box;
  min-width: 100%;
  height: 100%;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  overflow: scroll;
  padding: 15px 15px 15px 93px;
}
.row {
  height: 100%;
  width: 100%;
  display: flex;
  flex-direction: row;
  flex-wrap: nowrap;
  margin: 0.5px;
}
.item {
  width: 100%;
  height: 100%;
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
.custom-dot {
  width: fit-content;
  min-width: 110%;
  height: 110%;
  background-color: #F5F5F5;
  border: 1px solid #9cd5ff;
  color: rgba(17, 16, 29, 0.85);
  border-radius: 50%;
  transition: all .3s;
  font-size: 0.6em;
  text-align: center;
}
.custom-dot:hover {
  transform: scale(1.3);
  border-color: #36abff;
}
.custom-dot-focus {
  box-shadow: 0 0 0 5px rgba(54, 171, 255, 0.2);
  border-color: #36abff;
}
.selected-item {
  background-color: #9CC6FF !important;
}
.hovered-item:before {
  content: "\ee18";
}
</style>
