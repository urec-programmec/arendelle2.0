<template>
  <div class="adaptive-modal">
    <div class="close" @click="$modal.close()">
      <i class="bx bx-x"/>
    </div>
    <h5 class="hint">пример задачи</h5>
    <div class="header">
      <img :src="require(`../../assets/images/${taskName}`)">
    </div>
    <input v-model="answer" placeholder="напишите ответ" :autofocus="true">
    <div class="footer">
      <div class="send-answer">
        <p>отправить</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Task',
  data() {
    return {
      answer: '',
    };
  },
  methods: {
    _modalFlexPosition(w, h) {
      this.$el.style.width = window.innerWidth * 0.8 + 'px';
      this.$el.style.maxHeight = window.innerHeight * 0.8 + 'px';
      this.$el.style.borderRadius = '0.25rem';
      this.$el.style.overflow = 'scroll';
      return {
        type: 'column',
        top: '10vh',
        bottom: '50px',
      };
    },
  },
  props: {
    taskName: {
      type: String,
      default: 'tasks/task1.jpg',
    },
  },
};
</script>

<style scoped>
.adaptive-modal {
  height: fit-content;
  background-color: #F5F5F5;
  color: rgba(17, 16, 29, 0.85);
  /*overflow: scroll;*/
  box-shadow: 0 0 20px 20px rgba(54, 171, 255, 0.2);
  font-size: 1em;
}
.adaptive-modal input {
  margin: 16px 20px 0 20px;
  width: calc(100% - 40px);
  background-color: inherit;
  padding: 5px;
  color: inherit;
  border: 0;
  box-shadow: inset 0 -1px 0 rgb(0 0 0 / 12%);
}
.adaptive-modal .header {
  margin-left: 10px;
  overflow: scroll;
  max-height: calc(80vh - 138px);
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
  top: 5px;
  right: 5px;
  font-size: 0.8em;
  font-weight: bold;
  cursor: pointer;
  color: inherit;
}
.adaptive-modal .close i {
  font-size: 1.5em;
}
.adaptive-modal .hint {
  font-size: 1em;
  padding: 10px 30px 0 30px;
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
  display: flex;
  align-items: center;
  justify-content: center;
}
.adaptive-modal .footer .send-answer p{
  margin: 0;
}
.adaptive-modal .footer .send-answer:hover{
  background: linear-gradient(to right, #00416a, #799f0c, #ffe000);
  border: 1px solid rgba(0,0,0,0.5);
  cursor: pointer;
  color: #F5F5F5;
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
