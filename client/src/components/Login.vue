<template>
  <main>
    <background :animated="true" :filter-blur="25" :count-points="100"/>
    <sign-up @changeSign="changeSign" @signUp="signUp" v-if="sign === 'up'"/>
    <sign-in @changeSign="changeSign" @signIn="signUp" v-if="sign === 'in'"/>
  </main>
</template>

<script>
import Background from './Background';
import SignUp from './SignUp';
import SignIn from './SignIn';


export default {
  name: 'Login',
  components: { 'background': Background, 'sign-up': SignUp, 'sign-in': SignIn },
  data() {
    return {
      documentTitle: 'авторизация',
      sign: 'up',
      session: {
        user: {},
      },
    };
  },
  methods: {
    changeSign() {
      if (this.sign === 'up') {
        this.sign = 'in';
      } else if (this.sign === 'in') {
        this.sign = 'up';
      }
    },
    signUp(user) {
      this.user = user;
      console.log(this.user);
    },
  },
  created() {
    document.title = this.documentTitle;
  },
};
</script>

<style scoped>
@import url('https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css');

main {
  width: 100%;
  height: 100%;
}
</style>
