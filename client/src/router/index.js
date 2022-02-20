import Vue from 'vue';
import Router from 'vue-router';
import Books from '@/components/Books';
import Map from '@/components/Map';

Vue.use(Router);

export default new Router({
  routes: [
    {
      path: '/books',
      name: 'Books',
      component: Books,
    },
    {
      path: '/',
      name: 'Map',
      component: Map,
    },
  ],
  mode: 'history',
});
