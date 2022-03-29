<template>
  <main>
    <background :animated="false" :filter-blur="40"/>
    <main-menu :menuTitle="user.nickname" :userBackground="user.color" :userInitials="userInitials" :userRole="user.role"
      @changeTab="changeTab" @logout="logout"/>
    <maps v-if="tab === 'maps' && user.role !== 1"></maps>
    <message/>
  </main>
</template>

<script>
import Background from './Background';
import MainMenu from './MainMenu';
import Maps from './Maps';
import Message from './MapCreator/Message';


export default {
  name: 'Main',
  components: { 'background': Background, 'main-menu': MainMenu, 'maps': Maps, message: Message },
  data() {
    return {
      tab: '',
      user: {},
      userInitials: '',
    };
  },
  methods: {
    changeTab(data) {
      this.tab = data['openedTab'];
      this.$router.replace({ path: this.tab }).catch(() => {});
    },
    logout() {
      this.showMessage('выйти',
        'выйти из системы?',
        'confirm-error',
        15000,
        () => {
          localStorage.removeItem('user');
          this.$router.push('/login');
        });
    },
    showMessage(title, message, messageType, delay, functionConfirm) {
      this.$emit('showMessage', { title, message, messageType, delay, functionConfirm });
    },
  },
  mounted() {
    let user = localStorage.getItem('user');
    if (!user) {
      this.$router.push('/login');
      return;
    }
    this.user = JSON.parse(user);
    this.userInitials = '\''.concat(this.user.name[0], this.user.surname[0], '\'').toUpperCase();
    this.tab = this.user.role === 1 ? 'championships' : 'maps';
  },
};
</script>

<style scoped>
main {
  width: 100%;
  height: 100%;
}
</style>
