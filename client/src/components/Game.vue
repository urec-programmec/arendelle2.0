<template>
  <div class="pole">
    <div class="row" v-for="(row, i) in table" :key="i">
      <div class="poloc_centr" @click="click(item)" v-for="(item, j) in row" :key="j">
          <div class="krug" :style="{'background': item.c , opacity: getOpacity(item.v)}"></div>
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
      size: 3
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
            v: false,
            c: '',
            x: j,
            y: i
          })
        }
        this.table.push(row)
      }
    },
    click (item) {
      if (!item.v) {
        item.c = this.type
        item.v = true
      } else {
        return
      }
      if (this.type === 1) {
        this.type = 2
      } else {
        this.type = 1
      }
      this.win2_0(item.x, item.y)
    },
    win2_0 (x, y) {
      return this.win(x, y, x, y + 1, x, y + 2) ||
        this.win(x, y, x, y - 1, x, y - 2) ||
        this.win(x, y, x + 1, y, x + 2, y) ||
        this.win(x, y, x - 1, y, x - 2, y) ||
        this.win(x, y, x + 1, y + 1, x + 2, y + 2) ||
        this.win(x, y, x - 1, y + 1, x - 2, y + 2) ||
        this.win(x, y, x + 1, y - 1, x + 2, y - 2) ||
        this.win(x, y, x - 1, y - 1, x - 2, y - 2) ||
        this.win(x, y + 1, x, y, x, y - 1) ||
        this.win(x + 1, y, x, y, x - 1, y) ||
        this.win(x + 1, y + 1, x, y, x - 1, y - 1) ||
        this.win(x - 1, y + 1, x, y, x + 1, y - 1)
    },
    win (x1, y1, x2, y2, x3, y3) {
      if (x1 < 0 || x1 >= this.size || x2 < 0 || x2 >= this.size || x3 < 0 || x3 >= this.size || y1 < 0 || y1 >= this.size || y2 < 0 || y2 >= this.size || y3 < 0 || y3 >= this.size) {
        return false
      }
      let itr1 = this.table[y1][x1]
      let itr2 = this.table[y2][x2]
      let itr3 = this.table[y3][x3]
      if (itr1.v && itr2.v && itr3.v) {
        if (itr1.c === 1 && itr2.c === 1 && itr3.c === 1) {
          setTimeout(() => {
            alert('Победил красный петух')
            this.reset()
          }, 0)
        }
        if (itr1.c === 2 && itr2.c === 2 && itr3.c === 2) {
          setTimeout(() => {
            alert('Победил синий петух')
            this.reset()
          }, 0)
        }
      }
    },
    getOpacity (a) {
      if (a === true) {
        return 1
      } else {
        return 0
      }
    }
  },
  mounted () {
    this.reset()
  }
}
</script>

<style scoped>
.row {
  display: flex;
  align-items: center;
  justify-content: center;
}
.poloc_centr:hover, .poloc_right:hover, .poloc_bottom:hover, .poloc_top:hover, .poloc_left:hover {
  cursor: pointer;
}
.poloc_centr {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 130px;
  height: 130px;
  background: whitesmoke;
  border: 1px solid black;
}
 .krug {
   border-radius: 50%;
   width: 70%;
   height: 70%;
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
