<template>
  <div class="main"
       :style="{ position: clear ? 'unset' : 'absolute' }"
       @click="mainClick">
    <search v-if="showSearch"
            @search="search"
            @changeFilterParameners="changeFilterParameters"
            :placeholder="'Поиск по картам'"
            :style="clear ? { position: 'relative', boxShadow: 'none' } : {}"
            :settings="searchSettings"/>
    <div class="content" :style="{ margin: clear ? 0 : '80px 0 20px 80px',
                                   padding: clear ? 0 : '20px 0 0',
                                   overflow: clear ? 'visible' : 'scroll',
                                   gridTemplateColumns: 'repeat(auto-fill, minmax(calc(' + canvasSize + 'px + 54px + 1rem), calc(20% - 15px)))'}">
      <div :class="['map-item', 'bx', 'bx-plus', { 'map-item-hovered-create': loadedAll }]" style="height: 253px; border: 2px dashed"
           @click="createMap"
           v-if="searchValue === '' && !clear"/>
      <div :class="['map-item', { 'bx bx-loader-alt bx-super-spin': !loadedAll }, { 'map-item-preloaded': preloaded }]" v-for="(map, index) in maps" :key="index"
           :style="{ minHeight: (canvasSize + 50) + 'px' }"
           @mouseleave="hoverMap = ''"
           @mouseenter="hoverMap = 'map-' + index">
        <div @click="renameMap(index)" v-if="searchSettings.showing !== 'all' && loadedAll && !clear" :class="['map-item-rename', 'bx', 'bx-rename', { 'map-item-hovered': hoverMap === 'map-' + index }]"></div>
        <div @click="deleteMap(index)" v-if="searchSettings.showing !== 'all' && loadedAll && !clear" :class="['map-item-delete', 'bx', 'bx-x', { 'map-item-hovered': hoverMap === 'map-' + index }]"></div>
        <div @click="copyMap(index)" v-if="loadedAll && !clear" :class="['map-item-copy', 'bx', 'bx-copy', { 'map-item-hovered': hoverMap === 'map-' + index }]" :style="searchSettings.showing !== 'all' ? {} : { height: '100%', top: 0,  borderRadius: '0.25rem' }"></div>
        <div @click="sendMap(index)" v-if="loadedAll && clear && !preloaded" :class="['map-item-copy', 'bx', 'bx-check-square', { 'map-item-hovered': hoverMap === 'map-' + index }]" :style="{ height: '100%', top: 0,  borderRadius: '0.25rem' }"></div>
        <div @click="sendDeleteMap()" v-if="loadedAll && preloaded" :class="['map-item-copy', 'bx', 'bx-refresh', { 'map-item-hovered': hoverMap === 'map-' + index }]" :style="{ height: '100%', top: 0,  borderRadius: '0.25rem' }"></div>
        <div class="map-description map-name">
          {{ map.name }}
        </div>
        <div class="canvas-container" :style="{ width: canvasSize + 'px', height: canvasSize + 'px' }">
          <canvas :id="(preloaded ? 'map-preloaded-' : 'map-') + map.id" :width="(canvasSize / Math.max(map.sizeX, map.sizeY) * map.sizeX) + 'px'"
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
    <message v-if="!clear"/>
  </div>
</template>

<script>
import ModalWizard from 'vue-modal-wizard';
import axios from 'axios';
import Vue from 'vue';
import modal from './Main/Dialog';
import Message from './Main/Message';
import Search from './Main/Search';

Vue.use(ModalWizard);

export default {
  name: 'Maps',
  components: { 'search': Search, message: Message },
  data() {
    return {
      pathGetMap: 'http://localhost:5050/allMaps',
      pathRenameMap: 'http://localhost:5050/renameMap',
      pathDeleteMap: 'http://localhost:5050/deleteMap',
      user: {},
      maps: [],
      defaultMaps: [],
      searchValue: '',
      searchSettings: {
        searchBy: 'name',
        showing: 'all',
      },
      searchTimeout: null,
      hoverMap: '',
      copyIndex: -1,
      renameIndex: -1,
      deleteIndex: -1,
      filterParams: {},
      defaultCanvasSize: 200,
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
      images: {},
      foneSrc: 'special/fone.jpeg',
    };
  },
  methods: {
    search(data) {
      this.searchValue = data['searchValue'].toLowerCase();
      this.searchSettings = data['settings'];
      if (this.searchTimeout) {
        clearTimeout(this.searchTimeout);
      }
      this.searchTimeout = setTimeout(() => {
        this.filterMaps();
      }, 50);
    },
    changeFilterParameters(data) {
      this.filterParams = data['filterParams'];
    },
    mainClick(event) {
      this.$emit('mainClick', { event });
    },
    loadMaps() {
      this.loadedImages = 0;
      this.loadedAll = false;
      for (let i of this.imagesSrc) {
        if (!(i in this.images)) {
          let image = new Image(4, 4);
          image.src = require(`../assets/images/${i}`);
          image.onload = () => {
            this.loadedImages++;
            this.drawAllCanvas();
          };
          this.images[i] = image;
        } else {
          this.loadedImages++;
          this.drawAllCanvas();
        }
      }
    },
    drawAllCanvas() {
      if (this.loadedImages === Object.keys(this.images).length) {
        this.loadedAll = true;
        for (let j = 0; j < this.maps.length; j++) {
          this.$nextTick(() => {
            this.drawCanvas((this.preloaded ? 'map-preloaded-' : 'map-') + this.maps[j].id, this.maps[j]);
          });
        }
      }
    },
    drawCanvas(id, map) {
      const canvas = document.getElementById(id);
      if (!canvas) {
        return;
      }
      const context = canvas.getContext('2d');
      context.clearRect(0, 0, this.canvasSize, this.canvasSize);
      let canvasItemSize = (this.canvasSize / Math.max(map.sizeX, map.sizeY));
      for (let y = 0; y < map.sizeY; y++) {
        for (let x = 0; x < map.sizeX; x++) {
          let image = this.images[map.map[y][x].src === '' ? this.foneSrc : map.map[y][x].src];
          context.drawImage(image,
            x * canvasItemSize,
            y * canvasItemSize,
            canvasItemSize,
            canvasItemSize);
        }
      }
    },
    deleteMap(index) {
      this.deleteIndex = index;
      ModalWizard.open(modal, {
        props: {
          title: 'удалить карту?',
          submit: this.submitDeleteMap,
          isConfirm: true,
        },
      });
    },
    renameMap(index) {
      this.renameIndex = index;
      ModalWizard.open(modal, {
        props: {
          title: 'редактировать название',
          placeholder: this.maps[index].name,
          submit: this.submitRenameMap,
        },
      });
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
    sendMap(index) {
      this.$emit('addMap', { map: this.maps[index] });
    },
    sendDeleteMap() {
      this.$emit('deleteMap', { map: {} });
    },
    submitDeleteMap() {
      this.$modal.close();
      axios.post(this.pathDeleteMap, { id: this.maps[this.deleteIndex].id })
        .then(() => {
          this.preloadMaps();
        })
        .catch((error) => {
          console.error(error);
          this.showMessage('ошибка при удалении',
            'подробности в консоли браузера',
            'error',
            5000);
        });
    },
    submitRenameMap(name) {
      this.$modal.close();
      if (name === '') {
        return;
      }
      axios.post(this.pathRenameMap, { id: this.maps[this.renameIndex].id, newName: name })
        .then(() => {
          this.maps[this.renameIndex].name = name;
        })
        .catch((error) => {
          console.error(error);
          this.showMessage('ошибка при переименовании',
            'подробности в консоли браузера',
            'error',
            5000);
        });
    },
    submitCopyMap(name) {
      this.$modal.close();
      let params = name === '' ?
        { linkedMap: this.maps[this.copyIndex], mapName: this.maps[this.copyIndex].name.concat(' копия').length > 50 ? this.maps[this.copyIndex].name : this.maps[this.copyIndex].name.concat(' копия') } :
        { linkedMap: this.maps[this.copyIndex], mapName: name };
      this.$router.push({ name: 'map-creator', params });
    },
    submitCreateMap(name) {
      this.$modal.close();
      let params = name === '' ? {} : { mapName: name };
      this.$router.push({ name: 'map-creator', params });
    },
    filterMaps() {
      let newMaps = [];
      for (let map of this.defaultMaps) {
        if (map[this.searchSettings.searchBy].toLowerCase().includes(this.searchValue) && (this.searchSettings.showing === 'all' || map.authorId === this.user.id)) {
          newMaps.push(map);
        }
      }
      this.maps = newMaps;
      this.$nextTick(() => this.loadMaps());
    },
    preloadMaps() {
      axios.get(this.pathGetMap)
        .then((res) => {
          this.defaultMaps = res.data.maps;
          this.maps = res.data.maps;
          this.filterMaps();
        })
        .catch((error) => {
          console.error(error);
          this.showMessage('ошибка при загрузке',
            'подробности в консоли браузера',
            'error',
            5000);
        });
    },
    showMessage(title, message, messageType, delay, functionConfirm) {
      this.$emit('showMessage', { title, message, messageType, delay, functionConfirm });
    },
  },
  mounted() {
    if (localStorage.getItem('user')) {
      this.user = JSON.parse(localStorage.getItem('user'));
      if (!this.preloaded) {
        this.preloadMaps();
      } else {
        this.maps = [];
        this.maps.push(this.preloadedMap);
        this.loadMaps();
      }
    }
  },
  props: {
    clear: {
      type: Boolean,
      default: false,
    },
    showSearch: {
      type: Boolean,
      default: true,
    },
    preloaded: {
      type: Boolean,
      default: false,
    },
    preloadedMap: {
      type: Object,
      default: () => {},
    },
    canvasSize: {
      type: Number,
      default: 200,
    },
  },
};
</script>

<style scoped>
.main {
  display: block;
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
  /*background-color: rgba(241,243,244,0.24);*/
  border-radius: 0.25rem;
  display: grid;
  grid-gap: 15px;
  gap: 15px;
  /*overflow: scroll;*/
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
  z-index: -1;
}
.bx-super-spin:before {
  animation: spin 2s linear infinite;
}
.canvas-container {
  border-radius: 0.25rem;
  position: relative;
  left: 50%;
  top: 50%;
  transform: translate(-50%, 0);
  bottom: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  overflow: hidden;
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
.map-item-copy,
.map-item-delete,
.map-item-rename {
  position: absolute;
  opacity: 0;
  background: rgba(33, 37, 41, 0.6);
  border: 1px solid;
  /*border-radius: 0.25rem;*/
  color: rgba(245, 245, 245, 0.7);
}
.map-item-copy:before ,
.map-item-delete:before ,
.map-item-rename:before {
  font-size: 2em;
  display: flex;
  align-items: center;
  justify-content: center;
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: -1;
}
.map-item-copy:hover,
.map-item-delete:hover,
.map-item-rename:hover,
.map-item-hovered-create:hover:before {
  background: rgba(33, 37, 41, 0.9);
  color: rgba(245, 245, 245, 1);
}
.map-item-rename {
  left: 0;
  top: 0;
  height: 50%;
  width: 50%;
  border-top-left-radius: 0.25rem;
}
.map-item-delete {
  left: 50%;
  top: 0;
  height: 50%;
  width: 50%;
  border-top-right-radius: 0.25rem;
}
.map-item-copy {
  left: 0;
  top: 50%;
  height: 50%;
  width: 100%;
  border-bottom-left-radius: 0.25rem;
  border-bottom-right-radius: 0.25rem;
}
.map-item-hovered-create:hover,
.map-item-hovered {
  opacity: 1;
  z-index: 1;
  cursor: pointer;
}
.map-item-preloaded {
  /*box-shadow: 0 0 15px 10px rgba(54, 171, 255, 0.2);*/
}
</style>
