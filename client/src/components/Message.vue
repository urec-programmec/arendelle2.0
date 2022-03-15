<template>
  <div class="save-map"
       :style="{width: getComputedWidth + 'px'}"
       @click.stop="test"
       @mouseenter="onHover"
       @mouseleave="onHoverEnd">
    <i :class="['bx', getComputedClasses]"/>
    <p ref="content" :style="{ color: isHover ? '#F5F5F5' : 'rgba(0, 0, 0, 0)',
                              transition: isHover ? 'color 0.2s cubic-bezier(1, 0, 1, 0)' : 'color 0.2s cubic-bezier(0, 1, 0, 1)'}">{{ content }}</p>
  </div>
</template>

<script>
export default {
  name: 'Message',
  data() {
    return {
      isTesting: false,
      isHover: false,
      defaultComputedWidth: 48,
      computedWidth: 48,
      content: 'протестировать',
      contentMain: 'протестировать',
      contentTest: 'вернуться в режим редактирования',
    };
  },
  methods: {
    test() {
      this.isTesting = !this.isTesting;
      this.content = this.isTesting ? this.contentTest : this.contentMain;
      this.$emit('testMap', {
        isTesting: this.isTesting,
      });
      setTimeout(this.recalculateComputedWidth, 0);
    },
    onHover() {
      this.isHover = true;
      this.recalculateComputedWidth();
    },
    onHoverEnd() {
      this.isHover = false;
      this.recalculateComputedWidth();
    },
    recalculateComputedWidth() {
      this.computedWidth = this.isHover ? this.defaultComputedWidth + 5 + this.$refs.content.clientWidth : this.defaultComputedWidth;
    },
  },
  computed: {
    getComputedClasses() {
      return this.isTesting ? [
        'bx-exit-fullscreen',
        'out',
      ] : [
        'bx-fullscreen',
        'in',
      ];
    },
    getComputedWidth() {
      return this.computedWidth;
    },
  },
};
</script>

<style scoped>
.save-map {
  position: fixed;
  height: 40px;
  right: 0;
  top: 0;
  /*padding: 14px 23px;*/
  transition: all 0.2s ease;
  overflow: hidden;
  background: rgba(17, 16, 29, 0.85);
  border-bottom-left-radius: 10px;
  z-index: 10;
}
.save-map:hover i {
  color:rgba(255,255,255,0);
}
@keyframes color-change {
  0%{background-position:left}
  100%{background-position:right}
}
.save-map i {
  position: absolute;
  display:block;
  /*top: 50%;*/
  /*left: 0;*/
  right: 0;
  top: 20px;
  transform: translateY(-50%);
  width: 26px;
  font-size: 28px;
  text-align: center;
  margin: 0 12px;
  color: rgba(255,255,255,1);
  transition: color .3s ease-in-out;
  background-size: 100%;
  animation: color-change 0.3s;
  animation-fill-mode: forwards;
  background-clip: text;
  -webkit-background-clip: text;
}
.save-map p {
  position: relative;
  display: block;
  line-height: 0;
  top: 50%;
  left: 10px;
  font-size: 15px;
  font-weight: 400;
  white-space: nowrap;
  pointer-events: none;
  margin: 0;
  width: fit-content;
}
.in {
  background: linear-gradient(to right, #00416a, #799f0c, #ffe000);
}
.out {
  background: linear-gradient(to right, rgba(155, 23, 4, 0.99), rgba(255, 115, 0, 1));
}
</style>
