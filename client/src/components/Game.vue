<template>
  <div class="container">
    <div class="train-container">
      <div class="train" :style="{ background : tablet.color }" v-for="(tablet, index) in tablets" :key="index" @click="changeColor(tablet)"></div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Game',
  data () {
    return {
      tabletsCount: 27,
      tablets: []
    }
  },
  methods: {
    getColor () {
      let r = Math.round(Math.random() * 255)
      let g = Math.round(Math.random() * 255)
      let b = Math.round(Math.random() * 255)

      return 'rgb(' + r + ', ' + g + ', ' + b + ')'
    },
    changeColor (tablet) {
      tablet.color = this.getColor()
    },
    initTablets () {
      for (let i = 0; i < this.tabletsCount; i++) {
        this.tablets.push({
          color: this.getColor()
        })
      }
    }
  },
  mounted () {
    this.initTablets()
  }
}
</script>

<style scoped>
.container {
  width: 100%;
  height: 100%;
  background: white;
}
.train:hover {
  cursor: pointer;
  border-color: black;
}
.train {
  width: 100px;
  height: 100px;
  border-radius: 10px;
  border: 5px solid rgba(0, 0, 0, 0);
}
.train-container {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: wheat;

  width: 80%;
  height: 80%;

  display: flex;
  align-items: center;
  justify-content: space-around;
  flex-wrap: wrap;
}
</style>
