<template>
  <main id="task-main">
    <div class="background"></div>
    <left-menu @openCloseMenu="openCloseMenu"
               @exit="exit"/>
    <message/>
  </main>
</template>

<script>
import axios from 'axios';
import Menu from './Menu';
import Message from '../Main/Message';

export default {
  name: 'Task',
  components: {
    'left-menu': Menu,
    'message': Message,
  },
  data() {
    return {
      pathGetResults: 'http://localhost:5050/getResults',
      documentTitle: 'Статистика чемпионата',

      results: [],

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
      axios.get(this.pathGetResults)
        .then((res) => {
          this.results = res.data.results;
        })
        .catch((error) => {
          console.error(error);
          this.showMessage('ошибка при загрузке статистики',
            'подробности в консоли браузера',
            'error',
            5000);
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
    } else if (JSON.parse(localStorage.getItem('user')).role === 1) {
      this.$router.push('/main');
    } else if (this.championship === -1) {
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
#task-main {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
}
.task-settings {
  position: absolute;
  background: rgba(33, 37, 41, 0.6);
  border-radius: 0.5rem;
  border: 1px solid #F5F5F5;
  color: #F5F5F5;
  right: 5%;
  top: 50%;
  transform: translate(0, -50%);
  width: 30%;
  height: fit-content;
  min-height: 100px;
  max-height: 80%;
  padding: 20px;
  overflow: scroll;
}
.task-settings a,
.task-settings p {
  padding: 0 5px;
  margin: 0;
  border-radius: 0.5rem;
  background: rgba(241,243,244,0.14);
  width: fit-content;
}
.task-settings input {
  padding: 7.5px 10px;
  margin-top: 10px;
  border-radius: 0.25rem;
  border: none;
  width: 100%;
  display: block;
}
.task-settings input::placeholder {
  color: hsla(0,0%,74.9%,.87);
  font-size: 14px;
}
.task-settings input:focus::placeholder {
  color: hsla(0,0%,45.1%,.87) !important;
}
.task-settings-hint {
  background: rgba(241,243,244,0.05) !important;
  color: rgba(245, 245, 245, 0.8) !important;
  font-size: 0.8em;
}
.task-settings-hint.tag {
  transition: all 0.2s ease;
}
.task-settings-hint.tag:hover {
  cursor: pointer;
  transform: scale(1.2);
}
.task-settings-hint a {
  font-size: inherit;
  background: rgba(241,243,244,0.14) !important;
}
/* div::-webkit-scrollbar {*/
/*  display: none;*/
/*}*/
.task-container {
  display: -webkit-box;
  min-width: 100%;
  height: 100%;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  padding: 0 40% 0 78px;
  overflow: scroll;
}
.task-container::-webkit-scrollbar {
  display: block !important;
}
.footer {
  color: #F5F5F5;
  min-height: 30px;
  border-top: 1px solid black;
  padding-left: 5%;
  padding-right: 10px;
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: right;
}
.footer i {
  margin: 0 10px;
}
.footer p {
  width: 70px;
  margin: 0 0 0 5px;
  font-size: 0.7em;
  text-align: center;
  line-height: 1em;
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
.save-map {
  font-size: 24px;
  transition: all 0.2s ease;
  background: linear-gradient(to right, #00416a, #799f0c, #ffe000);
  background-clip: text;
  -webkit-background-clip: text;
}
.save-map:hover {
  color:rgba(1,1,1,0);
  cursor: pointer;
}
.answer-correct {
  /*box-shadow: 0 0 50px rgb(0, 255, 0) !important;*/
  /*border: 3px solid rgb(0, 255, 0);*/
  box-shadow: 0 0 6px 6px rgba(54, 255, 54, 0.5) !important;
}
.answer-incorrect {
  /*box-shadow: 0 0 50px rgb(255, 0, 0) !important;*/
  /*border: 3px solid rgb(255, 0, 0);*/
  box-shadow: 0 0 6px 6px rgba(255, 54, 54, 0.5) !important;
}
</style>
