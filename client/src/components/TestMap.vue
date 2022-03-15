<template>
  <div class="save-map"
       :style="{width: '48px'}"
       @click.stop="test"
       @mouseenter="onHover"
       @mouseleave="onHoverEnd">
    <i :class="['bx', computedClasses]"/>
  </div>
</template>

<script>
export default {
  name: 'TestMap',
  data() {
    return {
      isTesting: false,
      isHover: false,
      computedClasses: ['bx-fullscreen'],
    };
  },
  methods: {
    test() {
      this.isTesting = !this.isTesting;
      this.$emit('testMap', {
        isTesting: this.isTesting,
      });
      setTimeout(this.recalculateComputedClasses, 0);
    },
    onHover() {
      this.isHover = true;
      this.recalculateComputedClasses();
    },
    onHoverEnd() {
      this.isHover = false;
      this.recalculateComputedClasses();
    },
    recalculateComputedClasses() {
      this.computedClasses = [
        this.isHover ? (this.isTesting ? 'hovered-exit-test' : 'hovered-to-test') : '',
        this.isHover ? 'hovered' : '',
        this.isTesting ? 'bx-exit-fullscreen' : 'bx-fullscreen',
      ];
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
  background: rgba(17, 16, 29, 0.85);
  border-bottom-left-radius: 10px;
  z-index: 10;
  display: flex;
  justify-content: center;
  align-items: center;
}
.save-map i {
  font-size: 28px;
  text-align: center;
  margin: 0 12px;
  color: rgba(255,255,255,1);
  transition: all .2s ease;
}
.hovered {
  cursor: pointer;
}
.hovered-exit-test {
  transform: scale(0.8);
}
.hovered-to-test {
  transform: scale(1.2);
}
</style>
