import Vue from 'vue'
import Router from 'vue-router'
import Game from '@/components/Game'

Vue.use(Router)

let routes = [
  {
    path: '/game',
    name: 'Game',
    component: Game
  }
]

export default new Router({
  routes: routes,
  mode: 'history'
})
