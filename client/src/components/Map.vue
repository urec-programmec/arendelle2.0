<template>
  <main id="map-main">
    <instrument-panel @changeParameters="changeParameters"/>
    <right-menu/>
    <div class="container">
      <div class="map" style="display: none !important;"
           :style="{ minWidth: maxMapSize * mapSliderValue / 100 + 'px',
                                         maxWidth: maxMapSize * mapSliderValue / 100 + 'px',
                                         minHeight: maxMapSize * mapSliderValue / 100 + 'px',
                                         maxHeight: maxMapSize * mapSliderValue / 100 + 'px' }">
        <div v-for="(row, rowIndex) in map" :key="rowIndex" class="row">
          <div v-for="(item, itemIndex) in row"
               :key="itemIndex"
               :class="['item', { 'selected-item': isItemSelected(rowIndex, itemIndex), 'hovered-item': isItemHovered(rowIndex, itemIndex) }]"
               :style="{'background-color': mapColors[item]}"
               @mouseover="onItemHover(rowIndex, itemIndex)">
          </div>
        </div>
      </div>
    </div>
    <div class="footer">
      <vue-slider v-model="mapSliderValue"
                  :tooltip-formatter="val => pxFormatter(val) + ' px'"
                  :min="minMapSliderValue"
                  :max="maxMapSliderValue"
                  :interval="1">
        <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
          <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ pxFormatter(value) }}</div>
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
      mapSize: 0,
      mapColors: [],
      map: [],
      maxMapSize: 0,

      selectedItems: [],
      hoveredItem: '',
      cursorSolid: false,
      cursorSize: 1,
      cursorSizeDelta: 1.5,
      cursorForm: 'circle',

      minMapSliderValue: 0,
      mapSliderValue: 0,
      maxMapSliderValue: 100,

      pxFormatter: value => Math.round(this.maxMapSize * value / 100 / this.mapSize - 1),
    };
  },
  methods: {
    getMap() {
      const path = 'http://localhost:5000/mapSettings';
      axios.get(path)
        .then((res) => {
          this.mapSize = res.data.mapSize;
          this.mapColors = res.data.mapColors;
          this.maxMapSize = Math.min(window.innerHeight, window.innerWidth) * 0.8;
          this.mapSliderValue = 100;
          this.minMapSliderValue = (6 / this.maxMapSize * this.mapSize) >= 1 ? 100 : ((6 / this.maxMapSize * this.mapSize * 100) | 0);
          this.maxMapSliderValue = ((33 / this.maxMapSize * this.mapSize * 100) | 0);
          let row = [];
          for (let i = 0; i < this.mapSize; i++) {
            row = [];
            for (let j = 0; j < this.mapSize; j++) {
              row.push(1);
            }
            this.map.push(row);
          }
        })
        .catch((error) => {
          console.error(error);
        });
    },
    onItemHover(rowIndex, itemIndex) {
      this.selectedItems = [];
      let tempCursorSize = this.cursorSize - 1;
      for (let i = rowIndex - tempCursorSize; i <= rowIndex + tempCursorSize; i++) {
        for (let j = itemIndex - tempCursorSize; j <= itemIndex + tempCursorSize; j++) {
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
      if (this.cursorSize !== 1) {
        this.hoveredItem = rowIndex + ' ' + itemIndex;
      } else {
        this.hoveredItem = '';
      }
    },
    changeParameters(data) {
      this.cursorSolid = data['cursorSolid'];
      this.cursorForm = data['cursorForm'];
      this.cursorSize = data['cursorSize'];
    },
  },
  computed: {
    isItemSelected() {
      return (rowIndex, itemIndex) => {
        return this.selectedItems.includes(rowIndex + ' ' + itemIndex);
      };
    },
    isItemHovered() {
      return (rowIndex, itemIndex) => {
        return this.hoveredItem === rowIndex + ' ' + itemIndex;
      };
    },
  },
  mounted() {
    this.$nextTick(() => {
      window.addEventListener('resize', this.onResize);
    });
  },
  beforeDestroy() {
    window.removeEventListener('resize', this.onResize);
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
.map{
  display: flex;
  flex-direction: column;
  flex-wrap: nowrap;
  box-sizing: content-box;
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
  margin: 0.5px;
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
.x {
/*  bxs-map-pin
    bx-border-radius
    bxs-dashboard
    bx-terminal
    bxs-flag-alt
    bx-trip*/
}
</style>
