<template>
  <div class="main"
    @click="mainClick">
    <search @search="search" @changeFilterParameners="changeFilterParameters"/>
    <div class="content">
      <div class="map-item" v-for="(map, index) in maps" :key="index">
        <canvas :id="'map-' + index" :width="canvasMapSize + 'px'" :height="canvasMapSize + 'px'"/>
      </div>
    </div>
  </div>
</template>

<script>
import Search from './Search';
import MAP_TEMPLATE from '@/assets/js/map-example.js';

export default {
  name: 'Maps',
  components: { 'search': Search },
  data() {
    return {
      searchValue: '',
      filterParams: {},
      canvasMapSize: 95,
    };
  },
  methods: {
    search(data) {
      this.searchValue = data['searchValue'];
    },
    changeFilterParameters(data) {
      this.filterParams = data['filterParams'];
    },
    mainClick(event) {
      this.$emit('mainClick', { event });
    },
    loadMaps() {
      for(let i = 0; i < this.maps.length; i++) {
        this.drawCanvas('map-' + i, this.maps[i]);
      }
    },
    drawCanvas(id, map) {
      const canvas = document.getElementById(id);
      const context = canvas.getContext('2d');
      context.fillStyle = 'rgba(204,0,0,1)';
      context.fillRect(0,0, this.canvasMapSize, this.canvasMapSize);
      context.fillRect(0,0, this.canvasMapSize, this.canvasMapSize);
      for (let y = 0; y < map.sizeY; y++) {
        for (let x = 0; x < map.sizeX; x++) {

        }
      }

      // context.fillRect(x * this.mapZoom,
      //   y * this.mapZoom,
      //   this.mapZoom - this.spaceSize,
      //   this.mapZoom - this.spaceSize);
      // image.src = require(`../../assets/images/${i}`);
    }
  },
  props: {
    maps: {
      type: Array,
      default: () => [
        {
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },
        {
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },{
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },
      ]
    },
  },
  mounted() {
    this.loadMaps();
  },
};
</script>

<style scoped>
.main {
  display: block;
  position:absolute;
  height:auto;
  bottom:0;
  top:0;
  left:0;
  right:0;
  transition: all 0.5s ease;
  overflow: hidden;
}
.main .content {
  position:inherit;
  height:auto;
  bottom:0;
  top:0;
  left:0;
  right:0;
  margin: 80px 20px 20px 80px;
  background-color: rgba(241,243,244,0.24);
  border-radius: 0.25rem;
  padding: 20px;
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  overflow: scroll;
}
.main .content::-webkit-scrollbar{
  display: block;
  width: 10px;
  height: 0;
}
.map-item {
  min-width: 150px;
  min-height: 100px;
  background-color: #F5F5F5;
  border-radius: 0.25rem;
  margin: 5px;
  border: 1px solid rgb(33, 37, 41);
  display: flex;
  align-items: center;
  justify-content: center;
}

</style>
