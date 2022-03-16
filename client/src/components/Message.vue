<template>
  <div class="message"
       :style="{right: rightPosition + 'px'}">
    <i class="bx bx-x close-x"
        @click="closeMessage"/>
    <div>
      <i :class="['bx', 'bx-flip-horizontal ', messageType]"/>
      <div style="display: flex; flex-direction: column">
        <p style="font-size: 0.9em">{{ title }}</p>
        <p>{{ message }}</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Message',
  data() {
    return {
      rightPosition: -280,
      defaultRight: -280,
      title: '',
      message: '',
      messageType: '',
      messageTypes: {
        'error': 'bx-message-error error',
        'info': 'bx-message-detail info',
        'special': 'bx-message-error special',
      },
      closeTimeout: null,
    };
  },
  methods: {
    show(data) {
      this.closeMessage();
      this.title = data['title'];
      this.message = data['message'];
      this.messageType = this.messageTypes[data['messageType']];
      this.rightPosition = 0;
      this.closeTimeout = setTimeout(() => { this.closeMessage(); }, data['delay']);
    },
    closeMessage() {
      if (this.closeTimeout) {
        clearTimeout(this.closeTimeout);
        this.closeTimeout = null;
      }
      this.rightPosition = this.defaultRight;
    },
  },
  created() {
    this.$parent.$on('showMessage', this.show);
  },
};
</script>

<style scoped>
.message {
  position: fixed;
  min-height: 20px;
  width: 270px;
  height: max-content;
  top: 50px;
  transition: all 0.2s ease;
  overflow: hidden;
  background: rgba(17, 16, 29, 0.85);
  border-bottom-left-radius: 10px;
  border-top-left-radius: 10px;
  z-index: 10;
  color: #F5F5F5;
  box-shadow: 0 0 6px 6px rgba(54, 171, 255, 0.2);
  padding: 10px;
}
.message p {
  position: relative;
  display: block;
  margin: 0;
  font-size: 0.7em;
  width: max-content;
  max-width: 230px;
}
.message div {
  display: flex;
}
.message i {
  margin: 2px 6px 0 0;
  font-size: 1.2em;
}
.close-x {
  position: absolute;
  right: 0;
  top: 0;
}
.close-x:hover {
  cursor: pointer;
}
.error {
  color: rgba(204,0,0,1);
}
.info {
  color: goldenrod;
}
.special {
  color: rgba(54, 171, 255, 0.8);
}
</style>
