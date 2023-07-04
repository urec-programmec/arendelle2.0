<template>
  <div class="pole">
    <div class="poloc_centr" @click="naved(1)">
      <div class="krug" :style="{'background':c1, opacity: v1}"></div>
    </div>
    <div class="poloc_top" @click="naved(2)">
      <div class="krug" :style="{'background':c2, opacity: v2}"></div>
    </div>
    <div class="poloc_centr" @click="naved(3)">
      <div class="krug" :style="{'background':c3, opacity: v3}"></div>
    </div>

    <div class="poloc_left" @click="naved(4)">
      <div class="krug" :style="{'background':c4, opacity: v4}"></div>
    </div>
    <div class="poloc_centr" @click="naved(5)">
      <div class="krug" :style="{'background':c5, opacity: v5}"></div>
    </div>
    <div class="poloc_right" @click="naved(6)">
      <div class="krug" :style="{'background':c6, opacity: v6}"></div>
    </div>

    <div class="poloc_centr" @click="naved(7)">
      <div class="krug" :style="{'background':c7, opacity: v7}"></div>
    </div>
    <div class="poloc_bottom" @click="naved(8)">
      <div class="krug" :style="{'background':c8, opacity: v8}"></div>
    </div>
    <div class="poloc_centr" @click="naved(9)">
      <div class="krug" :style="{'background':c9, opacity: v9}"></div>
    </div>
  </div>
</template>

<script>

export default {
  name: 'Game',
  data () {
    return {
      c1: '',
      v1: 0,
      c2: '',
      v2: 0,
      c3: '',
      v3: 0,
      c4: '',
      v4: 0,
      c5: '',
      v5: 0,
      c6: '',
      v6: 0,
      c7: '',
      v7: 0,
      c8: '',
      v8: 0,
      c9: '',
      v9: 0,
      colorr: 'red'
    }
  },
  methods: {

    naved (id) {

      if (id === 1) {
        this.v1 = 1
        this.c1 = this.colorr
      }
      if (id === 2) {
        this.v2 = 2
        this.c2 = this.colorr
      }
      if (id === 3) {
        this.v3 = 3
        this.c3 = this.colorr
      }
      if (id === 4) {
        this.v4 = 4
        this.c4 = this.colorr
      }
      if (id === 5) {
        this.v5 = 5
        this.c5 = this.colorr
      }
      if (id === 6) {
        this.v6 = 6
        this.c6 = this.colorr
      }
      if (id === 7) {
        this.v7 = 7
        this.c7 = this.colorr
      }
      if (id === 8) {
        this.v8 = 8
        this.c8 = this.colorr
      }
      if (id === 9) {
        this.v9 = 9
        this.c9 = this.colorr
      }
      if (this.colorr === 'red'){
        this.colorr = 'blue'
      }
      else{
        this.colorr = 'red'
      }
    }
  },
  mounted () {

  }
}
</script>

<style scoped>
.poloc_centr:hover {
  cursor: pointer;
}
.poloc_centr {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 33%;
  height: 33%;
  background: whitesmoke;
}.poloc_bottom {
   display: flex;
   align-items: center;
   justify-content: center;
  width: 33%;
  height: 33%;
  background: whitesmoke;
  border: 5px solid black;
  border-bottom: none;
}.poloc_right {
    display: flex;
    align-items: center;
    justify-content: center;
  width: 33%;
  height: 33%;
  background: whitesmoke;
  border: 5px solid black;
  border-right: none;
}.poloc_left {
     display: flex;
     align-items: center;
     justify-content: center;
  width: 33%;
  height: 33%;
  background: whitesmoke;
  border: 5px solid black;
  border-left: none;
}.poloc_top {
      display: flex;
      align-items: center;
      justify-content: center;
   width: 33%;
   height: 33%;
   background: whitesmoke;
   border: 5px solid black;
   border-top: none;
 }
 .krug {
   border-radius: 50%;
   width: 50px;
   height: 50px;
 }

.pole {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: whitesmoke;

  width: 80%;
  height: 80%;

  display: flex;
  align-items: center;
  justify-content: space-around;
  flex-wrap: wrap;
}
</style>
