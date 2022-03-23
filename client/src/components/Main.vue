<template>
  <main>
    <background :animated="false"/>
    <main-menu
      @changeTab="changeTab"/>
    <maps v-if="tab === 'maps'"></maps>
  </main>
</template>

<script>
import Background from './Background';
import MainMenu from './MainMenu';
import Maps from './Maps';

export default {
  name: 'Main',
  components: { 'background': Background, 'main-menu': MainMenu, 'maps': Maps },
  data() {
    return {
      tab: 'maps',
    };
  },
  methods: {
    changeTab(data) {
      this.tab = data['openedTab'];
      this.$router.replace({ path: this.tab }).catch(() => {});
    },
  },
};
</script>

<style scoped>
main {
  width: 100%;
  height: 100%;
}
</style>
