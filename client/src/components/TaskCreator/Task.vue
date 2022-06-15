<template>
  <main id="task-main" @mouseup="onDrawEnd">
    <div class="background"></div>
    <left-menu @openCloseMenu="openCloseMenu"
               @exitMap="exitTask"
               @changeMapName="changeTaskName"
               :mapName="taskName"/>
    <div class="task-container">
      <file-loader @fileUpload="fileUpload" @changeSize="changeSize"/>
    </div>
    <div class="task-settings">
      <p>сложность задачи</p>
      <vue-slider v-model="taskСomplexity"
                  :marks="true"
                  :min="1"
                  :max="5"
                  :style="{margin: '0 5px'}">
        <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
          <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ value }}</div>
        </template>
      </vue-slider>
      <p style="margin-top: 35px; margin-bottom: 5px;">теги</p>
      <multi-select placeholder="теги"
                    :options="tagsOptions"
                    :selected-options="tags"
                    style="margin-bottom: 5px"
                    @select="changeTags"/>
      <p class="task-settings-hint tag" @click="addTag">+ новый тег</p>
<!--      <div :style="{ width: '100%', display: 'flex', flexDirection: 'row' }">-->
<!--        -->
<!--        <i :class="['bx', 'bx-plus-circle']" style="font-size: 40px"/>-->
<!--      </div>-->


      <p style="margin-top: 20px; margin-bottom: 5px;">ответ</p>
      <p class="task-settings-hint">
        {{ answerTabs[answerTab].hint }}
        <a class="task-settings-hint" v-if="answerTabs[answerTab].hintLink" :href="answerTabs[answerTab].hintLink.href">
          {{ answerTabs[answerTab].hintLink.name }}
        </a>
      </p>
      <toggle-switch :defaultItems="answerTabs"
                     :selectedItem="answerTabs[answerTab].type"
                     :background-first-color="'rgba(241,243,244,0.05)'"
                     :background-second-color="'rgba(241,243,244,0.19)'"
                     :text-first-color="'#F5F5F5'"
                     :text-second-color="'#F5F5F5'"
                     :border-color="'rgba(0,0,0,0.5)'"
                     style="position: relative; width: 100%; margin: 8px 0"
                     @changeSelection="changeAnswerTab"/>

      <input v-if="answerTab === 0"
             placeholder="одиночный ответ"
             @input="check"
             v-model="answerOne"/>
      <input v-if="answerTab === 0"
             placeholder="проверка ответа"
             v-model="answerOneCheck"
             @input="check"
             :class="[ { 'answer-correct': isInput && isCorrect }, { 'answer-incorrect': isInput && !isCorrect } ]"/>

      <div id="multiInput" @keyup="multiInput" v-if="answerTab === 1">
        <multi-select placeholder="множественный ответ"
                      :options="answersManyOptions"
                      :selected-options="answersMany"
                      @select="onSelect"/>
      </div>

      <div id="multiInputAnswer" @keyup="multiInputAnswer" v-if="answerTab === 1" :style="{ 'margin-top': answerTab === 1 ? '10px' : '' }">
        <multi-select placeholder="проверка ответа"
                      :options="answersManyCheckOptions"
                      :selected-options="answersManyCheck"
                      :class="[ { 'answer-correct': isInput && isCorrect }, { 'answer-incorrect': isInput && !isCorrect } ]"
                      @select="onSelectAnswer"/>
      </div>

      <input v-if="answerTab === 2"
             placeholder="шаблон ответа"
             @input="check"
             v-model="answerRegexp"/>
      <input v-if="answerTab === 2"
             placeholder="проверка ответа"
             v-model="answerRegexpCheck"
             @input="check"
             :class="[ { 'answer-correct': isInput && isCorrect }, { 'answer-incorrect': isInput && !isCorrect } ]"/>
    </div>
    <test-task @testTask="testTask"/>
    <message/>
    <span class="footer" :style="footerStyle">
      <div :style="{ display: 'flex',
                     flexDirection: 'column'}">
        <p>w: {{ taskSizeX }}px</p>
        <p>h: {{ taskSizeY }}px</p>
      </div>
      <i class="bx bx-log-in save-map"
         @click="saveTask"/>
    </span>
  </main>
</template>

<script>
import 'vue-slider-component/theme/antd.css';
import Vue from 'vue';
import axios from 'axios';
import VueSlider from 'vue-slider-component';
import { MultiSelect } from 'vue-search-select';
import ModalWizard from 'vue-modal-wizard';
import modalDialog from '../Main/Dialog';
import Menu from './Menu';
import modal from '../Main/TaskDialog';
import TestTask from './TestTask';
import FileLoader from './FileLoader';
import Message from '../Main/Message';
import ToggleSwitch from '../Main/ToggleSwitch';
import '../../assets/css/custom-dot.css';

Vue.use(ModalWizard);

export default {
  name: 'Task',
  components: { 'vue-slider': VueSlider,
    'left-menu': Menu,
    'test-task': TestTask,
    'message': Message,
    ModalWizard,
    'toggle-switch': ToggleSwitch,
    'file-loader': FileLoader,
    'multi-select': MultiSelect },
  data() {
    return {
      pathGetTags: 'http://85.193.85.25:5050/allTags',
      pathSaveTag: 'http://85.193.85.25:5050/saveTag',
      pathSaveTask: 'http://85.193.85.25:5050/saveTask',
      documentTitle: 'Создание задачи',
      taskSizeX: 0,
      taskSizeY: 0,
      currentTaskName: '',
      isMenuOpen: false,

      answerTabs: [
        {
          type: 'one',
          name: 'один',
          hint: 'точное совпадение с единственным значением',
          disabled: false,
        },
        {
          type: 'many',
          name: 'несколько',
          hint: 'точное совпадение со всеми значениями',
          disabled: false,
        },
        {
          type: 'regexp',
          name: 'по шаблону',
          hint: 'нечеткое совпадение с шаблоном',
          hintLink: {
            name: 'справка',
            href: 'https://support.google.com/a/answer/1371415?hl=ru',
          },
          disabled: false,
        },
      ],
      answerTab: 0,

      isCorrect: true,

      answerOne: '',
      answerOneCheck: '',

      answersManyOptions: [],
      answersMany: [],
      answersManyCheckOptions: [],
      answersManyCheck: [],

      answerRegexp: '',
      answerRegexpCheck: '',

      tags: [],
      tagsOptions: [
        { value: 1, text: 'отборочный тур' },
        { value: 2, text: 'основной тур' },
        { value: 3, text: 'финальный тур' },
      ],

      taskСomplexity: 1,

      url: '',
      answer: {},
    };
  },
  methods: {
    addTag() {
      ModalWizard.open(modalDialog, {
        props: {
          title: 'добавить тег',
          placeholder: 'новый тег',
          submit: this.submitAddTag,
        },
      });
    },
    submitAddTag(name) {
      if (name === null || name === undefined || name.trim() === '') {
        this.showMessage('ошибка создания тега',
          'значение не может быть пустым',
          'error',
          5000);
        return;
      }
      if (name.trim().length < 2) {
        this.showMessage('ошибка создания тега',
          'слишком короткое значение (от 2х символов)',
          'error',
          5000);
        return;
      }
      if (name.trim().length > 40) {
        this.showMessage('ошибка создания тега',
          'слишком длинное значение (до 40 символов)',
          'error',
          5000);
        return;
      }
      this.$modal.close();
      axios.post(this.pathSaveTag, { tag: name.trim() })
        .then(() => {
          this.getTags();
        })
        .catch((error) => {
          console.error(error);
          this.showMessage('ошибка при создании тега',
            'подробности в консоли браузера',
            'error',
            5000);
        });
    },
    changeAnswerTab(data) {
      this.answerOne = '';
      this.answerOneCheck = '';
      this.answersManyOptions = [];
      this.answersMany = [];
      this.answersManyCheckOptions = [];
      this.answersManyCheck = [];
      this.answerRegexp = '';
      this.answerRegexpCheck = '';
      this.answer = {};

      for (let i = 0; i < this.answerTabs.length; i++) {
        if (this.answerTabs[i].type === data['selection']) {
          this.answerTab = i;
          return;
        }
      }
    },
    check() {
      this.answer = {};
      if (this.answerTab === 0) {
        this.isCorrect = this.answerOne.trim() === this.answerOneCheck;
        if (this.answerOne !== '') {
          this.answer = { 0: ''.concat(this.answerOne.trim()) };
        }
      } else if (this.answerTab === 1) {
        for (let i of this.answersMany) {
          this.answer[Object.keys(this.answer).length] = i.text.trim();
        }
        if (this.answersMany.length !== this.answersManyCheck.length) {
          this.isCorrect = false;
          return;
        }
        let textAnswers = [];
        for (let i of this.answersMany) {
          textAnswers.push(i.text.trim());
        }
        for (let i of this.answersManyCheck) {
          let index = textAnswers.indexOf(i.text);
          if (index === -1) {
            this.isCorrect = false;
            return;
          }
          textAnswers.splice(index, 1);
        }
        this.isCorrect = true;
      } else if (this.answerTab === 2) {
        this.isCorrect = new RegExp('^' + this.answerRegexp.trim() + '$').test(this.answerRegexpCheck);
        if (this.answerRegexp !== '') {
          this.answer = { 0: ''.concat(this.answerRegexp.trim()) };
        }
      }
    },
    multiInput() {
      let text = document.getElementById('multiInput').getElementsByTagName('input')[0].value;
      this.answersManyOptions = [];
      for (let item of this.answersMany) {
        this.answersManyOptions.push({ value: this.answersManyOptions.length, text: item.text });
      }
      if (text !== '') {
        this.answersManyOptions.push({ value: this.answersManyOptions.length, text });
      }
    },
    multiInputAnswer() {
      let text = document.getElementById('multiInputAnswer').getElementsByTagName('input')[0].value;
      this.answersManyCheckOptions = [];
      for (let item of this.answersManyCheck) {
        this.answersManyCheckOptions.push({ value: this.answersManyCheckOptions.length, text: item.text });
      }
      this.answersManyCheckOptions.push({ value: this.answersManyCheckOptions.length, text });
    },
    changeTags(items) {
      this.tags = items;
    },
    onSelect(items) {
      this.answersMany = items;
      this.check();
    },
    onSelectAnswer(items) {
      this.answersManyCheck = items;
      this.check();
    },
    stopProp(event) {
      event.stopPropagation();
    },
    getTask() {
      this.currentTaskName = this.taskName;
      this.showMessage('создание задачи',
        'загрузите картинку с шаблоном задачи, выберите сложность и способ ответа',
        'special',
        12000);
    },
    getTags() {
      axios.get(this.pathGetTags)
        .then((res) => {
          this.tagsOptions = res.data.tags;
        })
        .catch((error) => {
          console.error(error);
          this.showMessage('ошибка при загрузке тегов',
            'подробности в консоли браузера',
            'error',
            5000);
        });
    },
    onDrawEnd() {
      this.isDrawing = false;
    },
    openCloseMenu(data) {
      this.isMenuOpen = data['isOpen'];
    },
    showMessage(title, message, messageType, delay, functionConfirm) {
      this.$emit('showMessage', { title, message, messageType, delay, functionConfirm });
    },
    saveTask() {
      this.showMessage('сохранить задачу',
        'закончить редактирование и сохранить задачу?',
        'confirm',
        15000,
        this.sendSaveTask);
    },
    sendSaveTask() {
      if (!this.checkTask('сохранения')) {
        return;
      }

      let data = {
        'content': this.url,
        'answer': JSON.stringify(this.answer),
        'typeOfResponse': this.answerTab + 1,
        'name': this.currentTaskName.trim(),
        'complexity': this.taskСomplexity,
        'createdBy': JSON.parse(localStorage.getItem('user')).id,
        'tags': JSON.stringify(this.tags),
      };

      axios.post(this.pathSaveTask, data)
        .then(() => {
          this.$router.push('/tasks');
        })
        .catch((error) => {
          console.error(error);
          this.showMessage('ошибка при сохранении задачи',
            'подробности в консоли браузера',
            'error',
            5000);
        });
    },
    fileUpload(data) {
      this.url = data['url'];
    },
    changeSize(data) {
      this.taskSizeX = data['w'];
      this.taskSizeY = data['h'];
    },
    testTask() {
      if (!this.checkTask('просмотра')) {
        return;
      }
      let hintMessage = Object.values(this.answer).length === 1 ?
        ('ответ - ' + this.answer[0]) :
        ('ответы - ' + Object.values(this.answer));
      ModalWizard.open(modal, {
        props: {
          taskTitle: this.currentTaskName,
          taskName: this.url,
          taskAnswer: this.answer,
          taskAnswerType: this.answerTab + 1,
          taskСomplexity: this.taskСomplexity,
          showHintOnSubmit: true,
          hintErrorMessageOnSubmit: hintMessage,
          hintDelayOnSubmit: 3000,
          showHintInitial: true,
          hintMessageInitial: hintMessage,
          hintDelayInitial: 3000,
        },
      });
    },
    checkTask(error) {
      if (this.url === '') {
        this.showMessage('ошибка ' + error,
          'файл шаблона задачи не загружен',
          'error',
          5000);
        return false;
      }
      if (Object.keys(this.answer).length === 0) {
        this.showMessage('ошибка ' + error,
          'ответ не может быть пустым',
          'error',
          5000);
        return false;
      }
      return true;
    },
    exitTask() {
      this.showMessage('выйти',
        'прервать редактирование и выйти?',
        'confirm-error',
        15000,
        () => { this.$router.push('/tasks'); });
    },
    changeTaskName(data) {
      this.currentTaskName = data['newMapName'];
    },
  },
  computed: {
    footerStyle() {
      return {
        'margin-left': this.isMenuOpen ? '238px' : '78px',
        'transition': 'all 0.5s ease',
      };
    },
    isInput() {
      return this.answerOne !== '' ||
        this.answerOneCheck !== '' ||
        this.answersMany.length !== 0 ||
        this.answersManyCheck.length !== 0 ||
        this.answerRegexp !== '' ||
        this.answerRegexpCheck !== '';
    },
  },
  created() {
    document.title = this.documentTitle;
  },
  mounted() {
    if (!localStorage.getItem('user')) {
      this.$router.push('/login');
    } else if (JSON.parse(localStorage.getItem('user')).role === 1) {
      this.$router.push('/main');
    } else {
      // window.onbeforeunload = () => true;
      this.getTask();
      this.getTags();
    }
  },
  destroyed() {
    window.removeEventListener('wheel', this.onScroll);
    window.removeEventListener('keydown', this.onScrollKey);
  },
  props: {
    linkedTask: {
      type: Object,
      default: () => {},
    },
    taskName: {
      type: String,
      default: 'новая задача',
    },
  },
};
</script>
<style scoped>
* {
  user-select:none
}
#task-main {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
}
.task-settings {
  position: absolute;
  background: rgba(33, 37, 41, 0.6);
  border-radius: 0.5rem;
  border: 1px solid #F5F5F5;
  color: #F5F5F5;
  right: 5%;
  top: 50%;
  transform: translate(0, -50%);
  width: 30%;
  height: fit-content;
  min-height: 100px;
  max-height: 80%;
  padding: 20px;
  overflow: scroll;
}
.task-settings a,
.task-settings p {
  padding: 0 5px;
  margin: 0;
  border-radius: 0.5rem;
  background: rgba(241,243,244,0.14);
  width: fit-content;
}
.task-settings input {
  padding: 7.5px 10px;
  margin-top: 10px;
  border-radius: 0.25rem;
  border: none;
  width: 100%;
  display: block;
}
.task-settings input::placeholder {
  color: hsla(0,0%,74.9%,.87);
  font-size: 14px;
}
.task-settings input:focus::placeholder {
  color: hsla(0,0%,45.1%,.87) !important;
}
.task-settings-hint {
  background: rgba(241,243,244,0.05) !important;
  color: rgba(245, 245, 245, 0.8) !important;
  font-size: 0.8em;
}
.task-settings-hint.tag {
  transition: all 0.2s ease;
}
.task-settings-hint.tag:hover {
  cursor: pointer;
  transform: scale(1.2);
}
.task-settings-hint a {
  font-size: inherit;
  background: rgba(241,243,244,0.14) !important;
}
/* div::-webkit-scrollbar {*/
/*  display: none;*/
/*}*/
.task-container {
  display: -webkit-box;
  min-width: 100%;
  height: 100%;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  padding: 0 40% 0 78px;
  overflow: scroll;
}
.task-container::-webkit-scrollbar {
  display: block !important;
}
.footer {
  color: #F5F5F5;
  min-height: 30px;
  border-top: 1px solid black;
  padding-left: 5%;
  padding-right: 10px;
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: right;
}
.footer i {
  margin: 0 10px;
}
.footer p {
  width: 70px;
  margin: 0 0 0 5px;
  font-size: 0.7em;
  text-align: center;
  line-height: 1em;
}
.background {
  position: fixed;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: hidden;
  z-index: -1;
}
.background:before {
  content: '';
  background-image: url('../../assets/images/special/background.jpg');
  position: absolute;
  margin: 0;
  padding: 0;
  width: 130%;
  height: 130%;
  left: -15%;
  top: -15%;
  filter: blur(10px);
}
.save-map {
  font-size: 24px;
  transition: all 0.2s ease;
  background: linear-gradient(to right, #00416a, #799f0c, #ffe000);
  background-clip: text;
  -webkit-background-clip: text;
}
.save-map:hover {
  color:rgba(1,1,1,0);
  cursor: pointer;
}
.answer-correct {
  /*box-shadow: 0 0 50px rgb(0, 255, 0) !important;*/
  /*border: 3px solid rgb(0, 255, 0);*/
  box-shadow: 0 0 6px 6px rgba(54, 255, 54, 0.5) !important;
}
.answer-incorrect {
  /*box-shadow: 0 0 50px rgb(255, 0, 0) !important;*/
  /*border: 3px solid rgb(255, 0, 0);*/
  box-shadow: 0 0 6px 6px rgba(255, 54, 54, 0.5) !important;
}
</style>
