<template>
  <div>
    <div class="refresh">
      <i :class="['bx', 'bx-refresh', { 'bx-spin' : refresh }]"/>
      <p class="refresh-time">{{ time + ' сек' }}</p>
      <p class="refresh-time" style="font-size: 0.5em">{{ timeout }}</p>
    </div>
    <div class="refresh-time-container"
         :style="{ top: isShowing ? '70px' : '-15px' }">
      <div class="refresh-time-item"
           :style="{ color: isShowing ? 'unset' : 'rgba(0, 0, 0, 0)' }"
           v-for="(time, index) in times" :key="index"
           @click="setTime(time)">{{ time + ' сек' }}</div>
      <div class="refresh-time-item-i"
           @mouseenter="isHover = true"
           @mouseleave="isHover = false">
        <i :class="['bx', isShowing ? 'bx-chevron-up' : 'bx-chevron-down', { 'hovered-to-test' : isHover }]"
           @click.stop="showTimes"/>
      </div>
    </div>

  </div>
</template>

<script>
export default {
  name: 'Refresh',
  data () {
    return {
      isHover: false,
      isShowing: false,
      times: [5, 10, 30, 60],
      time: 10,
      timeout: 10,
      refresh: false
    }
  },
  methods: {
    showTimes () {
      this.isShowing = !this.isShowing
    },
    setTime (newTime) {
      this.time = newTime
      this.timeout = this.time
      this.showTimes()
    }
  },
  mounted () {
    setInterval(() => {
      this.timeout--
      if (this.timeout === 0) {
        this.timeout = this.time
        this.refresh = true
        this.$emit('refresh')
      }
    }, 1000)

    this.$parent.$on('refreshEnd', () => { this.refresh = false })
  }
}
</script>

<style scoped>
.refresh-time-container,
.refresh {
  position: fixed;
  width: 48px;
  right: 0;
  z-index: 100;
  display: flex;
  justify-content: center;
  align-items: center;
  color: #F5F5F5;
}
.refresh-time-container {
  height: fit-content;
  flex-direction: column;
  transition: all 0.3s ease;
}
.refresh-time-container .refresh-time-item,
.refresh-time-container .refresh-time-item-i {
  height: 20px;
  width: 95%;
  display: flex;
  justify-content: center;
  align-items: center;
}
.refresh-time-container .refresh-time-item {
  font-size: 0.7em;
  transition: inherit;
  border-radius: 5px;
}
.refresh-time-container .refresh-time-item:hover {
  border: 1px solid rgba(255, 255, 255, 0.4);
  cursor: pointer;
}
.refresh-time-container .refresh-time-item-i {
  font-size: 1.3em;
  cursor: pointer;
}
.refresh-time {
  margin: 0;
  font-size: 0.7em;
  background: rgba(17, 16, 29, 0.85);
}
.refresh {
  height: 65px;
  top: 0;
  background: rgba(17, 16, 29, 0.85);
  box-shadow: 0 0 6px 6px rgba(54, 171, 255, 0.2);
  border-bottom-left-radius: 10px;
  z-index: 200;
  flex-direction: column;
}
.refresh i {
  font-size: 28px;
  text-align: center;
  margin: 0 12px;
  color: rgba(255,255,255,1);
  transition: all .2s ease;
}
.hovered-to-test {
  transform: scale(1.2);
}
</style>
