<template>
  <div class="input-container"
       :style="{ '--background-color': backgroundFirstColor, '--text-color': textFirstColor, '--placeholder-color': placeholderFirstColor }"
       @click="focus=true">
    <div class="input-group" id="input-group">
      <div class="input-group-prepend" style="margin: 0">
          <span class="input-group-text"
                id="basic-addon"
                @click="clear"
                :style="focus ? { 'border-bottom-left-radius' : settingsOpened ? '0 !important' : '0.25rem', '--background-color': backgroundSecondColor, '--text-color': textSecondColor } : { 'border-bottom-left-radius' : settingsOpened ? '0 !important' : '0.25rem' }">
            <i class="bx bx-x" style="font-size: 1.3em"/>
          </span>
      </div>
      <input v-model="searchValue" type="text"
             class="form-control"
             :placeholder="placeholder"
             :style="focus ? { '--background-color': backgroundSecondColor,
                                 '--text-color': textSecondColor,
                                 '--placeholder-color': placeholderSecondColor } : {}"
             @input="search"
             aria-describedby="basic-addon">
      <div class="input-group-append" style="margin: 0">
          <span class="input-group-text"
                id="basic-addon-end"
                @click="settingsOpened = !settingsOpened"
                :style="focus ? { 'border-top-right-radius': '0.25rem !important', '--background-color': backgroundSecondColor, '--text-color': textSecondColor } : { 'border-top-right-radius': '0.25rem !important' }">
            <i class="bx bx-slider"/>
          </span>
      </div>
      <div id="input-group-settings" class="settings" v-if="settingsOpened"
           :style="focus ? { '--background-color': backgroundSecondColor, '--text-color': textSecondColor } : {  }">
        <div class="settings-row">
          <p>поиск по</p>
          <toggle-switch :defaultItems="searchByItems" :selectedItem="settingsValues.searchBy"
                         @changeSelection="changeSearchBy"/>
        </div>
        <div class="settings-row">
          <p>отображать</p>
          <toggle-switch :defaultItems="showingItems" :selectedItem="settingsValues.showing"
                         @changeSelection="changeShowing"/>
        </div>
        <div class="settings-row" v-if="isTask">
          <p>сложность</p>
          <multi-select placeholder="сложность"
                        :options="complexityOptions"
                        :selected-options="complexity"
                        @select="changeComplexity"/>
        </div>
        <div class="settings-row" v-if="isTask">
          <p>теги</p>
          <multi-select placeholder="теги"
                        :options="tagsOptions"
                        :selected-options="tags"
                        @select="changeTags"/>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import { MultiSelect } from 'vue-search-select';
import ToggleSwitch from './ToggleSwitch';

export default {
  name: 'Search',
  components: { 'toggle-switch': ToggleSwitch, 'multi-select': MultiSelect },
  data() {
    return {
      pathGetTags: 'http://85.193.85.25:5050/allTags',

      searchValue: '',
      settingsValues: {},
      searchByItems: [
        {
          type: 'name',
          name: 'название',
          disabled: false,
        },
        {
          type: 'author',
          name: 'автор',
          disabled: false,
        },
      ],
      showingItems: [
        {
          type: 'all',
          name: 'все',
          disabled: false,
        },
        {
          type: 'own',
          name: 'только свои',
          disabled: false,
        },
      ],
      focus: false,
      settingsOpened: false,

      complexityOptions: [
        { value: 1, text: 'сложность 1' },
        { value: 2, text: 'сложность 2' },
        { value: 3, text: 'сложность 3' },
        { value: 4, text: 'сложность 4' },
        { value: 5, text: 'сложность 5' },
      ],
      complexity: [],

      tagsOptions: [],
      tags: [],
    };
  },
  methods: {
    changeComplexity(items) {
      this.complexity = items;
      this.search();
    },
    changeTags(items) {
      this.tags = items;
      this.search();
    },
    getTags() {
      axios.get(this.pathGetTags)
        .then((res) => {
          this.tagsOptions = res.data.tags;
        })
        .catch((error) => {
          console.error(error);
          this.showMessage('ошибка при загрузке тегов',
            'подробности в консоли браузера',
            'error',
            5000);
        });
    },
    clear() {
      this.searchValue = '';
      this.search();
    },
    mainClick(data) {
      let parent = data['event'].srcElement.offsetParent;
      while (parent) {
        if (parent.id === 'input-group') {
          return;
        }
        parent = parent.offsetParent;
      }
      this.focus = false;
      this.settingsOpened = false;
    },
    search() {
      this.$emit('search',
        { 'searchValue': this.searchValue,
          settings: this.settingsValues,
          complexity: this.complexity.map(comp => comp.value),
          tags: this.tags.map(tag => tag.text),
        });
    },
    changeSearchBy(data) {
      this.settingsValues.searchBy = data['selection'];
      this.search();
    },
    changeShowing(data) {
      this.settingsValues.showing = data['selection'];
      this.search();
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
    isTask: {
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
  mounted() {
    this.$parent.$on('mainClick', this.mainClick);
    this.settingsValues = this.settings;
    this.getTags();
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
  min-width: fit-content;
  height: fit-content;
  background: #F5F5F5;
  z-index: 4;
  box-shadow: inset 0 1px 0 rgb(0 0 0 / 12%);
  display: grid;
  grid-template-columns: 1fr 1fr;
}
.settings-row {
  padding: 10px;
}
.settings p {
  margin: 0;
  color: rgba(0,0,0,0.6);
}
</style>
