<template>
  <div class="adaptive-modal">
    <div class="close" @click="$modal.close()">
      <i class="bx bx-x"/>
    </div>
    <h5 class="hint">{{ title }}</h5>
    <input v-if="!isConfirm" v-model="name" :autofocus="true" :placeholder="placeholder" :maxlength="40">
    <div class="footer">
      <div class="send-answer"
           @click="submit(name)">
        <p>ок</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Dialog',
  data() {
    return {
      name: '',
    };
  },
  methods: {
    _modalFlexPosition(w, h) {
      this.$el.style.width = '270px';
      this.$el.style.maxHeight = window.innerHeight * 0.8 + 'px';
      this.$el.style.borderRadius = '0.25rem';
      this.$el.style.overflow = 'scroll';
      return {
        type: 'column',
        top: window.innerHeight * 0.4 + 'px',
        bottom: '50px',
      };
    },
  },
  props: ['submit', 'title', 'placeholder', 'isConfirm'],
};
</script>

<style scoped>
.adaptive-modal {
  height: fit-content;
  background-color: #F5F5F5;
  color: rgba(17, 16, 29, 0.85);
  overflow: scroll;
  font-size: 1em;
}
.adaptive-modal input {
  margin: 5px 20px 0 20px;
  width: calc(100% - 40px);
  background-color: inherit;
  padding: 5px;
  color: inherit;
  border: 0;
  box-shadow: inset 0 -1px 0 rgb(0 0 0 / 12%);
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
  padding: 15px 20px 5px;
  color: black;
  margin: 0;
  /*box-shadow: inset 0 -1px 0 rgb(0 0 0 / 12%);*/
}
.adaptive-modal .footer {
  width: 100%;
  margin: 0;
  height: 40px;
  position: relative;
  display: flex;
}
.adaptive-modal .footer .send-answer{
  background: rgba(0,0,0,0.18);
  width: 60px;
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
  /*background: rgba(0,0,0,0.24);*/
  background: linear-gradient(to right, #00416a, #799f0c, #ffe000);
  cursor: pointer;
  color: rgba(0,0,0,0.8);
}
</style>
