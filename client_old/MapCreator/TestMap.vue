<template>
  <div class="test-map"
       :style="{width: '48px'}"
       @click.stop="test"
       @mouseenter="isHover = true"
       @mouseleave="isHover = false">
    <i :class="['bx',
    { 'hovered-exit-test' : isHover && isTesting },
    { 'hovered-to-test' : isHover && !isTesting },
    { 'bx-exit-fullscreen' : isTesting },
    { 'bx-fullscreen' : !isTesting }]"/>
  </div>
</template>

<script>
export default {
  name: 'TestMap',
  data () {
    return {
      isTesting: false,
      isHover: false
    }
  },
  methods: {
    test () {
      this.$emit('testMap', {
        isTesting: !this.isTesting
      })
    },
    setTesting (data) {
      this.isTesting = data['isTesting']
    }
  },
  created () {
    this.$parent.$on('setTesting', this.setTesting)
  }
}
</script>

<style scoped>
.test-map {
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
.test-map i {
  font-size: 28px;
  text-align: center;
  margin: 0 12px;
  color: rgba(255,255,255,1);
  transition: all .2s ease;
}
.test-map:hover i {
  cursor: pointer;
}
.hovered-exit-test {
  transform: scale(0.8);
}
.hovered-to-test {
  transform: scale(1.2);
}
</style>
