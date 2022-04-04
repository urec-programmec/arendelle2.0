<template>
  <div class="main"
       @click="mainClick">
    <div class="header">
      <toggle-switch :defaultItems="stageItems"
                     :selectedItem="stage"
                     :background-first-color="'rgba(241,243,244,0.15)'"
                     :background-second-color="'rgba(241,243,244,0.30)'"
                     :text-first-color="'#F5F5F5'"
                     :text-second-color="'#F5F5F5'"
                     :border-color="'rgba(0,0,0,0.5)'"
                     style="position: relative;"
                     @changeSelection="changeStage"/>
    </div>
    <div class="content">
      <timeline/>
    </div>
    <message/>
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

import TimeLine from './ChampionshipCreator/TimeLine';
import ToggleSwitch from './Main/ToggleSwitch';

Vue.use(ModalWizard);

export default {
  name: 'Championships',
  components: { 'search': Search, message: Message, timeline: TimeLine, 'toggle-switch': ToggleSwitch },
  data() {
    return {
      user: {},
      stageItems: [
        {
          type: '1',
          name: 'отборочный тур',
        },
        {
          type: '2',
          name: 'основной тур',
        },
        {
          type: '3',
          name: 'финальный тур',
        },
        {
          type: '4',
          name: 'специальный тур',
        },
      ],
      stage: '1',


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
    changeStage(data) {
      this.stage = data['selection'];
    },


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
  margin: 50px 0 20px 80px;
  /*background-color: rgba(241,243,244,0.24);*/
  border-radius: 0.25rem;
  padding-right: 10px;
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
  height: 200px;
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

.header {
  position: absolute;
  border: none;
  box-shadow: inset 0 -1px 0 rgb(255 255 255 / 12%);
  height: 50px;
  width: 100%;
  /*top: 20px;*/
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
