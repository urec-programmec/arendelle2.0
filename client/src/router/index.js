import Vue from 'vue';
import Router from 'vue-router';
import Veil from '@/components/Veil';

Vue.use(Router);

export default new Router({
  routes: [
    {
      path: '/veil',
      name: 'veil',
      component: Veil,
      props: true,
    },
  ],
  mode: 'history',
});
