import Vue from 'vue';
import Router from 'vue-router';
import Main from '@/components/Main/Main';
import Login from '@/components/Login/Login';
import Map from '@/components/MapCreator/Map';
import Task from '@/components/TaskCreator/Task';

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
      path: '/task-creator',
      name: 'task-creator',
      component: Task,
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
