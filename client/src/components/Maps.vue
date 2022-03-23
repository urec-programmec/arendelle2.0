<template>
  <div class="main"
    @click="mainClick">
    <search @search="search" @changeFilterParameners="changeFilterParameters" :placeholder="'Поиск по шаблонам карт'"/>
    <div class="content">
      <div :class="['map-item', 'bx', 'bx-plus', { 'map-item-hovered': loadedAll }]" style="height: 100%; border: 1px dashed"
           @click="createMap"/>
      <div :class="['map-item', 'bx', { 'bx-copy': hoverMap === 'map-' + index },
                                      { 'bx-loader-alt bx-super-spin': !loadedAll },
                                      { 'map-item-hovered bordered-solid': loadedAll }]" v-for="(map, index) in maps" :key="index"
           @mouseleave="hoverMap = ''"
           @mouseenter="hoverMap = 'map-' + index"
           @click="copyMap(index)">
        <div class="map-description map-name">
          {{ map.name }}
        </div>
        <div class="canvas-container">
          <canvas :id="'map-' + index" :width="(canvasSize / Math.max(map.sizeX, map.sizeY) * map.sizeX) + 'px'"
                  :height="(canvasSize / Math.max(map.sizeX, map.sizeY) * map.sizeY) + 'px'"/>
        </div>
        <div class="map-description map-size">
          {{ map.sizeX }} x {{ map.sizeY }}
        </div>
        <div class="map-description map-author">
          <p>{{ map.author }}</p>
        </div>
        <div class="map-description map-datetime">
          <p>{{ map.datetime }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import MAP_TEMPLATE from '@/assets/js/map-example';
import ModalWizard from 'vue-modal-wizard';
import Vue from 'vue';
import modal from './Dialog';
import Search from './Search';

Vue.use(ModalWizard);

export default {
  name: 'Maps',
  components: { 'search': Search },
  data() {
    return {
      searchValue: '',
      hoverMap: '',
      copyIndex: -1,
      filterParams: {},
      canvasSize: 200,
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
      loadedImages: 0,
      loadedAll: false,
      images: [],
      foneSrc: 'special/fone.jpeg',
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
      for (let i of this.imagesSrc) {
        let image = new Image(4, 4);
        image.src = require(`../assets/images/${i}`);
        image.onload = () => {
          this.loadedImages++;
          if (this.loadedImages === this.images.length) {
            this.loadedAll = true;
            for (let i = 0; i < this.maps.length; i++) {
              this.drawCanvas('map-' + i, this.maps[i]);
            }
          }
        };
        this.images.push(image);
      }
    },
    drawCanvas(id, map) {
      const canvas = document.getElementById(id);
      const context = canvas.getContext('2d');
      let canvasItemSize = (this.canvasSize / Math.max(map.sizeX, map.sizeY));
      for (let y = 0; y < map.sizeY; y++) {
        for (let x = 0; x < map.sizeX; x++) {
          let image = this.images.at(this.imagesSrc.indexOf(map.map[y][x].src === '' ? this.foneSrc : map.map[y][x].src));
          context.drawImage(image,
            x * canvasItemSize,
            y * canvasItemSize,
            canvasItemSize,
            canvasItemSize);
        }
      }
    },
    copyMap(index) {
      this.copyIndex = index;
      ModalWizard.open(modal, {
        props: {
          title: 'скопировать и изменить',
          placeholder: 'название',
          submit: this.submitCopyMap,
        },
      });
    },
    createMap() {
      ModalWizard.open(modal, {
        props: {
          title: 'создать карту',
          placeholder: 'название',
          submit: this.submitCreateMap,
        },
      });
    },
    submitCopyMap(name) {
      this.$modal.close();
      this.$router.push({ name: 'map-creator', params: { linkedMap: this.maps[this.copyIndex] } });
    },
    submitCreateMap(name) {
      this.$modal.close();
      this.$router.push('map-creator');
    },
  },
  props: {
    maps: {
      type: Array,
      default: () => [
        {
          name: 'карта xxx',
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
        },
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
        },
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
        },
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
        },
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
        },
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
        },
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
        },
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
        },
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
        },
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
        },
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
        },
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
        },
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
        },
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
        },
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
        },
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
        },
        {
          name: 'карта 1',
          author: 'автор 1',
          datetime: '10.03.22',
          sizeX: 50,
          sizeY: 50,
          map: MAP_TEMPLATE,
        },
      ],
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
  margin: 80px 0 20px 80px;
  /*background-color: rgba(241,243,244,0.24);*/
  border-radius: 0.25rem;
  padding-top: 20px;
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(calc(254px + 1rem), calc(20% - 15px)) );
  grid-gap: 15px;
  gap: 15px;
  overflow: scroll;
}
.map-item {
  height: max-content;
  background-color: rgba(241,243,244,0.19);
  border-radius: 0.25rem;
  border: 1px solid rgb(33, 37, 41);
  padding: 0 0.5rem 1.5rem 0.5rem;
  transition: all 0.2s ease;
  position: relative;
  color: #F5F5F5;
}
.map-item:before {
  font-size: 2em;
  display: flex;
  align-items: center;
  justify-content: center;
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  border-radius: 0.25rem;
  /*z-index: 100;*/
  z-index: -1;
}
.map-item-hovered:hover:before {
  cursor: pointer;
  background: rgba(33, 37, 41, 0.9);
  z-index: 1;
}
.bordered-solid:hover:before {
  border: 1px solid #F5F5F5;
}
.bx-super-spin:before {
  animation: spin 2s linear infinite;
}
.canvas-container {
  width: 200px;
  height: 200px;
  border-radius: 0.25rem;
  position: relative;
  left: 50%;
  top: 50%;
  transform: translate(-50%, 0);
  bottom: 0;
}
.canvas-container canvas {
  border-radius: 0.25rem;
}
.main .content::-webkit-scrollbar{
  display: block;
  width: 10px;
  height: 0;
}
.main .content::-webkit-scrollbar-thumb {
  -webkit-border-radius: 10px;
  border-radius: 10px;
  padding: 2px;
  background: rgba(241,243,244,0.4);
  -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5);
}
.main .content::-webkit-scrollbar-thumb:hover {
  background: rgba(241,243,244,0.6);
  -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5);
}
.map-description {
  position: absolute;
  line-height: 0.8em;
}
.map-description p {
  margin: 0;
}
.map-name {
  font-size: 0.9em;
  height: 100%;
  position: relative;
  margin: 0.5rem calc(50px + 0.5rem) 0.5rem 0;
  overflow: hidden;
  word-wrap: break-word;
}
.map-size {
  top: 0.6rem;
  line-height: 1em;
  right: 0.5rem;
  font-size: 0.8em;
}
.map-datetime,
.map-author {
  bottom: 0.1rem;
  font-size: 0.8em;
}
.map-author {
  left: 0.5rem;
}
.map-datetime {
  right: 0.5rem;
}
.map-description-container {
  position: absolute;
  top: 1rem;
  left: 0.5rem;
  height: fit-content;
  max-height: calc(100% - 2rem);
  overflow: hidden;
  width: calc(100% - 200px - 1.5rem);
  border-radius: 0.25rem;
  background: rgba(241,243,244,0.14);
  box-shadow: 0 0 0 2px rgba(241,243,244,0.14);
}
</style>
