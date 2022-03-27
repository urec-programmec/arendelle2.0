<template>
  <div class="toggle-switch" :style="{ 'grid-template-columns': 'repeat(' + items.length + ', 1fr)' }">
    <div :class="[ 'toggle-switch-item',
          { 'toggle-switch-item-first' : index === 0 },
          { 'toggle-switch-item-last' : index === items.length - 1 },
          { 'toggle-switch-item-selected' : selected === item.type }, ]"
          v-for="(item, index) in items"
          :key="index"
          @click="select(item.type)">{{ item.name }}</div>
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
    select(type) {
      this.selected = type;
      this.$emit('changeSelection', { 'selection': this.selected });
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
  background: #F5F5F5;
  font-size: 0.9em;
  color: rgb(0, 122, 255);
  border-left: 1px solid;
  border-top: 1px solid;
  border-bottom: 1px solid;
  border-color: rgb(0, 122, 255);
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
  border-color: rgb(0, 122, 255);
}
.toggle-switch-item-selected {
  color: #F5F5F5;
  background: rgb(0, 122, 255);
}
</style>
