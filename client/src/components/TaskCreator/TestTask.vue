<template>
  <div class="test-task"
       :style="{width: '48px'}"
       @click.stop="test"
       @mouseenter="isHover = true"
       @mouseleave="isHover = false">
    <i :class="['bx', 'bx-fullscreen',
    { 'hovered-to-test' : isHover }]"/>
  </div>
</template>

<script>
export default {
  name: 'TestTask',
  data() {
    return {
      isHover: false,
    };
  },
  methods: {
    test() {
      this.$emit('testTask');
    },
  },
};
</script>

<style scoped>
.test-task {
  position: fixed;
  height: 40px;
  right: 0;
  top: 0;
  background: rgba(17, 16, 29, 0.85);
  border-bottom-left-radius: 10px;
  z-index: 100;
  display: flex;
  justify-content: center;
  align-items: center;
}
.test-task i {
  font-size: 28px;
  text-align: center;
  margin: 0 12px;
  color: rgba(255,255,255,1);
  transition: all .2s ease;
}
.test-task:hover i {
  cursor: pointer;
}
.hovered-to-test {
  transform: scale(1.2);
}
</style>
