<template>
  <main id="task-main" @mouseup="onDrawEnd">
    <div class="background"></div>
    <left-menu @openCloseMenu="openCloseMenu"
               @exitMap="exitMap"
               @changeMapName="changeMapName"
               :mapName="taskName"/>
    <div class="task-container">
      <div class="task-image bx bx-image-add" :style="{
                     maxWidth: getTaskSizeX() + 'px',
                     width: getTaskSizeX() + 'px',
                     minHeight: getTaskSizeY() + 'px',
                     maxHeight: getTaskSizeY() + 'px',
                     height: getTaskSizeY() + 'px',
                     margin: '15px'}">
        <canvas id="mapCanvas"
                :style="{width: getTaskSizeX() + 'px',
                         height: getTaskSizeY() + 'px'}"
                @mousemove="move"
                @mousedown="move"/>
      </div>
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
      <p style="margin-top: 35px; margin-bottom: 5px;">ответ</p>
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

      <div id="multiInput" @keyup="multiInput" :style="{ 'margin-top': answerTab === 1 ? '10px' : '' }">
        <multi-select v-if="answerTab === 1"
                      placeholder="множественный ответ"
                      :options="answersManyOptions"
                      :selected-options="answersMany"
                      @select="onSelect"/>
      </div>

      <div id="multiInputAnswer" @keyup="multiInputAnswer" :style="{ 'margin-top': answerTab === 1 ? '10px' : '' }">
        <multi-select v-if="answerTab === 1"
                      placeholder="проверка ответа"
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
    <test-map @testMap="check"/>
    <message/>
    <span class="footer" :style="footerStyle">
      <div :style="{ display: 'flex',
                     flexDirection: 'column'}">
        <p>w: {{ taskSizeX }}px</p>
        <p>h: {{ taskSizeY }}px</p>
      </div>
      <i class="bx bx-log-in save-map"
         @click="saveMap"/>
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
import Menu from './Menu';
import TestTask from './TestTask';
import Message from '../Main/Message';
import '../../assets/css/custom-dot.css';
import ToggleSwitch from '../Main/ToggleSwitch';

Vue.use(ModalWizard);

export default {
  name: 'Task',
  components: { 'vue-slider': VueSlider, 'left-menu': Menu, 'test-map': TestTask, 'message': Message, ModalWizard, 'toggle-switch': ToggleSwitch, 'multi-select': MultiSelect },
  data() {
    return {
      pathSaveMap: 'http://localhost:5050/saveMap',
      documentTitle: 'Создание задачи',
      taskSizeX: 0,
      taskSizeY: 0,
      currentTaskName: '',
      isMenuOpen: false,

      taskСomplexity: 1,
      answerTabs: [
        {
          type: 'one',
          name: 'один',
          hint: 'точное совпадение с единственным значением',
        },
        {
          type: 'many',
          name: 'несколько',
          hint: 'точное совпадение со всеми значениями',
        },
        {
          type: 'regexp',
          name: 'по шаблону',
          hint: 'нечеткое сравнение по шаблону',
          hintLink: {
            name: 'справка',
            href: 'https://support.google.com/a/answer/1371415?hl=ru',
          },
        },
      ],
      answerTab: 0,

      canvas: null,
      context: null,

      isCorrect: true,

      answerOne: '',
      answerOneCheck: '',

      answersManyOptions: [],
      answersMany: [],
      answersManyCheckOptions: [],
      answersManyCheck: [],

      answerRegexp: '',
      answerRegexpCheck: '',
    };
  },
  methods: {
    changeAnswerTab(data) {
      this.answerOne = '';
      this.answerOneCheck = '';
      this.answersManyOptions = [];
      this.answersMany = [];
      this.answersManyCheckOptions = [];
      this.answersManyCheck = [];
      this.answerRegexp = '';
      this.answerRegexpCheck = '';

      for (let i = 0; i < this.answerTabs.length; i++) {
        if (this.answerTabs[i].type === data['selection']) {
          this.answerTab = i;
          return;
        }
      }
    },
    check() {
      if (this.answerTab === 0) {
        this.isCorrect = this.answerOne === this.answerOneCheck;
      } else if (this.answerTab === 1) {
        if (this.answersMany.length !== this.answersManyCheck.length) {
          this.isCorrect = false;
          return;
        }
        let textAnswers = [];
        for (let i of this.answersMany) {
          textAnswers.push(i.text);
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
        this.isCorrect = new RegExp('^' + this.answerRegexp + '$').test(this.answerRegexpCheck);
      }
    },
    multiInput() {
      let text = document.getElementById('multiInput').getElementsByTagName('input')[0].value;
      this.answersManyOptions = [];
      for (let item of this.answersMany) {
        this.answersManyOptions.push({ value: this.answersManyOptions.length, text: item.text });
      }
      this.answersManyOptions.push({ value: this.answersManyOptions.length, text });
    },
    multiInputAnswer() {
      let text = document.getElementById('multiInputAnswer').getElementsByTagName('input')[0].value;
      this.answersManyCheckOptions = [];
      for (let item of this.answersManyCheck) {
        this.answersManyCheckOptions.push({ value: this.answersManyCheckOptions.length, text: item.text });
      }
      this.answersManyCheckOptions.push({ value: this.answersManyCheckOptions.length, text });
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
    changeTab(tab) {
      if (this.answerTab === tab) {
        this.answerTab = '';
      } else {
        this.answerTab = tab;
      }
    },
    getTask() {
      this.currentTaskName = this.taskName;
      this.canvas = document.getElementById('mapCanvas');
      this.context = this.canvas.getContext('2d');
      this.showMessage('создание задачи',
        'загрузите картинку с шаблоном задачи, выберите сложность и способ ответа',
        'special',
        12000);
      // this.drawCanvas();
    },
    move(e) {
      // console.log('move');
      // if (this.isTesting) {
      //   return;
      // }
      // let params = this.getItemPosition(e);
      // let rowIndex = Math.floor(params.y / this.mapZoom);
      // let itemIndex = Math.floor(params.x / this.mapZoom);
      // if (rowIndex < 0) rowIndex = 0;
      // if (rowIndex >= this.mapSizeY) rowIndex = this.mapSizeY - 1;
      // if (itemIndex < 0) itemIndex = 0;
      // if (itemIndex >= this.mapSizeX) itemIndex = this.mapSizeX - 1;
      //
      // if (this.cursorPositionY === rowIndex && this.cursorPositionX === itemIndex) {
      //   return;
      // }
      // this.cursorPositionY = rowIndex;
      // this.cursorPositionX = itemIndex;
      // this.oldSelectedItems = this.selectedItems;
      // this.selectedItems = [];
      // let tempCursorSize = this.cursorSize - 1;
      // for (let y = rowIndex - tempCursorSize; y <= rowIndex + tempCursorSize; y++) {
      //   for (let x = itemIndex - tempCursorSize; x <= itemIndex + tempCursorSize; x++) {
      //     if (y < 0 || x < 0 || y >= this.mapSizeY || x >= this.mapSizeX) {
      //       continue;
      //     }
      //
      //     let delta = (rowIndex === y && itemIndex === x) ?
      //       0 :
      //       Math.sqrt((rowIndex - y) ** 2 + (itemIndex - x) ** 2);
      //
      //     let isCircle = this.cursorForm === 'circle' &&
      //       (this.cursorSolid && delta <= tempCursorSize ||
      //         !this.cursorSolid && tempCursorSize - delta <= this.cursorSizeDelta && tempCursorSize - delta >= 0 &&
      //         !(tempCursorSize === 1 && (rowIndex === y && itemIndex === x)));
      //
      //     let isSquare = this.cursorForm !== 'circle' &&
      //       (this.cursorSolid ||
      //         y === rowIndex - tempCursorSize ||
      //         y === rowIndex + tempCursorSize ||
      //         x === itemIndex - tempCursorSize ||
      //         x === itemIndex + tempCursorSize);
      //
      //     if (isCircle || isSquare) {
      //       this.selectedItems.push({ x, y });
      //     }
      //   }
      // }
      // this.drawSelection();
      // if (this.isDrawing) {
      //   this.draw();
      // }
    },
    onDrawEnd() {
      this.isDrawing = false;
    },
    openCloseMenu(data) {
      this.isMenuOpen = data['isOpen'];
    },
    getTaskSizeX() {
      return this.taskSizeX * this.taskZoom;
    },
    getTaskSizeY() {
      return this.taskSizeY * this.taskZoom;
    },
    drawCanvas() {
      console.log('draw');
      // this.context.fillStyle = 'wheat';
      // this.context.fillRect(0,
      //   0,
      //   this.taskSizeX * this.taskZoom,
      //   this.taskSizeY * this.taskZoom);

      // this.oldSelectedItems = [];
      // this.selectedItems = [];
      // this.context.clearRect(0, 0, this.canvas.width, this.canvas.height);
      // this.canvas.width = this.getMapSizeX();
      // this.canvas.height = this.getMapSizeY();
      // for (let y = 0; y < this.mapSizeY; y++) {
      //   for (let x = 0; x < this.mapSizeX; x++) {
      //     let image = this.images.at(this.imagesSrc.indexOf(this.map[y][x].src === '' ? this.foneSrc : this.map[y][x].src));
      //     this.drawImage(image, x, y, this.map[y][x].type);
      //   }
      // }
    },
    drawImage(image, x, y, type) {
      // if (this.isColorBlindness) {
      //   if (this.roomTypes.includes(type)) {
      //     this.context.fillStyle = this.colorBlindnessRoom;
      //   } else {
      //     this.context.fillStyle = this.colorBlindnessBorder;
      //   }
      //   this.context.fillRect(x * this.mapZoom,
      //     y * this.mapZoom,
      //     this.mapZoom - this.spaceSize,
      //     this.mapZoom - this.spaceSize);
      // } else {
      //   this.context.drawImage(image,
      //     x * this.mapZoom,
      //     y * this.mapZoom,
      //     this.mapZoom - this.spaceSize,
      //     this.mapZoom - this.spaceSize);
      // }
      // if (this.map[y][x].task) {
      //   this.context.clearRect(x * this.mapZoom,
      //     y * this.mapZoom,
      //     this.mapZoom - this.spaceSize,
      //     this.mapZoom - this.spaceSize);
      //   let taskImage = this.images.at(this.imagesSrc.indexOf(this.taskSrc));
      //   this.context.drawImage(taskImage,
      //     x * this.mapZoom,
      //     y * this.mapZoom,
      //     this.mapZoom - this.spaceSize,
      //     this.mapZoom - this.spaceSize);
      // }
    },
    showMessage(title, message, messageType, delay, functionConfirm) {
      this.$emit('showMessage', { title, message, messageType, delay, functionConfirm });
    },
    saveMap() {
      this.showMessage('сохранить задачу',
        'закончить редактирование и сохранить задачу?',
        'confirm',
        15000,
        this.sendSaveMap);
    },
    sendSaveMap() {
      console.log('save');
      // let data = {
      //   mapName: this.currentMapName.trim(),
      //   map: this.map,
      //   sizeX: this.mapSizeX,
      //   sizeY: this.mapSizeY,
      //   author: JSON.parse(localStorage.getItem('user')).id,
      // };
      // axios.post(this.pathSaveMap, data)
      //   .then(() => {
      //     this.$router.push('/maps');
      //   })
      //   .catch((error) => {
      //     console.log(error);
      //   });
    },
    exitMap() {
      this.showMessage('выйти',
        'прервать редактирование и выйти?',
        'confirm-error',
        15000,
        () => { this.$router.push('/tasks'); });
    },
    changeMapName(data) {
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
    }
  },
  destroyed() {
    window.removeEventListener('wheel', this.onScroll);
    window.removeEventListener('keydown', this.onScrollKey);
  },
  props: {
    linkedMap: {
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
.task-image canvas,
.task-image {
  width: 300px;
  height: 300px;
}
.task-image {
  position: relative;
}
.task-image:before {
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  width: 100%;
  height: 100%;
  border: 2px dashed #F5F5F5;
  background: rgba(33, 37, 41, 0.6);
  color: #F5F5F5;
  font-size: 2em;
  border-radius: 0.25rem;
  display: flex;
  justify-content: center;
  align-items: center;
}
.task-image:hover:before {
  background: rgba(33, 37, 41, 0.8);
  cursor: pointer;
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
  padding: 20px;
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
