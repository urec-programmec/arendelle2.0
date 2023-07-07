<template>
  <div class="pole">
    <div class="row" v-for="(row, i) in table" :key="i">
      <div class="poloc_centr" v-for="(item, j) in row" :key="j" :style="{background: estz(item)}">
      </div>
    </div>
    <div class="panel">
      <div class="panel_pust"></div>
      <div class="panel_class" @click="sneik_napr('t')">
        <i class='bx bxs-up-arrow-alt' ></i>
      </div>
      <div class="panel_pust"></div>
      <div class="panel_class" @click="sneik_napr('l')">
        <i class='bx bxs-left-arrow-alt' ></i>
      </div>
      <div class="panel_class" @click="sneik_napr('b')">
        <i class='bx bxs-down-arrow-alt' ></i>
      </div>
      <div class="panel_class" @click="sneik_napr('r')">
        <i class='bx bxs-right-arrow-alt' ></i>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: 'Game',
  data () {
    return {
      type: 1,
      table: [],
      size: 20,
      time: 250,
      zmey: {
        x: -1,
        y: -1,
        napr: 'r'
      },
      yabloko: {
        xya: -1,
        yya: -1
      }
    }
  },
  methods: {
    reset () {
      this.table = []
      this.type = 1
      for (let i = 0; i < this.size; i++) {
        let row = []
        for (let j = 0; j < this.size; j++) {
          row.push({
            x: j,
            y: i
          })
        }
        this.table.push(row)
      }
      this.zmey.x = Math.floor(Math.random() * this.size)
      this.zmey.y = Math.floor(Math.random() * this.size)
      this.poedan()
    },
    estz (item) {
      if (item.y === this.zmey.y && item.x === this.zmey.x) {
        return 'black'
      } else if (item.y === this.yabloko.yya && item.x === this.yabloko.xya) {
        return 'red'
      } else {
        return 'white'
      }
    },
    sneik_pereh () {
      setInterval(() => {
        if (this.zmey.y === this.yabloko.yya && this.zmey.x === this.yabloko.xya) {
          this.poedan()
        }
        if (this.zmey.napr === 'r') {
          if (this.zmey.x === this.size - 1) {
            this.zmey.x = 0
          } else {
            this.zmey.x++
          }
        }
        if (this.zmey.napr === 'l') {
          if (this.zmey.x === 0) {
            this.zmey.x = this.size - 1
          } else {
            this.zmey.x--
          }
        }
        if (this.zmey.napr === 'b') {
          if (this.zmey.y === this.size - 1) {
            this.zmey.y = 0
          } else {
            this.zmey.y++
          }
        }
        if (this.zmey.napr === 't') {
          if (this.zmey.y === 0) {
            this.zmey.y = this.size - 1
          } else {
            this.zmey.y--
          }
        }
      }, this.time)
    },
    sneik_napr (napr) {
      this.zmey.napr = napr
    },
    poedan () {
      this.yabloko.xya = Math.floor(Math.random() * this.size)
      this.yabloko.yya = Math.floor(Math.random() * this.size)
      console.log(this.yabloko.xya, this.yabloko.yya)
    }
  },
  mounted () {
    this.reset()
    this.sneik_pereh()
  }
}
</script>

<style scoped>
@import url('https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css');

.row {
  display: flex;
  align-items: center;
  justify-content: center;
}
.panel_pust {
  display: flex;
  width: 100px;
  height: 100px;
  border: 2px solid whitesmoke;
  background: whitesmoke;
}
.panel_class {
  border: 2px solid black;
  background: #26f5b7;
  width: 100px;
  height: 100px;
  display: flex;
  border-radius: 20%;
  font-size: 100px;
}
.panel {
  width: 312px;
  height: 212px;
  display: flex;
  flex-wrap: wrap;
  margin-top: 50px;

}
.poloc_centr:hover, .panel_class:hover{
  cursor: pointer;
}
.poloc_centr {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 30px;
  height: 30px;
  border: 1px solid black;
}
.pole {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: whitesmoke;

  width: 100%;
  height: 100%;

  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
}
</style>
