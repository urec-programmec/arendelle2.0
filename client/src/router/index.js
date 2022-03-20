import Vue from 'vue';
import Router from 'vue-router';
import Maps from '@/components/Maps';
import Map from '@/components/MapCreator/Map';

Vue.use(Router);

export default new Router({
  routes: [
    {
      path: '/maps',
      name: 'Maps',
      component: Maps,
    },
    {
      path: '/map-creator',
      name: 'Map',
      component: Map,
    },
  ],
  mode: 'history',
});
