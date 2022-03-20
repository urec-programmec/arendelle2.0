<template>
  <main>
    <background :animated="true"/>
    <main-menu/>
  </main>
</template>

<script>
import Background from './Background';
import MainMenu from './MainMenu';

export default {
  name: 'Maps',
  components: { 'background': Background, 'main-menu': MainMenu },
};
</script>

<style scoped>
main {
  width: 100%;
  height: 100%;
}
</style>
