<template>
  <div class="main"
       @click="mainClick">
    <div class="header">
      <toggle-switch :defaultItems="stageItems"
                     :selectedItem="stage"
                     :background-first-color="'rgba(241,243,244,0.15)'"
                     :background-second-color="'rgba(241,243,244,0.30)'"
                     :text-first-color="'#F5F5F5'"
                     :text-second-color="'#F5F5F5'"
                     :border-color="'rgba(0,0,0,0.5)'"
                     style="position: relative;"
                     @changeSelection="changeStage"/>
    </div>
    <div class="content">
      <timeline class="timeline-container" :data="events" :config="config"/>
      <div v-if="events.length === 0" class="timeline-container-empty">
        <p>{{ getEmptyMessage }}</p>
      </div>

      <custom-input v-if="championship === null"
                    :placeholder="'Новый чемпионат'"
                    style="box-shadow: unset; margin: 20px"
                    @rightClick="newCh"/>
      <championship v-if="championship !== null"
                    @closeCh="closeCh"
                    @deleteCh="deleteCh"
                    @saveCh="saveCh"
                    :default-championship="championship"/>
    </div>
    <message/>
  </div>
</template>

<script>
import ModalWizard from 'vue-modal-wizard'
import axios from 'axios'
import Vue from 'vue'
import Message from './Main/Message.vue'

import TimeLine from './ChampionshipCreator/TimeLine.vue'
import Championship from './ChampionshipCreator/Championship.vue'
import CustomInput from './Main/CustomInput.vue'
import ToggleSwitch from './Main/ToggleSwitch.vue'

Vue.use(ModalWizard)

export default {
  name: 'Championships',
  components: {
    message: Message,
    timeline: TimeLine,
    championship: Championship,
    'custom-input': CustomInput,
    'toggle-switch': ToggleSwitch },
  data () {
    return {
      pathGetChampionships: 'http://localhost:5050/allChampionships',
      pathDeleteCh: 'http://localhost:5050/deleteChampionship',

      user: {},
      stageItems: [
        {
          type: '0',
          name: 'прошедшие',
          disabled: false
        },
        {
          type: '1',
          name: 'отборочные',
          disabled: false
        },
        {
          type: '2',
          name: 'основные',
          disabled: false
        },
        {
          type: '3',
          name: 'финальные',
          disabled: false
        },
        {
          type: '4',
          name: 'личные',
          disabled: false
        }
      ],
      stagesCh: {
        '': 0,
        'отборочный тур': 1,
        'основной тур': 2,
        'финальный тур': 3
      },
      stage: '1',
      events: [],
      config: {
        viewHeight: 260,
        // margin: {
        //   right: 0,
        //   left: 0,
        //   top: 0,
        //   bottom: 0,
        // },
        onEventClick: (ch) => {
          // if (ch.end < new Date()) {
          //   return;
          // }
          let title = ch.status !== 1 ? 'просмотр чемпионата' : 'управление чемпионатом'
          let message = ch.status !== 1 ? 'перейти в режим просмотра чемпионата?' : 'перейти в режим управления чемпионатом?'
          let messageType = ch.status !== 1 ? 'confirm-info' : 'confirm-special'
          this.showMessage(title,
            message,
            messageType,
            15000,
            () => this.setCh(ch))
        }
      },

      championshipName: '',
      championshipIsNew: false,
      championship: null,
      championships: [],
      emptyMessage: ''
    }
  },
  methods: {
    changeStage (data) {
      this.stage = data['selection']
      this.events = []
      setTimeout(this.loadCh, 0)
    },
    setCh (ch) {
      // console.log(ch);
      this.closeCh()
      setTimeout(() => {
        let time = new Date()
        time.setHours(0)
        time.setMinutes(0)
        time.setSeconds(0)
        time.setMilliseconds(ch.time)
        this.championship = {
          id: ch.id,
          name: ch.name,
          level: ch.levelCh + '',
          stage: {
            value: this.stagesCh[ch.stage],
            text: ch.stage
          },
          status: ch.status,
          date: ch.start,
          time,
          institutions: ch.institutions,
          teams: ch.teams,
          taskCount: ch.taskCount,
          taskCellCount: ch.taskCellCount,
          map: ch.map,
          tasks: ch.tasks,
          isNew: this.championshipIsNew
        }
      }, 0)
      this.$emit('closeMessage')
    },
    resetCh () {
      this.championship = {
        id: -1,
        name: this.championshipName,
        level: '1',
        stage: {
          value: 0,
          text: ''
        },
        status: 1,
        date: null,
        time: 0,
        institutions: [],
        teams: [],
        taskCount: 5,
        taskCellCount: 50,
        map: {},
        tasks: [],
        isNew: this.championshipIsNew
      }
      this.$emit('closeMessage')
    },
    newCh (data) {
      this.championshipName = data.value
      this.championshipIsNew = true
      this.showMessage('создание чемпионата',
        'начать создание чемпионата?',
        'confirm',
        15000,
        this.resetCh)
    },
    closeCh () {
      this.championshipName = ''
      this.championshipIsNew = false
      this.championship = null
    },
    deleteCh (data) {
      axios.post(this.pathDeleteCh, { id: data['id'] })
        .then(() => {
          this.closeCh()
          this.preloadCh()
        })
        .catch((error) => {
          console.error(error)
          this.showMessage('ошибка при удалении чемпионата',
            'подробности в консоли браузера',
            'error',
            5000)
        })
    },
    saveCh () {
      this.championshipName = ''
      this.championshipIsNew = false
      this.championship = null
      this.preloadCh()
    },
    mainClick (event) {
      this.$emit('mainClick', { event })
    },

    preloadCh () {
      this.events = []
      axios.get(this.pathGetChampionships)
        .then((res) => {
          this.championships = res.data.championships
          this.loadCh()
        })
        .catch((error) => {
          console.error(error)
          this.showMessage('ошибка при загрузке чемпионатов',
            'подробности в консоли браузера',
            'error',
            5000)
        })
    },
    loadCh () {
      for (let ch of this.championships) {
        let isGlobal = this.stagesCh[ch.stage] === parseInt(this.stage, 10)
        let isLocal = this.stagesCh[ch.stage] === 0 && this.stage === '4' &&
          ch.authorId === JSON.parse(localStorage.getItem('user')).id
        let isPassed = this.stage === '0'

        if (isGlobal || isLocal || isPassed) {
          let date = new Date(ch.date)
          let hours = Math.floor(ch.time / 3600000)
          let minutes = (ch.time - hours * 3600000) / 60000
          let end = new Date(date.getFullYear(), date.getMonth(), date.getDate(), date.getHours() + hours, date.getMinutes() + minutes, Math.random() * 10, Math.random() * 1000)

          if (isGlobal && end > new Date() || isLocal && end > new Date() || isPassed && end <= new Date()) {
            let start = new Date(date.getFullYear(), date.getMonth(), date.getDate(), date.getHours(), date.getMinutes(), Math.random() * 10, Math.random() * 1000)
            this.events.push({
              id: ch.id,
              name: ch.name,
              text: ch.name,
              color: ch.color,
              start,
              end,
              levelCh: ch.level,
              stage: ch.stage,
              status: ch.status,
              time: ch.time,
              taskCount: ch.taskCount,
              taskCellCount: ch.taskCellCount,
              teams: ch.teams,
              institutions: ch.institutions,
              map: ch.map,
              tasks: ch.tasks
            })
          }
        }
        // this.config.viewHeight = this.events.length * 22 + 60;
      }
      this.$emit('initTimeline')
    },
    showMessage (title, message, messageType, delay, functionConfirm) {
      this.$emit('showMessage', { title, message, messageType, delay, functionConfirm })
    }
  },
  mounted () {
    if (localStorage.getItem('user')) {
      this.user = JSON.parse(localStorage.getItem('user'))
      this.preloadCh()
    }
  },
  computed: {
    getEmptyMessage () {
      switch (this.stage) {
        case '0':
          return 'Нет данных о прошедших чемпионатах'
        case '1':
          return 'Нет данных о чемпионатах отборочного тура'
        case '2':
          return 'Нет данных о чемпионатах основного тура'
        case '3':
          return 'Нет данных о чемпионатах финального тура'
        case '4':
          return 'Нет данных о личных чемпионатах'
        default:
          return ''
      }
    }
  }
}
</script>

<style scoped>
.main {
  display: block;
  position:absolute;
  height:auto;
  bottom:0;
  top:0;
  left:0;
  right:0;
  transition: all 0.5s ease;
  overflow: hidden;
}
.main .content {
  position:inherit;
  height:auto;
  bottom:0;
  top:0;
  left:0;
  right:0;
  margin: 50px 0 20px 80px;
  /*background-color: rgba(241,243,244,0.24);*/
  border-radius: 0.25rem;
  padding-right: 10px;
  overflow: scroll;
}
.main .content::-webkit-scrollbar{
  display: block;
  width: 10px;
  height: 0;
}
.main .content::-webkit-scrollbar-thumb {
  -webkit-border-radius: 10px;
  border-radius: 10px;
  padding: 2px;
  background: rgba(241,243,244,0.4);
  -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5);
}
.main .content::-webkit-scrollbar-thumb:hover {
  background: rgba(241,243,244,0.6);
  -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5);
}
.header {
  position: absolute;
  border: none;
  box-shadow: inset 0 -1px 0 rgb(255 255 255 / 12%);
  height: 50px;
  width: 100%;
  /*top: 20px;*/
  display: flex;
  align-items: center;
  justify-content: center;
}
.timeline-container {
  height: 260px;
  fill: #F5F5F5;
  color: #F5F5F5 !important;
}
.timeline-container-empty {
  position: absolute;
  height: 250px;
  left: 0;
  top: 10px;
  width: 100%;
  background: rgba(33, 37, 41, 0.6);
  border-radius: 0.25rem;
  border: 1px solid rgb(33, 37, 41);
  padding: 10px;
  transition: all 0.2s ease;
  color: #F5F5F5;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
</style>
