<template>
  <div class="toggle-switch" :style="{ 'grid-template-columns': 'repeat(' + items.length + ', 1fr)' }">
    <div :class="[ 'toggle-switch-item',
          { 'toggle-switch-item-first' : index === 0 },
          { 'toggle-switch-item-last' : index === items.length - 1 },
          { 'toggle-switch-item-selected' : selected === item.type }, ]"
          v-for="(item, index) in items"
          :key="index"
          :style="{ '--background-first-color' : backgroundFirstColor,
                     '--background-second-color' : backgroundSecondColor,
                     '--text-first-color' : textFirstColor,
                     '--text-second-color' : textSecondColor,
                     '--border-color' : borderColor }"
          @click="select(item)">{{ item.name }}</div>
  </div>
</template>

<script>
export default {
  name: 'ToggleSwitch',
  data() {
    return {
      items: [],
      selected: '',
    };
  },
  methods: {
    select(item) {
      if (!this.disabled && !item.disabled) {
        this.selected = item.type;
        this.$emit('changeSelection', { 'selection': this.selected });
      }
    },
  },
  props: {
    defaultItems: {
      type: Array,
      default: () => [],
    },
    selectedItem: {
      type: String,
      default: '',
    },
    backgroundFirstColor: {
      type: String,
      default: '#F5F5F5',
    },
    backgroundSecondColor: {
      type: String,
      default: 'rgba(0,0,0,0.5)',
    },
    textFirstColor: {
      type: String,
      default: 'rgba(0,0,0,0.8)',
    },
    textSecondColor: {
      type: String,
      default: '#F5F5F5',
    },
    borderColor: {
      type: String,
      default: 'rgba(0,0,0,0.5)',
    },
    disabled: {
      type: Boolean,
      default: false,
    },
  },
  mounted() {
    this.items = this.defaultItems;
    this.selected = this.selectedItem;
  },
};
</script>

<style scoped>
.toggle-switch {
  display: grid;
  width: max-content;
  height: max-content;
}
.toggle-switch-item {
  background: var(--background-first-color);
  font-size: 0.9em;
  color: var(--text-first-color);
  border-left: 1px solid;
  border-top: 1px solid;
  border-bottom: 1px solid;
  border-color: var(--border-color);
  padding: 2px 10px;
  display: flex;
  justify-content: center;
  align-items: center;
}
.toggle-switch-item:hover {
  cursor: pointer;
}
.toggle-switch-item-first {
  border-top-left-radius: 0.25rem;
  border-bottom-left-radius: 0.25rem;
}
.toggle-switch-item-last {
  border-top-right-radius: 0.25rem;
  border-bottom-right-radius: 0.25rem;
  border-right: 1px solid;
  border-color: var(--border-color);
}
.toggle-switch-item-selected {
  color: var(--text-second-color);
  background: var(--background-second-color);
}
</style>
