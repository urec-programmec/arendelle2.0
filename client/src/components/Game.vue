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
        if (this.v1 === 0) {
          this.v1 = 1
          this.c1 = this.colorr
        } else {
          return
        }
      }
      if (id === 2) {
        if (this.v2 === 0) {
          this.v2 = 1
          this.c2 = this.colorr
        } else {
          return;
        }
      }
      if (id === 3) {
        if (this.v3 === 0) {
          this.v3 = 1
          this.c3 = this.colorr
        } else {
          return;
        }
      }
      if (id === 4) {
        if (this.v4 === 0) {
          this.v4 = 1
          this.c4 = this.colorr
        } else {
          return;
        }
      }
      if (id === 5) {
        if (this.v5 === 0) {
          this.v5 = 1
          this.c5 = this.colorr
        } else {
          return;
        }
      }
      if (id === 6) {
        if (this.v6 === 0) {
          this.v6 = 1
          this.c6 = this.colorr
        } else {
          return;
        }
      }
      if (id === 7) {
        if (this.v7 === 0) {
          this.v7 = 1
          this.c7 = this.colorr
        } else {
          return;
        }
      }
      if (id === 8) {
        if (this.v8 === 0) {
          this.v8 = 1
          this.c8 = this.colorr
        } else {
          return;
        }
      }
      if (id === 9) {
        if (this.v9 === 0) {
          this.v9 = 1
          this.c9 = this.colorr
        } else {
          return;
        }
      }
      if (this.colorr === 'red') {
        this.colorr = 'blue'
      } else {
        this.colorr = 'red'
      }
    }
  },
  mounted () {

  }
}
</script>

<style scoped>
.poloc_centr:hover, .poloc_right:hover, .poloc_bottom:hover, .poloc_top:hover, .poloc_left:hover {
  cursor: pointer;
}
.poloc_centr {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 300px;
  height: 300px;
  background: whitesmoke;
  border: 5px solid rgba(0, 0, 0, 0);
}.poloc_bottom {
   display: flex;
   align-items: center;
   justify-content: center;
  width: 300px;
  height: 300px;
  background: whitesmoke;
  border: 5px solid black;
  border-bottom-color: rgba(0, 0, 0, 0);
}.poloc_right {
    display: flex;
    align-items: center;
    justify-content: center;
  width: 300px;
  height: 300px;
  background: whitesmoke;
  border: 5px solid black;
  border-right-color: rgba(0, 0, 0, 0);
}.poloc_left {
     display: flex;
     align-items: center;
     justify-content: center;
  width: 300px;
  height: 300px;
  background: whitesmoke;
  border: 5px solid black;
  border-left-color: rgba(0, 0, 0, 0);
}.poloc_top {
      display: flex;
      align-items: center;
      justify-content: center;
   width: 300px;
   height: 300px;
   background: whitesmoke;
   border: 5px solid black;
   border-top-color: rgba(0, 0, 0, 0);
 }
 .krug {
   border-radius: 50%;
   width: 200px;
   height: 200px;
 }

.pole {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: whitesmoke;

  width: 930px;
  height: 930px;

  display: flex;
  align-items: center;
  justify-content: center;
  flex-wrap: wrap;

}
</style>
