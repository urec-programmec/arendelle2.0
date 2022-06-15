<template>
  <main id="statistic-main">
    <div class="background"></div>
    <left-menu @openCloseMenu="openCloseMenu"
               @exit="exit"/>

    <div class="statistic-container">
      <v-table :data="rows" class="table table-bordered">
        <thead slot="head">
          <tr>
            <th :style="{ width: '50px', textAlign: 'center' }">#</th>
            <th>Команда</th>
            <th>Образовательное учреждение</th>
            <th :style="{ textAlign: 'center' }">Решенных задач</th>
            <th :style="{ textAlign: 'center' }">Время решения</th>
            <th v-for="(task, index) in tasks" :key="index"
                :style="{ minWidth: '50px', textAlign: 'center' }"
                class="show-task-cell"
                @click="showTask(task)">
              {{ task.letter }}
              <div :class="['show-task', 'bx', 'bx-show']"/>
            </th>
          </tr>
        </thead>
        <tbody slot="body" slot-scope="{displayData}">
          <tr v-for="(row, index) in displayData" :key="index">
            <td :style="{ textAlign: 'center' }">{{ index + 1 }}</td>
            <td>{{ row.teamName }}</td>
            <td>{{ row.institution }}</td>
            <td :style="{ textAlign: 'center' }">0</td>
            <td :style="{ textAlign: 'center' }">00:00:00</td>
            <th v-for="(task, index) in row.tasks" :key="index"
                :style="{ textAlign: 'center', color: task.ok ? '#0aaa00' : '#ff1d00', fontSize: '1.2em' }">
              {{ task.status }}
            </th>
          </tr>
        </tbody>
      </v-table>

    </div>

    <message/>
    <refresh @refresh="getResults"/>
  </main>
</template>

<script>
import axios from 'axios';
import Vue from 'vue';
import ModalWizard from 'vue-modal-wizard';
import SmartTable from 'vuejs-smart-table';
import Menu from './Menu';
import Refresh from './Refresh';
import Message from '../Main/Message';
import modalTask from '../Main/TaskDialog';

Vue.use(SmartTable);

export default {
  name: 'Statistic',
  components: {
    'left-menu': Menu,
    'message': Message,
    'refresh': Refresh,
  },
  data() {
    return {
      pathGetResults: 'http://85.193.85.25:5050/getResults',
      documentTitle: 'Статистика чемпионата',

      rows: [],
      tasks: [],

      currentTaskName: '',
      isMenuOpen: false,
    };
  },
  methods: {
    openCloseMenu(data) {
      this.isMenuOpen = data['isOpen'];
    },
    showMessage(title, message, messageType, delay, functionConfirm) {
      this.$emit('showMessage', { title, message, messageType, delay, functionConfirm });
    },
    getResults() {
      axios.post(this.pathGetResults, { championship: this.championship })
        .then((res) => {
          this.rows = res.data.rows;
          this.tasks = res.data.tasks;
          this.$emit('refreshEnd');
        })
        .catch((error) => {
          console.error(error);
          this.showMessage('ошибка при загрузке статистики',
            'подробности в консоли браузера',
            'error',
            5000);
        });
    },
    showTask(task) {
      ModalWizard.open(modalTask, {
        props: {
          taskTitle: task.name,
          taskName: task.content,
          taskСomplexity: task.complexity,
          showHintOnSubmit: false,
          showHintInitial: false,
          isShowing: true,
        },
      });
    },
    exit() {
      this.showMessage('выйти',
        'закрыть статистику и вернуться к чемпионатам?',
        'confirm-error',
        15000,
        () => { this.$router.push('/main'); });
    },
  },
  computed: {
    footerStyle() {
      return {
        'margin-left': this.isMenuOpen ? '238px' : '78px',
        'transition': 'all 0.5s ease',
      };
    },
  },
  created() {
    document.title = this.documentTitle;
  },
  mounted() {
    if (!localStorage.getItem('user')) {
      this.$router.push('/login');
    } else if (JSON.parse(localStorage.getItem('user')).role === 1 || this.championship === -1) {
      this.$router.push('/main');
    } else {
      this.getResults();
    }
  },
  props: {
    championship: {
      type: Number,
      default: -1,
    },
  },
};
</script>
<style scoped>
* {
  user-select:none
}
.show-task-cell:hover {
  background: rgba(33, 37, 41, 0.3);
  color: rgba(33, 37, 41, 0);
  cursor: pointer;
}
.show-task-cell:hover .show-task:before {
  color: black !important;
  z-index: 100;
}
.show-task:before {
  font-size: 1.9em;
  display: flex;
  align-items: center;
  justify-content: center;
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: -100;
  color: #F5F5F5;
}
.table th {
  display: table-cell;
  position: relative;
  font-size: 0.9em;
}
.table th, .table td {
  padding: 5px !important;
  vertical-align: inherit;
}
#statistic-main {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
}
.statistic-container {
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);

  min-width: 300px;
  width: fit-content;
  max-width: 90%;

  min-height: 100px;
  height: fit-content;
  max-height: 90%;

  background: #F5F5F5;
  border-radius: 0.5rem;
  border: 1px solid rgba(33, 37, 41, 1);
  padding: 25px;
  overflow: scroll;
}
.statistic-container a,
.statistic-container p {
  padding: 0 5px;
  margin: 0;
  border-radius: 0.5rem;
  background: rgba(241,243,244,0.14);
  width: fit-content;
}
.statistic-container input {
  padding: 7.5px 10px;
  margin-top: 10px;
  border-radius: 0.25rem;
  border: none;
  width: 100%;
  display: block;
}
.statistic-container input::placeholder {
  color: hsla(0,0%,74.9%,.87);
  font-size: 14px;
}
.statistic-container input:focus::placeholder {
  color: hsla(0,0%,45.1%,.87) !important;
}
.background {
  position: fixed;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: hidden;
  z-index: -1;
}
.background:before {
  content: '';
  background-image: url('../../assets/images/special/background.jpg');
  position: absolute;
  margin: 0;
  padding: 0;
  width: 130%;
  height: 130%;
  left: -15%;
  top: -15%;
  filter: blur(10px);
}
</style>
