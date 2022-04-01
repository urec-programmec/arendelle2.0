<template>
  <div class="main"
       @click="mainClick">
    <search @search="search" @changeFilterParameners="changeFilterParameters"
            :placeholder="'Поиск по шаблонам заданий'"
            :settings="searchSettings"/>
    <div class="content">
      <div :class="['task-item', 'bx', 'bx-plus', { 'task-item-hovered-create': loadedAll }]" style="height: 253px; border: 1px dashed"
           @click="createTask"
           v-if="searchValue === ''"/>
      <div :class="['task-item', { 'bx bx-loader-alt bx-super-spin': !loadedAll }]" v-for="(task, index) in imagesSrc" :key="index"
           @mouseleave="hoverTask = ''"
           @mouseenter="hoverTask = 'task-' + index">
        <div @click="renameTask(index)" v-if="searchSettings.showing !== 'all' && loadedAll" :class="['task-item-rename', 'bx', 'bx-rename', { 'task-item-hovered': hoverTask === 'task-' + index }]"></div>
        <div @click="deleteTask(index)" v-if="searchSettings.showing !== 'all' && loadedAll" :class="['task-item-delete', 'bx', 'bx-x', { 'task-item-hovered': hoverTask === 'task-' + index }]"></div>
        <div @click="watchTask(task)" v-if="loadedAll" :class="['task-item-watch', 'bx', 'bx-fullscreen', { 'task-item-hovered': hoverTask === 'task-' + index }]" :style="searchSettings.showing !== 'all' ? {} : { height: '100%', top: 0,   borderRadius: '0.25rem' }"></div>
        <div class="task-description task-name">
          {{ 'Задача ' + index }}
        </div>
        <div class="canvas-container">
          <canvas :id="'task-' + index" :width="canvasSize + 'px'" :height="canvasSize + 'px'"/>
        </div>
<!--        <div class="task-description task-size">-->
<!--          {{ task.sizeX }} x {{ task.sizeY }}-->
<!--        </div>-->
<!--        <div class="task-description task-author">-->
<!--          <p>{{ task.author }}</p>-->
<!--        </div>-->
<!--        <div class="task-description task-datetime">-->
<!--          <p>{{ task.datetime }}</p>-->
<!--        </div>-->
      </div>
    </div>
  </div>
</template>

<script>
import ModalWizard from 'vue-modal-wizard';
import axios from 'axios';
import Vue from 'vue';
import modalDialog from './Main/Dialog';
import modalTask from './Main/TaskDialog';
import Search from './Main/Search';

Vue.use(ModalWizard);

export default {
  name: 'Tasks',
  components: { 'search': Search },
  data() {
    return {
      user: {},
      tasks: [],

      pathGetMap: 'http://localhost:5050/allMaps',
      pathRenameMap: 'http://localhost:5050/renameMap',
      pathDeleteMap: 'http://localhost:5050/deleteMap',

      searchValue: '',
      searchSettings: {
        searchBy: 'name',
        showing: 'all',
      },
      searchTimeout: null,
      hoverTask: '',
      renameIndex: -1,
      deleteIndex: -1,
      filterParams: {},
      canvasSize: 200,
      imagesSrc: ['tasks/task1.jpg',
        'tasks/task2.jpg',
        'tasks/task3.jpg',
        'tasks/task4.jpg',
        'tasks/task5.jpg',
        'tasks/task6.jpg',
        'tasks/task7.jpg',
        'tasks/task8.jpg',
        'tasks/task9.jpg',
        'tasks/task10.jpg',
        'tasks/task15.jpg',
        'tasks/task16.jpg',
        'tasks/task17.jpg',
        'tasks/task18.jpg',
        'tasks/task20.jpg',
        'tasks/task21.jpg',
        'tasks/task22.jpg',
        'tasks/task23.jpg',
        'tasks/task24.jpg',
        'tasks/task25.jpg',
        'tasks/task26.jpg',
        'tasks/task27.jpg',
        'tasks/task28.jpg',
        'tasks/task29.jpg',
        'tasks/task30.jpg',
        'tasks/task31.jpg',
        'tasks/task32.jpg',
        'tasks/task33.jpg',
        'tasks/task34.jpg',
        'tasks/task35.jpg',
        'tasks/task36.jpg',
        'tasks/task37.jpg',
        'tasks/task38.jpg',
        'tasks/task39.jpg',
        'tasks/task40.jpg',
        'tasks/task41.jpg',
        'tasks/task42.jpeg',
        'tasks/task42.jpg',
      ],
      images: {},
      loadedImages: 0,
      loadedAll: false,
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
    loadTasks() {
      this.loadedImages = 0;
      this.loadedAll = false;
      for (let i of this.imagesSrc) {
        if (!(i in this.images)) {
          let image = new Image(this.canvasSize, this.canvasSize);
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
        for (let j = 0; j < this.imagesSrc.length; j++) {
          this.$nextTick(() => {
            this.drawCanvas('task-' + j, this.images[this.imagesSrc[j]]);
          });
        }
      }
    },
    drawCanvas(id, image) {
      const canvas = document.getElementById(id);
      if (!canvas) {
        return;
      }
      const context = canvas.getContext('2d');
      context.clearRect(0, 0, this.canvasSize, this.canvasSize);
      context.drawImage(image,
        0,
        0,
        this.canvasSize,
        this.canvasSize);
      // let canvasItemSize = (this.canvasSize / Math.max(task.sizeX, task.sizeY));
      // for (let y = 0; y < task.sizeY; y++) {
      //   for (let x = 0; x < task.sizeX; x++) {
      //     let image = this.images[task.task[y][x].src === '' ? this.foneSrc : task.task[y][x].src];
      //
      //   }
      // }
    },
    deleteTask(index) {
      this.deleteIndex = index;
      ModalWizard.open(modalDialog, {
        props: {
          title: 'удалить шаблон задачи?',
          submit: this.submitDeleteTask,
          isConfirm: true,
        },
      });
    },
    renameTask(index) {
      this.renameIndex = index;
      ModalWizard.open(modalDialog, {
        props: {
          title: 'редактировать название',
          // placeholder: this.maps[index].name,
          submit: this.submitRenameTask,
        },
      });
    },
    watchTask(task) {
      ModalWizard.open(modalTask, {
        props: {
          taskName: task,
        },
      });
    },
    createTask() {
      ModalWizard.open(modalDialog, {
        props: {
          title: 'создать задачу',
          placeholder: 'название',
          submit: this.submitCreateTask,
        },
      });
    },
    submitDeleteTask() {
      this.$modal.close();
      // axios.post(this.pathDeleteMap, { id: this.maps[this.deleteIndex].id })
      //   .then(() => {
      //     this.preloadMaps();
      //   })
      //   .catch((error) => {
      //     console.log(error);
      //   });
    },
    submitRenameTask(name) {
      this.$modal.close();
      // if (name === '') {
      //   return;
      // }
      // axios.post(this.pathRenameMap, { id: this.maps[this.renameIndex].id, newName: name })
      //   .then(() => {
      //     this.maps[this.renameIndex].name = name;
      //   })
      //   .catch((error) => {
      //     console.log(error);
      //   });
    },
    submitCreateTask(name) {
      this.$modal.close();
      let params = name === '' ? {} : { taskName: name };
      this.$router.push({ name: 'task-creator', params });
    },
    filterTasks() {
      // let newMaps = [];
      // for (let task of this.defaultMaps) {
      //   if (task[this.searchSettings.searchBy].toLowerCase().includes(this.searchValue) && (this.searchSettings.showing === 'all' || task.authorId === this.user.id)) {
      //     newMaps.push(task);
      //   }
      // }
      // this.maps = newMaps;
      // this.$nextTick(() => this.loadMaps());
    },
    preloadTasks() {
      this.loadTasks();

      // axios.get(this.pathGetMap)
      //   .then((res) => {
      //     this.defaultMaps = res.data.maps;
      //     this.maps = res.data.maps;
      //     this.filterMaps();
      //   })
      //   .catch((error) => {
      //     console.error(error);
      //   });
    },
  },
  mounted() {
    if (localStorage.getItem('user')) {
      this.user = JSON.parse(localStorage.getItem('user'));
      this.preloadTasks();
    }
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
.task-item {
  height: max-content;
  min-height: 250px;
  background-color: rgba(241,243,244,0.19);
  border-radius: 0.25rem;
  border: 1px solid rgb(33, 37, 41);
  padding: 0 0.5rem 1.5rem 0.5rem;
  transition: all 0.2s ease;
  position: relative;
  color: #F5F5F5;
}
.task-item:before {
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
.task-description {
  position: absolute;
  line-height: 0.8em;
}
.task-description p {
  margin: 0;
}
.task-name {
  font-size: 0.9em;
  height: 100%;
  position: relative;
  margin: 0.5rem calc(50px + 0.5rem) 0.5rem 0;
  overflow: hidden;
  word-wrap: break-word;
}
.task-size {
  top: 0.6rem;
  line-height: 1em;
  right: 0.5rem;
  font-size: 0.8em;
}
.task-datetime,
.task-author {
  bottom: 0.1rem;
  font-size: 0.8em;
}
.task-author {
  left: 0.5rem;
}
.task-datetime {
  right: 0.5rem;
}
.task-description-container {
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
.task-item-watch,
.task-item-delete,
.task-item-rename {
  position: absolute;
  opacity: 0;
  background: rgba(33, 37, 41, 0.6);
  border: 1px solid;
  /*border-radius: 0.25rem;*/
  color: rgba(245, 245, 245, 0.7);
}
.task-item-watch:before,
.task-item-delete:before,
.task-item-rename:before {
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
.task-item-watch:hover,
.task-item-delete:hover,
.task-item-rename:hover,
.task-item-hovered-create:hover:before {
  background: rgba(33, 37, 41, 0.9);
  color: rgba(245, 245, 245, 1);
}
.task-item-watch {
  left: 0;
  top: 50%;
  height: 50%;
  width: 100%;
  border-bottom-left-radius: 0.25rem;
  border-bottom-right-radius: 0.25rem;
}
.task-item-rename {
  left: 0;
  top: 0;
  height: 50%;
  width: 50%;
  border-top-left-radius: 0.25rem;
}
.task-item-delete {
  left: 50%;
  top: 0;
  height: 50%;
  width: 50%;
  border-top-right-radius: 0.25rem;
}
.task-item-hovered-create:hover,
.task-item-hovered {
  opacity: 1;
  z-index: 1;
  cursor: pointer;
}
</style>
