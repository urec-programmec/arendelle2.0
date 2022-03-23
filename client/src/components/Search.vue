<template>
  <div class="input-container"
       :style="{ '--background-color': backgroundFirstColor, '--text-color': textFirstColor, '--placeholder-color': placeholderFirstColor }"
       @click="focus=true">
    <div class="input-group" id="input-group">
      <div class="input-group-prepend" style="margin: 0">
          <span class="input-group-text"
                id="basic-addon"
                @click="search"
                :style="focus ? { 'border-bottom-left-radius' : settingsOpened ? '0 !important' : '0.25rem', '--background-color': backgroundSecondColor, '--text-color': textSecondColor } : { 'border-bottom-left-radius' : settingsOpened ? '0 !important' : '0.25rem' }">
            <i class="bx bx-search"/>
          </span>
      </div>
      <input v-model="searchValue" type="text"
             class="form-control"
             :placeholder="placeholder"
             :style="focus ? { '--background-color': backgroundSecondColor,
                                 '--text-color': textSecondColor,
                                 '--placeholder-color': placeholderSecondColor } : {}"
             aria-describedby="basic-addon">
      <div class="input-group-append" style="margin: 0">
          <span class="input-group-text"
                id="basic-addon-end"
                @click="settingsOpened = !settingsOpened"
                :style="focus ? { 'border-top-right-radius': '0.25rem !important', '--background-color': backgroundSecondColor, '--text-color': textSecondColor } : { 'border-top-right-radius': '0.25rem !important' }">
            <i class="bx bx-slider"/>
          </span>
      </div>
      <div class="settings" v-if="settingsOpened"
           :style="focus ? { '--background-color': backgroundSecondColor, '--text-color': textSecondColor } : {  }">
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Search',
  data() {
    return {
      searchValue: '',
      focus: false,
      settingsOpened: false,
    };
  },
  methods: {
    search() {
      this.$emit('search', { 'searchValue': this.searchValue });
    },
    mainClick(data) {
      if (data['event'].srcElement.offsetParent.id !== 'input-group') {
        this.focus = false;
        this.settingsOpened = false;
      }
    },
  },
  props: {
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

  },
  mounted() {
    this.$parent.$on('mainClick', this.mainClick);
  },
};
</script>

<style scoped>

.input-container {
  position: absolute;
  border: none;
  box-shadow: inset 0 -1px 0 rgb(255 255 255 / 12%);
  height: 50px;
  width: 100%;
  left: 80px;
  top: 20px;
}
.input-container .input-group {
  width: 50%;
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
.settings {
  position: absolute;
  border-radius: 0 0 0.25rem 0.25rem;
  top: 40px;
  width: 100%;
  height: 100px;
  background: #F5F5F5;
  z-index: 1;
  box-shadow: inset 0 1px 0 rgb(0 0 0 / 12%);
}
</style>
