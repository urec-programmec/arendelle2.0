<template>
  <vue-draggable-resizable class="instrument-panel"
                           :parent="true"
                           :w="170"
                           :h="120"
                           :minWidth="170"
                           :maxHeight="maxInstrumentPanelHeight"
                           :minHeight="minInstrumentPanelHeight"
                           :x="instrumentPanelX"
                           :y="instrumentPanelY"
                           :handles="['tl']"
                           :draggable="instrumentPanelDraggable"
                           @resizing="(x, y, w, h) => {instrumentPanelExtended = (h <= maxInstrumentPanelHeight - 5)}">
    <div class="instrument-panel-header">инструменты</div>
    <div class="instrument-panel-container">
      <div class="instrument-panel-title">размер</div>
      <div class="instrument-panel-item">
        <vue-slider v-model="instrumentPanelSliderValue"
                    :tooltip-formatter="blockFormatter"
                    :min="1"
                    :max="50"
                    :interval="1"
                    @drag-start="() => instrumentPanelDraggable = false"
                    @drag-end="() => instrumentPanelDraggable = true">
          <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
            <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ value }}</div>
          </template>
        </vue-slider>
      </div>
      <div :class="['instrument-panel-title', {'none': instrumentPanelExtended}]" style="margin-top: 10px;">форма</div>
      <div :class="['instrument-panel-item', {'none': instrumentPanelExtended}]" style="display: flex; flex-direction: row; justify-content: left; padding-left: 7px;">
        <i v-for="f in forms" :key="f.key"
           :class="['bx', f.class, { 'form-selected': f.selected }]"
           @click="onFormChange(f.key)"
           style="padding-right: 10px;"/>
      </div>
      <div class="instrument-panel-item-right" @click="onSolidChange">
        <div class="instrument-panel-title instrument-panel-title-right">заливка</div>
        <div :class="['instrument-panel-solid', { 'instrument-panel-solid-enable': solid } ]"/>
      </div>
    </div>
  </vue-draggable-resizable>
</template>

<script>
import 'vue-slider-component/theme/antd.css';
import 'vue-draggable-resizable/dist/VueDraggableResizable.css';
import VueSlider from 'vue-slider-component';
import VueDraggableResizable from 'vue-draggable-resizable';

export default {
  name: 'InstrumentPanel',
  components: { VueSlider, VueDraggableResizable },
  data() {
    return {
      instrumentPanelSliderValue: 1,
      instrumentPanelX: window.innerWidth - 170 - 40,
      instrumentPanelY: window.innerHeight - 130 - 80,
      instrumentPanelDraggable: true,
      instrumentPanelExtended: false,
      minInstrumentPanelHeight: 65,
      maxInstrumentPanelHeight: 120,
      blockFormatter: (val) => {
        if (val % 10 >= 5 || val % 10 === 0 || val > 10 && val < 20) {
          return val + ' блоков';
        } else if (val % 10 === 1) {
          return val + ' блок';
        }
        return val + ' блока';
      },
      solid: false,
      form: 'circle',
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
    };
  },
  methods: {
    onFormChange(key) {
      for (let form of this.forms) {
        form['selected'] = form['key'] === key;
      }
    },
    onSolidChange() {
      this.solid = !this.solid;
      for (let form of this.forms) {
        form['class'] = this.solid ? form['solidClass'] : form['mainClass'];
      }
    },
  },
};
</script>

<style scoped>
.instrument-panel {
  border-radius: 10px;
  background: rgba(17, 16, 29, 0.85);
  color: azure;
  position: absolute;
}
.instrument-panel-header {
  position: absolute;
  line-height: 0.6em;
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
.instrument-panel-item .vue-slider,
.instrument-panel-item i,
.instrument-panel-item-right {
  cursor: pointer;
}
.instrument-panel-item i:hover {
   transform: scale(1.2);
    opacity: 1;
}
.custom-dot {
  width: fit-content;
  min-width: 110%;
  height: 110%;
  background-color: #F5F5F5;
  border: 1px solid #9cd5ff;
  color: rgba(17, 16, 29, 0.85);
  border-radius: 50%;
  transition: all .3s;
  font-size: 0.6em;
  text-align: center;
}
.custom-dot:hover {
  transform: scale(1.3);
  border-color: #36abff;
}
.custom-dot-focus {
  box-shadow: 0 0 0 5px rgba(54, 171, 255, 0.2);
  border-color: #36abff;
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
  background-image: url('../assets/waves.png');
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
