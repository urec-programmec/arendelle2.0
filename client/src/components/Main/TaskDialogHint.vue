<template>
 <div :class="['dialog-hint', showType, { 'showing': isShowing }]">
   <p>{{ message }}</p>
 </div>
</template>

<script>
export default {
  name: 'TaskDialogHint',
  data() {
    return {
      message: '',
      showDelay: 5000,
      showTimeout: null,
      isShowing: false,
      defaultShowType: 'show-info',
      showType: '',
      showTypes: {
        error: 'show-error',
        success: 'show-success',
        info: 'show-info',
      },
    };
  },
  methods: {
    showHint(data) {
      this.message = data['message'];
      this.showDelay = data['showDelay'];
      if (data['showType']) {
        this.showType = this.showTypes[data['showType']];
      } else {
        this.showType = this.defaultShowType;
      }
      this.show();
    },
    show() {
      if (this.showTimeout) {
        clearTimeout(this.showTimeout);
        this.isShowing = false;
      }
      this.isShowing = true;
      this.showTimeout = setTimeout(() => { this.isShowing = false; }, this.showDelay);
    },
  },
  mounted() {
    this.$parent.$on('showHint', this.showHint);
  }
};
</script>

<style scoped>
.dialog-hint {
  padding: 0 10px;
  position: absolute;
  width: fit-content;
  height: 0;
  bottom: -15px;
  left: 10%;
  transform: translate(0, 0);
  transition: all 0.2s ease;
}
.dialog-hint:after {
  content: '';
  transform: perspective(18px) rotateX(7deg);
  height: calc(100% + 18px);
  position: absolute;
  width: calc(100% + 60px);
  bottom: -10px;
  left: -30px;
  z-index: -1;
  /*border: 1px solid;*/
  border-radius: 15px;
}
.dialog-hint p {
  margin: 0;
}
.showing {
  height: 25px;
  bottom: 0;
}
.show-error:after {
  background: rgba(250, 30, 30, 0.3);
  border: 3px double rgba(0,0,0,0.3);
  /*box-shadow: 0 0 6px 6px rgba(250, 30, 30, 0.5);*/
  /*border: 1px solid rgba(255, 54, 54, 0.8);*/
}
.show-success:after {
  background: rgba(78, 250, 30, 0.3);
  border: 3px double rgba(0,0,0,0.3);
  /*box-shadow: 0 0 6px 6px rgba(78, 250, 30, 0.5);*/
  /*border: 1px solid rgba(84, 255, 54, 0.8);*/
}
.show-info:after {
  background: rgba(54, 171, 255, 0.3);
  border: 3px double rgba(0,0,0,0.3);
  /*box-shadow: 0 0 6px 6px rgba(250, 249, 30, 0.5);*/
  /*border: 1px solid rgba(255, 215, 54, 0.8);*/
}
</style>
