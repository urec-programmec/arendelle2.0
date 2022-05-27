<template>
  <div class="input-container"
       :style="{ '--background-color': backgroundFirstColor, '--text-color': textFirstColor, '--placeholder-color': placeholderFirstColor }"
       @click="focus=true">
    <div class="input-group" id="input-group">
      <div class="input-group-prepend" style="margin: 0">
          <span class="input-group-text"
                id="basic-addon"
                @click="leftClick"
                :style="focus ? { 'border-bottom-left-radius' : '0.25rem', '--background-color': backgroundSecondColor, '--text-color': textSecondColor } : { 'border-bottom-left-radius' : '0.25rem' }">
            <i :class="['bx', iconLeftClass]" style="font-size: 1.3em"/>
          </span>
      </div>
      <input v-model="searchValue" type="text"
             class="form-control"
             :placeholder="placeholder"
             :style="focus ? { '--background-color': backgroundSecondColor,
                                 '--text-color': textSecondColor,
                                 '--placeholder-color': placeholderSecondColor } : {}"
             @input="this.do"
             maxlength="100"
             aria-describedby="basic-addon">
      <div class="input-group-append" style="margin: 0">
          <span class="input-group-text"
                id="basic-addon-end"
                @click="rightClick"
                :style="focus ? { 'border-top-right-radius': tripleActions ? '' : '0.25rem !important', '--background-color': backgroundSecondColor, '--text-color': textSecondColor } : { 'border-top-right-radius': tripleActions ? '' : '0.25rem !important' }">
            <i :class="['bx', iconRightClass]" style="font-size: 1.3em"/>
          </span>
      </div>
      <div class="input-group-append" style="margin: 0" v-if="tripleActions">
          <span class="input-group-text"
                id="basic-addon-end-2"
                @click="tripleClick"
                :style="focus ? { 'border-top-right-radius': '0.25rem !important', '--background-color': backgroundSecondColor, '--text-color': textTripleColor } : { 'border-top-right-radius': '0.25rem !important' }">
            <i :class="['bx', iconTripleClass]" style="font-size: 1.3em"/>
          </span>
      </div>
    </div>
  </div>
</template>

<script>
import ToggleSwitch from './ToggleSwitch';

export default {
  name: 'CustomInput',
  components: { 'toggle-switch': ToggleSwitch },
  data() {
    return {
      searchValue: '',
      settingsValues: {},
      focus: false,
    };
  },
  methods: {
    leftClick() {
      if (this.clearOnLeftClick) {
        this.clear();
      }
      this.$emit('leftClick', { 'value': this.searchValue });
    },
    rightClick() {
      this.$emit('rightClick', { 'value': this.searchValue });
    },
    tripleClick() {
      this.$emit('tripleClick', { 'value': this.searchValue });
    },
    clear() {
      this.searchValue = '';
      this.do();
    },
    do() {
      this.$emit('do', { 'value': this.searchValue });
    },
    mainClick(data) {
      let parent = data.event.srcElement.offsetParent;
      while (parent) {
        if (parent.id === 'input-group') {
          return;
        }
        parent = parent.offsetParent;
      }
      this.focus = false;
    },
  },
  mounted() {
    this.searchValue = this.defaultValue;
    this.$parent.$on('mainClick', this.mainClick);
  },
  props: {
    iconLeftClass: {
      type: String,
      default: 'bx-x',
    },
    clearOnLeftClick: {
      type: Boolean,
      default: true,
    },
    iconRightClass: {
      type: String,
      default: 'bx-right-arrow-alt',
    },
    iconTripleClass: {
      type: String,
      default: 'bx-x-circle',
    },
    backgroundFirstColor: {
      type: String,
      default: 'rgba(241,243,244,0.24)',
    },
    backgroundSecondColor: {
      type: String,
      default: '#F5F5F5',
    },
    textFirstColor: {
      type: String,
      default: '#F5F5F5',
    },
    textSecondColor: {
      type: String,
      default: 'rgba(0,0,0,1)',
    },
    textTripleColor: {
      type: String,
      default: 'rgba(255, 23, 4, 0.99)',
    },
    placeholderFirstColor: {
      type: String,
      default: 'rgba(245,245,245,0.6)',
    },
    placeholderSecondColor: {
      type: String,
      default: 'rgba(0,0,0,0.6)',
    },
    placeholder: {
      type: String,
      default: '',
    },
    defaultValue: {
      type: String,
      default: '',
    },
    tripleActions: {
      type: Boolean,
      default: false,
    },
    settings: {
      type: Object,
      default: () => {
        return {
          searchBy: 'name',
          showing: 'all',
        };
      },
    },
  },
};
</script>

<style scoped>

.input-container {
  position: absolute;
  box-shadow: inset 0 -1px 0 rgb(255 255 255 / 12%);
  height: 50px;
  width: 320px;
  margin: 10px;
  border: none;
}
.input-container .input-group {
  /*width: 50%;*/
}
.input-container span,
.input-container input {
  background-color: var(--background-color);
  color: var(--text-color);
  box-shadow: none;
  height: 40px;
  border: none;
  transition: all 0.2s ease;
  font-size: 1.2em;
}
.input-container input::placeholder {
  font-size: 0.8em;
  color: var(--placeholder-color);
}
.input-container span i {
  transition: all 0.2s ease;
}
.input-container span:hover i {
  cursor: pointer;
  transform: scale(1.25);
}
</style>
