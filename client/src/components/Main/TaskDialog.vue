<template>
  <div :class="['adaptive-modal', { 'correct': isCalculate && isCorrect },
               { 'incorrect': isCalculate && !isCorrect } ]">
    <div class="close" @click="$modal.close()">
      <i class="bx bx-x"/>
    </div>
    <h5 class="hint">
      <i :class="['bx', `bx-dice-${taskСomplexity}`]"/>
      &nbsp;{{ taskTitle }}
    </h5>
    <message :is-fixed="false"/>
    <div class="header">
      <img :src="taskName">
    </div>
    <input v-if="taskAnswerType === 1 && !isShowing"
           placeholder="одиночный ответ"
           @input="check"
           v-model="answerOne"/>

    <div id="multiInputTask" @keyup="multiInputTask" v-if="taskAnswerType === 2 && !isShowing">
      <multi-select placeholder="множественный ответ"
                    :options="answersManyTaskOptions"
                    :selected-options="answersManyTask"
                    @select="onSelect"/>
    </div>

    <input v-if="taskAnswerType === 3 && !isShowing"
           placeholder="одиночный ответ по шаблону"
           @input="check"
           v-model="answerRegexp"/>

    <div class="footer">
      <button v-if="!isShowing"
              class="send-answer"
              :disabled="!isAnswer"
              @click="onSubmit">отправить</button>
    </div>
  </div>
</template>

<script>
import { MultiSelect } from 'vue-search-select';
import Message from './Message';

export default {
  name: 'TaskDialog',
  components: { 'multi-select': MultiSelect, 'message': Message },
  data() {
    return {
      answersManyTaskOptions: [],
      answersManyTask: [],

      answerOne: '',
      answerMany: [],
      answerRegexp: '',

      isCalculate: false,
      isAnswer: false,
      isCorrect: false,
    };
  },
  methods: {
    _modalFlexPosition(w, h) {
      this.$el.style.width = window.innerWidth * 0.8 + 'px';
      this.$el.style.maxHeight = window.innerHeight * 0.85 + 'px';
      this.$el.style.borderRadius = '0.25rem';
      this.$el.style.overflow = 'hidden';
      return {
        type: 'column',
        top: '10vh',
        bottom: '50px',
      };
    },
    check() {
      this.isCalculate = false;
      this.isAnswer = false;
      if (this.taskAnswerType === 1) {
        this.isCorrect = this.answerOne === this.taskAnswer[0].trim();
        this.isAnswer = this.answerOne.trim() !== '';
      } else if (this.taskAnswerType === 2) {
        this.isAnswer = this.answersManyTask.length !== 0;
        if (this.answersManyTask.length !== Object.keys(this.taskAnswer).length) {
          this.isCorrect = false;
          return;
        }
        let textAnswers = [];
        for (let i of this.answersManyTask) {
          textAnswers.push(i.text);
        }
        for (let i of Object.keys(this.taskAnswer)) {
          let index = textAnswers.indexOf(this.taskAnswer[i].trim());
          if (index === -1) {
            this.isCorrect = false;
            return;
          }
          textAnswers.splice(index, 1);
        }
        this.isCorrect = true;
      } else if (this.taskAnswerType === 3) {
        this.isCorrect = new RegExp('^' + this.taskAnswer[0].trim() + '$').test(this.answerRegexp);
        this.isAnswer = this.answerRegexp.trim() !== '';
      }
    },
    multiInputTask() {
      let text = document.getElementById('multiInputTask').getElementsByTagName('input')[0].value;
      this.answersManyTaskOptions = [];
      for (let item of this.answersManyTask) {
        this.answersManyTaskOptions.push({ value: this.answersManyTaskOptions.length, text: item.text });
      }
      if (text !== '') {
        this.answersManyTaskOptions.push({ value: this.answersManyTaskOptions.length, text });
      }
    },
    onSelect(items) {
      this.answersManyTask = items;
      this.check();
    },
    onSubmit() {
      this.isCalculate = true;
      if (this.showHintOnSubmit) {
        let message = this.isCorrect ?
          (this.hintSuccessMessageOnSubmit === '' ? 'ответ верный' : this.hintSuccessMessageOnSubmit) :
          (this.hintErrorMessageOnSubmit === '' ? 'ответ не верный' : this.hintErrorMessageOnSubmit);

        this.showMessage('ответ',
          message,
          this.isCorrect ? 'success' : 'error',
          this.hintDelayOnSubmit);
      }
      if (this.isCorrect) {
        this.onSuccess();
      } else {
        this.onError();
      }
    },
    showMessage(title, message, messageType, delay, functionConfirm) {
      this.$emit('showMessage', { title, message, messageType, delay, functionConfirm });
    },
  },
  mounted() {
    if (this.showHintInitial) {
      setTimeout(() => {
        this.showMessage('подсказка',
          this.hintMessageInitial,
          'special',
          this.hintDelayInitial);
      }, 150);
    }
  },
  props: {
    taskName: {
      type: String,
      default: require('../../assets/images/tasks/task1.jpg'),
    },
    taskTitle: {
      type: String,
      default: 'пример задачи',
    },
    taskAnswer: {
      type: Object,
      default: () => {
        return { 0: '1' };
      },
    },
    taskAnswerType: {
      type: Number,
      default: 1,
    },
    taskСomplexity: {
      type: Number,
      default: 1,
    },
    onSuccess: {
      type: Function,
      default: () => { console.log('correct'); },
    },
    onError: {
      type: Function,
      default: () => { console.error('incorrect'); },
    },
    showHintOnSubmit: {
      type: Boolean,
      default: false,
    },
    hintSuccessMessageOnSubmit: {
      type: String,
      default: '',
    },
    hintErrorMessageOnSubmit: {
      type: String,
      default: '',
    },
    hintDelayOnSubmit: {
      type: Number,
      default: 5000,
    },
    showHintInitial: {
      type: Boolean,
      default: false,
    },
    hintMessageInitial: {
      type: String,
      default: 'ответ - 1',
    },
    hintDelayInitial: {
      type: Number,
      default: 5000,
    },
    isShowing: {
      type: Boolean,
      default: false,
    },
  },
};
</script>

<style scoped>
.adaptive-modal {
  height: fit-content;
  background-color: #F5F5F5;
  color: rgba(17, 16, 29, 0.85);
  box-shadow: 0 0 20px 20px rgba(54, 171, 255, 0.2);
  font-size: 1em;
}
.adaptive-modal.correct {
  box-shadow: 0 0 20px 20px rgba(54, 255, 54, 0.5) !important;
}
.adaptive-modal.incorrect {
  box-shadow: 0 0 20px 20px rgba(255, 54, 54, 0.5) !important;
}
#multiInputTask,
.adaptive-modal input {
  margin: 16px 20px 0 20px;
  width: calc(100% - 40px);
  background-color: inherit;
  padding: 5px;
  color: inherit;
  border: 0;
}
.adaptive-modal input {
  box-shadow: inset 0 -1px 0 rgb(0 0 0 / 12%);
}
.adaptive-modal .header {
  margin-left: 10px;
  overflow: scroll;
  max-height: calc(85vh - 155px);
  height: fit-content;
  display: flex;
  justify-content: center;
}
.adaptive-modal .header img {
  max-width: 100%;
  height: 100%;
}
.adaptive-modal .close {
  display: inline-block;
  position: sticky;
  font-size: 0.8em;
  top: 5px;
  right: 5px;
  cursor: pointer;
  font-weight: bold;
  color: inherit;
}
.adaptive-modal .hint i {
  font-size: 1.25em;
}
.adaptive-modal .close i {
  font-size: 1.5em;
}
.adaptive-modal .hint {
  font-size: 1em;
  padding: 10px 30px 0 15px;
  display: flex;
  align-items: center;
}
.adaptive-modal .footer {
  width: 100%;
  margin: 0;
  height: 50px;
  position: relative;
  display: flex;
}
.adaptive-modal .footer .send-answer{
  background: rgba(0,0,0,0.18);
  width: 150px;
  position: absolute;
  right: 20px;
  top: 50%;
  transform: translate(0, -50%);
  border-radius: 0.5rem;
  border: none;
  display: flex;
  align-items: center;
  justify-content: center;
}
.adaptive-modal .footer .send-answer:hover:enabled{
  background: linear-gradient(to right, #00416a, #799f0c, #ffe000);
  color: rgba(0,0,0,0.8);
  cursor: pointer;
}
.adaptive-modal .header::-webkit-scrollbar{
  display: block;
  width: 10px;
  height: 0;
}
.adaptive-modal .header::-webkit-scrollbar-thumb {
  -webkit-border-radius: 10px;
  border-radius: 10px;
  padding: 2px;
  background: rgba(0,0,0,0.18);
  -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5);
}
.adaptive-modal .header::-webkit-scrollbar-thumb:hover {
  background: rgba(0,0,0,0.27);
  -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5);
}
</style>
