<template>
  <main id="map-main">
    <div class="container">
      <div class="map" v-bind:style="{ minWidth: maxMapSize * sliderValue / 100 + 'px',
                                       maxWidth: maxMapSize * sliderValue / 100 + 'px',
                                       minHeight: maxMapSize * sliderValue / 100 + 'px',
                                       maxHeight: maxMapSize * sliderValue / 100 + 'px' }">
          <div v-for="(row, rowIndex) in map" :key="rowIndex" class="row">
            <div v-for="(item, itemIndex) in row" :key="itemIndex" class="item"
                 v-bind:style="{'background-color': mapColors[item] }">
            </div>
          </div>
      </div>
    </div>
    <div class="footer">
      <vue-slider v-model="sliderValue"
                  :tooltip-formatter="percentFormatter"
                  :min="minSliderValue"
                  :max="maxSliderValue"
                  :interval="1"/>
    </div>
  </main>
</template>

<script>
import 'vue-slider-component/theme/antd.css';
import VueSlider from 'vue-slider-component';
import axios from 'axios';

export default {
  name: 'Map',
  components: { VueSlider },
  data() {
    return {
      mapSize: 0,
      mapColors: [],
      map: [],
      maxMapSize: 0,
      minSliderValue: 0,
      sliderValue: 0,
      maxSliderValue: 100,
      percentFormatter: val => Math.round(this.maxMapSize * val / 100 / this.mapSize - 1) + ' px',
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
          this.sliderValue = 100;
          this.minSliderValue = (6 / this.maxMapSize * this.mapSize) >= 1 ? 100 : ((6 / this.maxMapSize * this.mapSize * 100) | 0);
          this.maxSliderValue = ((33 / this.maxMapSize * this.mapSize * 100) | 0);
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
    onResize() {
      const newMaxMapSize = Math.min(window.innerHeight, window.innerWidth) * 0.8;
      if (newMaxMapSize !== this.maxMapSize) {
        this.maxMapSize = newMaxMapSize;
      }
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
  padding: 15px;
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
  height: 10%;
  border-top: 1px solid black;
  padding-left: 5%;
  padding-right: 5%;
  display: flex;
  flex-direction: column;
  justify-content: center;
}
</style>
