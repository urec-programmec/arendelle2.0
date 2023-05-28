<template>
  <vue-draggable-resizable class="instrument-panel"
                           :parent="true"
                           :w="w"
                           :h="h"
                           :minWidth="w"
                           :maxHeight="maxInstrumentPanelHeight"
                           :minHeight="minInstrumentPanelHeight"
                           :x="instrumentPanelX"
                           :y="instrumentPanelY"
                           :handles="['tl']"
                           :draggable="instrumentPanelDraggable"
                           @resizing="(x, y, w, h) => {instrumentPanelExtendedWidth = h}">
    <div class="instrument-panel-header">инструменты</div>
    <div class="instrument-panel-container">
      <div class="instrument-panel-title">размер</div>
      <div class="instrument-panel-item">
        <vue-slider v-model="cursorSize"
                    :tooltip-formatter="blockFormatter"
                    :min="minCursorSize"
                    :max="maxCursorSize"
                    :interval="1"
                    @drag-start="() => instrumentPanelDraggable = false"
                    @drag-end="() => instrumentPanelDraggable = true"
                    @change="() => sendParameters()">
          <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
            <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ value }}</div>
          </template>
        </vue-slider>
      </div>
      <div :class="['instrument-panel-title', {'none': instrumentPanelExtendedWidth <= maxInstrumentPanelHeight - 60}]" style="margin-top: 6px; margin-bottom: 3px">форма</div>
      <div :class="['instrument-panel-item', {'none': instrumentPanelExtendedWidth <= maxInstrumentPanelHeight - 60}]" style="display: flex; flex-direction: row; justify-content: left; padding-left: 7px;">
        <i v-for="f in forms" :key="f.key"
           :class="['bx', f.class, { 'form-selected': f.selected }, 'instrument-panel-item-hover']"
           @click="onFormChange(f.key)"
           style="padding-right: 10px;"/>
      </div>
      <div v-if="type === 'places'" :class="['instrument-panel-title', {'none': instrumentPanelExtendedWidth <= maxInstrumentPanelHeight - 20}]" style="margin-top: 10px; margin-bottom: 3px">местность</div>
      <div v-if="type === 'places'" :class="['instrument-panel-item', {'none': instrumentPanelExtendedWidth <= maxInstrumentPanelHeight - 20}]" style="display: flex; flex-direction: row; justify-content: left; padding-left: 7px;">
        <div v-for="(p, index) in places" :key="index"
             :class="['instrument-panel-item-hover', 'instrument-panel-item-place', place === p.id ? 'instrument-panel-item-place-selected' : '']"
           @click="onPlaceChange(p.id)">
          <div :style="{ backgroundImage: p.url, width: '32px', height: '32px', borderRadius: '3px' }"></div>
        </div>
      </div>
      <div v-if="type === 'dairs'" :class="['instrument-panel-title', {'none': instrumentPanelExtendedWidth <= maxInstrumentPanelHeight - 20}]" style="margin-top: 10px; margin-bottom: 3px">владелец</div>
      <div v-if="type === 'dairs'" :class="['instrument-panel-item', {'none': instrumentPanelExtendedWidth <= maxInstrumentPanelHeight - 20}]" style="display: flex; flex-direction: row; justify-content: left; padding-left: 7px;">
        <div v-for="(d, index) in dairs" :key="index"
             :style="{'--first-color': '1px solid ' + d.color, '--second-color': '1px solid ' + d.colorSecond}"
             :class="['instrument-panel-item-hover', 'instrument-panel-item-dair', dair === d.id ? 'instrument-panel-item-dair-selected' : '']"
           @click="onDairChange(d.id)">
          <div class="instrument-panel-item-dair-text" :style="{ '--first-color': d.color, '--second-color':  d.colorSecond }">
            <div style="background: rgba(17, 16, 29, 0.85); padding: 0 3px; border-radius: 3px; font-size: 0.9em; line-height: 1.4em;">{{d.name}}</div>
          </div>
        </div>
      </div>
      <div class="instrument-panel-item-right" @click="onSolidChange">
        <div class="instrument-panel-title instrument-panel-title-right">заливка</div>
        <div :class="['instrument-panel-solid', { 'instrument-panel-solid-enable': cursorSolid } ]"/>
      </div>
    </div>
  </vue-draggable-resizable>
</template>

<script>
import 'vue-slider-component/theme/antd.css';
import 'vue-draggable-resizable/dist/VueDraggableResizable.css';
import VueSlider from 'vue-slider-component';
import VueDraggableResizable from 'vue-draggable-resizable';

import '../assets/css/custom-dot.css';

export default {
  name: 'InstrumentPanel',
  components: { VueSlider, VueDraggableResizable },
  data() {
    return {
      minCursorSize: 1,
      maxCursorSize: 5,
      maxCursorNotSolidSize: 5,
      maxCursorSolidSize: 5,

      instrumentPanelDraggable: true,
      minInstrumentPanelHeight: 65,
      instrumentPanelExtendedWidth: this.h,
      maxInstrumentPanelHeight: this.h,
      blockFormatter: (val) => {
        if (val % 10 >= 5 || val % 10 === 0 || val > 10 && val < 20) {
          return val + ' блоков';
        } else if (val % 10 === 1) {
          return val + ' блок';
        }
        return val + ' блока';
      },
      cursorSize: 3,
      cursorSolid: true,
      cursorForm: 'circle',
      place: 1,
      dair: 1,

      forms: [{
        'key': 'circle',
        'class': 'bx-circle',
        'mainClass': 'bx-circle',
        'solidClass': 'bxs-circle',
        'selected': true,
      }, {
        'key': 'square',
        'class': 'bx-square',
        'mainClass': 'bx-square',
        'solidClass': 'bxs-square',
        'selected': false,
      },
      ],
      places: {
        1: {
          id: 1,
          url: `url(${require('../assets/images/grounds/ground.jpg')})`,
        },
        2: {
          id: 2,
          url: `url(${require('../assets/images/grounds/mountains.png')})`,
        },
        3: {
          id: 3,
          url: `url(${require('../assets/images/grounds/forest.png')})`,
        },
        4: {
          id: 4,
          url: `url(${require('../assets/images/grounds/water.png')})`,
        },
      },
      dairs: {
        1: {
          id: 1,
          name: 'Ф',
          color: '#be00ff',
          colorSecond: 'rgba(185,54,255,0.26)',
        },
        2: {
          id: 2,
          name: 'Х',
          color: '#26ee20',
          colorSecond: 'rgba(74,255,54,0.26)',
        },
        3: {
          id: 3,
          name: 'Л',
          color: '#36abff',
          colorSecond: 'rgba(54,171,255,0.25)',
        },
        4: {
          id: 4,
          name: 'А',
          color: '#ff8400',
          colorSecond: 'rgba(255,188,54,0.26)',
        },
        5: {
          id: 5,
          name: 'Н',
          color: '#ff2828',
          colorSecond: 'rgba(255,54,54,0.26)',
        },
        7: {
          id: -1,
          name: '',
          color: '#d5d5d5',
          colorSecond: 'rgba(215,215,215,0.26)',
        },
      },
    };
  },
  methods: {
    onFormChange(key) {
      this.cursorForm = key;
      for (let form of this.forms) {
        form['selected'] = form['key'] === key;
      }
      this.sendParameters();
    },
    onSolidChange() {
      this.cursorSolid = !this.cursorSolid;
      if (this.cursorSolid) {
        if (this.cursorSize > this.maxCursorSolidSize) {
          this.cursorSize = this.maxCursorSolidSize;
        }
        this.maxCursorSize = this.maxCursorSolidSize;
      } else {
        this.maxCursorSize = this.maxCursorNotSolidSize;
      }
      for (let form of this.forms) {
        form['class'] = this.cursorSolid ? form['solidClass'] : form['mainClass'];
      }
      this.sendParameters();
    },
    onPlaceChange(id) {
      if (this.place !== id) {
        this.place = id;
        this.sendParameters();
      }
    },
    onDairChange(id) {
      if (this.dair !== id) {
        this.dair = id;
        this.sendParameters();
      }
    },
    sendParameters() {
      this.$emit('changeParameters', {
        'cursorSolid': this.cursorSolid,
        'cursorForm': this.cursorForm,
        'cursorSize': this.cursorSize,
        'cursorPlace': this.place,
        'cursorDair': this.dair,
      });
    },
  },
  computed: {
    instrumentPanelX() {
      return window.innerWidth - this.w - 40;
    },
    instrumentPanelY() {
      return window.innerHeight - this.h - 80;
    },
  },
  props: {
    type: {
      type: String,
      default: '',
    },
    w: {
      type: Number,
      default: 365,
    },
    h: {
      type: Number,
      default: 165,
    },
  },
};
</script>

<style scoped>
.instrument-panel {
  border-radius: 10px;
  background: rgba(17, 16, 29, 0.85);
  color: #F5F5F5;
  border: 1px solid;
  border-color: rgb(33, 37, 41);
  position: absolute;
  z-index: 1000 !important;
}
.instrument-panel-header {
  position: absolute;
  line-height: 0.8em;
  left: 50%;
  transform: translate(-50%, 0);
}
.instrument-panel-container {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: 20px 52px 10px 10px;
}
.instrument-panel-item {
  width: 100%;
  height: fit-content;
  border-radius: 15px;
  padding: 5px 15px 5px 15px;
  min-height: 30px;
  background: rgba(17, 16, 29, 0.5);
}
.instrument-panel-item-right {
  position: absolute;
  right: 10px;
  top: 30px;
  height: calc(100% - 44px);
  min-height: 20px;
  width: 30px;
  padding: 2px;
  border-radius: 10px;
  border: 1px solid;
}
.instrument-panel-title {
  position: relative;
  height: 0;
  padding-left: 10px;
  line-height: 0;
  font-size: 0.6em;
}
.instrument-panel-item-right:hover {
  cursor: pointer;
}
.instrument-panel-title-right {
  left: 50%;
  top: -10px;
  padding-left: 0;
  width: calc(100% + 20px);
  transform: translate(-50%, 0);
  font-size: 0.6em;
  text-align: center
}
.instrument-panel-item i {
  height: 32px;
  min-width: 32px;
  font-size: 32px;
  opacity: 0.5;
}
.instrument-panel-item-hover {
  transition: all 0.15s ease;
}
.instrument-panel-item-place-selected {
  border: 1px solid #F5F5F5 !important;
}
.instrument-panel-item-place:hover {
  /*border: 1px solid rgba(255, 255, 255, 0.4);*/
}
.instrument-panel-item-dair-selected {
  border: var(--first-color) !important;
}
.instrument-panel-item-dair-selected .instrument-panel-item-dair-text, .instrument-panel-item-dair-text:hover {
  background: var(--first-color);
}
.instrument-panel-item-dair:hover .instrument-panel-item-dair-text {
  border: var(--second-color);
}
.instrument-panel-item-dair-text {
  background: var(--second-color);
  border-radius: 3px;
  height: 32px;
  width: 32px;
  display: flex;
  justify-content: center;
  align-items: center;
  transition: all 0.15s ease;
}
.instrument-panel-item-place, .instrument-panel-item-dair {
  width: 40px;
  height: 40px;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-right: 6px;
  border-radius: 5px;
  /*transition: none;*/
}
.instrument-panel-item-hover:hover {
  cursor: pointer;
  transform: scale(1.2);
  opacity: 1;
}
.none {
  display: none !important;
}
.form-selected {
  /*color: #36abff;*/
  color: #9CC6FF;
  opacity: 1 !important;
  font-weight: bold;
}
.instrument-panel-solid {
  background-image: url('../assets/images/global/waves.png');
  /*background: wheat;*/
  background-size: auto 100%;
  background-position: top right;
  position: absolute;
  bottom: 2px;
  width: calc(100% - 4px);
  height: 0;
  transition: all 1s ease-out;
  border-radius: 10px;
}


.instrument-panel-solid-enable {
  height: calc(100% - 4px);
  background-position: top left;
  transition: all 1s ease-out;
}
</style>
