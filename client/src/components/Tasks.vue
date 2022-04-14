<template>
  <div class="main"
       :style="{ position: clear ? 'unset' : 'absolute' }"
       @click="mainClick">
    <search v-if="showSearch"
            @search="search"
            @changeFilterParameners="changeFilterParameters"
            :placeholder="'Поиск по задачам'"
            :style="clear ? { position: 'relative', boxShadow: 'none' } : {}"
            :settings="searchSettings"/>
    <div class="content" :style="{ margin: clear ? 0 : '80px 0 20px 80px',
                                   padding: clear ? 0 : '20px 0 0',
                                   overflow: clear ? 'visible' : 'scroll',
                                   gridTemplateColumns: 'repeat(auto-fill, minmax(calc(' + canvasSize + 'px + 54px + 1rem), calc(20% - 15px)))' }">
      <div :class="['task-item', 'bx', 'bx-plus', { 'task-item-hovered-create': loadedAll }]" style="height: 253px; border: 2px dashed"
           @click="createTask"
           v-if="searchValue === '' && !clear"/>
      <div :class="['task-item', { 'bx bx-loader-alt bx-super-spin': !loadedAll }]" v-for="(task, index) in tasks" :key="index"
           :style="{ minHeight: (canvasSize + 50) + 'px' }"
           @mouseleave="hoverTask = ''"
           @mouseenter="hoverTask = 'task-' + index">
        <div @click="renameTask(index)" v-if="searchSettings.showing !== 'all' && loadedAll && !clear" :class="['task-item-rename', 'bx', 'bx-rename', { 'task-item-hovered': hoverTask === 'task-' + index }]"></div>
        <div @click="deleteTask(index)" v-if="searchSettings.showing !== 'all' && loadedAll && !clear" :class="['task-item-delete', 'bx', 'bx-x', { 'task-item-hovered': hoverTask === 'task-' + index }]"></div>
        <div @click="watchTask(task)" v-if="loadedAll" :class="['task-item-watch', 'bx', 'bx-fullscreen', { 'task-item-hovered': hoverTask === 'task-' + index }]" :style="searchSettings.showing !== 'all' || clear ? {} : { height: '100%', top: 0,   borderRadius: '0.25rem' }"></div>
        <div @click="sendTask(index)" v-if="loadedAll && clear && !preloaded" :class="['task-item-watch', 'bx', 'bx-select-multiple', { 'task-item-hovered': hoverTask === 'task-' + index }]" :style="{ height: '50%', top: 0, borderBottomLeftRadius: 0, borderBottomRightRadius: 0, borderTopLeftRadius: '0.25rem', borderTopRightRadius: '0.25rem' }"></div>
        <div @click="sendDeleteTask(index)" v-if="loadedAll && preloaded" :class="['task-item-watch', 'bx', 'bx-refresh', { 'task-item-hovered': hoverTask === 'task-' + index }]" :style="{ height: '50%', top: 0, borderBottomLeftRadius: 0, borderBottomRightRadius: 0, borderTopLeftRadius: '0.25rem', borderTopRightRadius: '0.25rem' }"></div>
        <div class="task-description task-name">
          {{ task.name }}
        </div>
        <div class="canvas-container" :id="preloaded ? 'canvas-container-preloaded' : 'canvas-container'"
              :style="{ height: canvasSize + 'px' }">
          <img :src="task.content" class="img-responsive img-thumbnail">
        </div>
        <div class="task-description task-size">
          <i :class="['bx', `bx-dice-${task.complexity}`]"/>
        </div>
        <div class="task-description task-author">
          <p>{{ task.author }}</p>
        </div>
        <div class="task-description task-datetime">
          <p>{{ task.datetime }}</p>
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
import modalDialog from './Main/Dialog';
import modalTask from './Main/TaskDialog';
import Message from './Main/Message';
import Search from './Main/Search';

Vue.use(ModalWizard);

export default {
  name: 'Tasks',
  components: { 'search': Search, message: Message },
  data() {
    return {
      user: {},
      tasks: [],
      defaultTasks: [],

      pathGetTasks: 'http://localhost:5050/allTasks',
      pathRenameTask: 'http://localhost:5050/renameTask',
      pathDeleteTask: 'http://localhost:5050/deleteTask',

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
        this.filterTasks();
      }, 50);
    },
    changeFilterParameters(data) {
      this.filterParams = data['filterParams'];
    },
    mainClick(event) {
      this.$emit('mainClick', { event });
    },
    loadTasks() {
      const promises = this.tasks.map(task => this.getImage(new Blob(['data:image/jpeg;base64,' + btoa(unescape(encodeURIComponent(task.content)))]))
        .catch((err) => {
          console.error(err);
          this.showMessage('ошибка при загрузке',
            'подробности в консоли браузера',
            'error',
            5000);
        }));
      return Promise.all(promises)
        .then(() => {
          this.loadedAll = true;
        });
    },
    getImage(file) {
      return new Promise((resolve, reject) => {
        const fReader = new FileReader();
        const img = document.createElement('img');
        img.onload = () => {};
        fReader.onload = () => {
          img.src = fReader.result;
          resolve(this.getBase64Image(img));
        };
        fReader.readAsDataURL(file);
      });
    },
    getBase64Image(img) {
      const canvas = document.createElement('canvas');
      canvas.width = img.width;
      canvas.height = img.height;

      const ctx = canvas.getContext('2d');
      ctx.drawImage(img, 0, 0);
      const dataURL = canvas.toDataURL('image/jpg');
      return dataURL;
    },
    deleteTask(index) {
      this.deleteIndex = index;
      ModalWizard.open(modalDialog, {
        props: {
          title: 'удалить задачу?',
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
          placeholder: this.tasks[index].name,
          submit: this.submitRenameTask,
        },
      });
    },
    watchTask(task) {
      let hintMessage = Object.values(task.answer).length === 1 ?
        ('ответ - ' + task.answer[0]) :
        ('ответы - ' + Object.values(task.answer));
      ModalWizard.open(modalTask, {
        props: {
          taskTitle: task.name,
          taskName: task.content,
          taskAnswer: task.answer,
          taskAnswerType: task.typeOfResponse,
          taskСomplexity: task.complexity,
          showHintOnSubmit: true,
          hintErrorMessageOnSubmit: hintMessage,
          hintDelayOnSubmit: 3000,
          showHintInitial: true,
          hintMessageInitial: hintMessage,
          hintDelayInitial: 3000,
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
    sendTask(index) {
      this.$emit('addTask', { task: this.tasks[index] });
    },
    sendDeleteTask(index) {
      this.$emit('deleteTask', { index });
    },
    submitDeleteTask() {
      this.$modal.close();
      axios.post(this.pathDeleteTask, { id: this.tasks[this.deleteIndex].id })
        .then(() => {
          this.preloadTasks();
        })
        .catch((error) => {
          console.error(error);
          this.showMessage('ошибка при удалении',
            'подробности в консоли браузера',
            'error',
            5000);
        });
    },
    submitRenameTask(name) {
      this.$modal.close();
      if (name === '') {
        return;
      }
      axios.post(this.pathRenameTask, { id: this.tasks[this.renameIndex].id, newName: name })
        .then(() => {
          this.tasks[this.renameIndex].name = name;
        })
        .catch((error) => {
          console.error(error);
          this.showMessage('ошибка при переименовании',
            'подробности в консоли браузера',
            'error',
            5000);
        });
    },
    submitCreateTask(name) {
      this.$modal.close();
      let params = name === '' ? {} : { taskName: name };
      this.$router.push({ name: 'task-creator', params });
    },
    filterTasks() {
      let newTasks = [];
      for (let task of this.defaultTasks) {
        if (task[this.searchSettings.searchBy].toLowerCase().includes(this.searchValue) && (this.searchSettings.showing === 'all' || task.authorId === this.user.id)) {
          newTasks.push(task);
        }
      }
      this.tasks = newTasks;
      this.$nextTick(() => this.loadTasks());
    },
    preloadTasks() {
      axios.get(this.pathGetTasks)
        .then((res) => {
          this.defaultTasks = res.data.tasks;
          this.tasks = res.data.tasks;
          this.filterTasks();
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
        this.preloadTasks();
      } else {
        this.tasks = this.preloadedTasks;
        this.loadTasks();
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
    preloadedTasks: {
      type: Array,
      default: () => [],
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
  /*position:absolute;*/
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
  grid-gap: 15px;
  gap: 15px;
  overflow: scroll;
}
.task-item {
  height: max-content;
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
  /*height: 200px;*/
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
  top: 0.4rem;
  line-height: 1em;
  right: 0.5rem;
  font-size: 1.1em;
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
