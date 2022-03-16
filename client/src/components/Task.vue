<template>
  <div class="adaptive-modal">
    <div class="close" @click="$modal.close()">
      <i class="bx bx-x"/>
    </div>
    <h5 class="hint">пример задачи</h5>
    <div class="header">
      <img src="../assets/images/tasks/task1.jpg">
    </div>
    <input v-model="answer" placeholder="ответ (1)">
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
      this.$el.style.borderRadius = '5px';
      this.$el.style.overflow = 'scroll';
      return {
        type: 'column',
        top: '50px',
        bottom: '50px',
      };
    },
  },
};
</script>

<style>
.adaptive-modal {
  height: fit-content;
  background-color: #F5F5F5;
  color: rgba(17, 16, 29, 0.85);
  overflow: scroll;
  box-shadow: 0 0 20px 20px rgba(54, 171, 255, 0.2);
  font-size: 1em;
}
.adaptive-modal input {
  margin: 10px 30px;
  width: calc(100% - 60px);
  border-radius: 5px;
  background-color: inherit;
  padding: 5px;
  color: inherit;
}
.adaptive-modal .header {
  height: fit-content;
}
.adaptive-modal .header img {
  width: 100%;
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
  height: 35px;
  background: rgba(17, 16, 29, 0.42);
  display: flex;
}
.adaptive-modal .footer .send-answer{
  position: absolute;
  right: 0;
  border-left: 1px solid rgba(17, 16, 29, 0.65);
  width: 150px;
  height: inherit;
  display: flex;
  align-items: center;
  justify-content: center;
}
.adaptive-modal .footer .send-answer p{
  margin: 0;
}
.adaptive-modal .footer .send-answer:hover{
  background: linear-gradient(to right, #00416a, #799f0c, #ffe000);
  cursor: pointer;
}
</style>
