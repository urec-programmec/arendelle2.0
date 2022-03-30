import Vue from 'vue';
import Router from 'vue-router';
import Main from '@/components/Main';
import Login from '@/components/Login';
import Map from '@/components/MapCreator/Map';

Vue.use(Router);

export default new Router({
  routes: [
    {
      path: '/main',
      name: 'main',
      component: Main,
      alias: ['/profile', '/championships', '/maps', '/tasks', '/teams', '/users', '/notifications'],
      props: true,
    },
    {
      path: '/map-creator',
      name: 'map-creator',
      component: Map,
      props: true,
    },
    {
      path: '/login',
      name: 'login',
      component: Login,
    },
  ],
  mode: 'history',
});
