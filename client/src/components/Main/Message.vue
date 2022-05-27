<template>
  <div class="message"
       :style="{right: rightPosition + 'px',
                position: isFixed ? 'fixed' : 'absolute',
                width: isFixed ? '270px' : '216px' }">
    <i class="bx bx-x close-x"
        @click="closeMessage"/>
    <div>
      <i :class="['bx', 'bx-flip-horizontal ', messageTypeClass]"/>
      <div :style="{ display: 'flex', flexDirection: 'column', minWidth: isFixed ? '205px' : '164px'  }">
        <p style="font-size: 0.9em">{{ title }}</p>
        <p :style="{ fontSize: isFixed ? '0.7em' : '0.82em' }">{{ message }}</p>
        <div v-if="messageTypesConfirm.includes(messageType)" style="display: flex; flex-direction: row; margin-right: 50px">
          <p :style="{ fontSize: isFixed ? '0.7em' : '0.82em' }"
             class="button button-error"
             @click="closeMessage">отмена</p>
          <p :style="{ fontSize: isFixed ? '0.7em' : '0.82em' }"
             class="button button-success"
             @click="onConfirm">ок</p>
        </div>
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
      functionConfirm: '',
      messageTypeClass: '',
      messageTypesConfirm: ['confirm', 'confirm-error', 'confirm-info', 'confirm-special'],
      messageTypeClasses: {
        'error': 'bx-message-error error',
        'info': 'bx-message-detail info',
        'special': 'bx-message-error special',
        'success': 'bx-message-check confirm',
        'confirm': 'bx-message-check confirm',
        'confirm-info': 'bx-message-check info',
        'confirm-special': 'bx-message-check special',
        'confirm-error': 'bx-message-error error',
      },
      closeTimeout: null,
    };
  },
  methods: {
    show(data) {
      this.closeMessage();
      this.title = data['title'];
      this.message = data['message'];
      this.messageType = data['messageType'];
      this.functionConfirm = data['functionConfirm'];
      this.messageTypeClass = this.messageTypeClasses[this.messageType];
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
    onConfirm() {
      this.functionConfirm();
    },
  },
  props: {
    isFixed: {
      type: Boolean,
      default: true,
    },
  },
  created() {
    this.$parent.$on('showMessage', this.show);
    this.$parent.$on('closeMessage', this.closeMessage);
  },
};
</script>

<style scoped>
.message {
  /*position: fixed;*/
  min-height: 20px;
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
  width: max-content;
  max-width: 225px;
}
.message div {
  display: flex;
}
.message i {
  margin: 3px 6px 0 0;
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
.confirm {
  color: rgba(53, 210, 25, 0.8);
}
.button {
  width: 35% !important;
  height: 15px;
  border-radius: 5px;
  opacity: 0.6;
  margin-top: 10px !important;
  box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
  color: inherit;
  line-height: 15px;
  text-align: center;
}
.button-success {
  background: linear-gradient(to right, #00416a, #799f0c, #ffe000);
}
.button-error {
  background: linear-gradient(to right, rgba(155, 23, 4, 0.99), rgba(255, 115, 0, 1));
  margin-right: 10px !important;
}
.button:hover {
  opacity: 1;
  cursor: pointer;
}
</style>
