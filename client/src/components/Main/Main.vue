<template>
  <main>
    <background :animated="false" :filter-blur="40"/>
    <main-menu :menuTitle="user.nickname"
               :userBackground="user.color"
               :userInitials="userInitials"
               :userRole="user.role"
               @changeTab="changeTab" @logout="logout"/>
    <maps v-if="tab === 'maps' && user.role !== 1"/>
    <tasks v-if="tab === 'tasks' && user.role !== 1"/>
    <championships v-if="tab === 'championships'"/>
    <message/>
  </main>
</template>

<script>
import Background from './Background';
import MainMenu from './MainMenu';
import Maps from '../Maps';
import Tasks from '../Tasks';
import Championships from '../Championships';
import Message from './Message';


export default {
  name: 'Main',
  components: { 'background': Background,
    'main-menu': MainMenu,
    message: Message,
    maps: Maps,
    tasks: Tasks,
    championships: Championships },
  data() {
    return {
      tab: 'championships',
      user: {},
      userInitials: '',
    };
  },
  methods: {
    changeTab(data) {
      this.tab = data['tab'];
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
    this.tab = this.$route.path.slice(1);
    if (this.tab === 'main') {
      this.tab = 'championships';
    }
    window.onbeforeunload = null;
    this.$emit('changeTab', { tab: this.tab });
  },
};
</script>

<style scoped>
main {
  width: 100%;
  height: 100%;
}
</style>
