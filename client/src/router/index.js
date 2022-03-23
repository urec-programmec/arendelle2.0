import Vue from 'vue';
import Router from 'vue-router';
import Main from '@/components/Main';
import Maps from '@/components/Maps';
import Map from '@/components/MapCreator/Map';

Vue.use(Router);

export default new Router({
  routes: [
    {
      path: '/main',
      name: 'main',
      component: Main,
      alias: ['/championships', '/maps', '/tasks', '/teams', '/users'],
    },
    {
      path: '/map-creator',
      name: 'map-creator',
      component: Map,
      props: true,
    },
    {
      path: '/maps',
      name: 'maps',
      component: Maps,
    },
  ],
  mode: 'history',
});
