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
      name: 'Main',
      component: Main,
      alias: ['/championships', '/maps', '/tasks', '/teams', '/users'],
    },
    {
      path: '/map-creator',
      name: 'Map',
      component: Map,
    },
    {
      path: '/maps',
      name: 'Maps',
      component: Maps,
    },
  ],
  mode: 'history',
});
