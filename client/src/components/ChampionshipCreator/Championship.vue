<template>
  <div class="champ">
    <div class="champ-header">
      <custom-input :placeholder="'Название чемпионата'"
                    :icon-right-class="'bx-check'"
                    :icon-left-class="'bx-undo'"
                    :clear-on-left-click="false"
                    :default-value="championship.name"
                    :triple-actions="!championship.isNew"
                    :disabled="championship.status !== 1"
                    @do="changeName"
                    @leftClick="closeCh"
                    @rightClick="saveCh"
                    @tripleClick="deleteCh"
                    style="margin: 0"/>
      <div class="champ-content" style="margin-top: 50px">
        <p>количество задач</p>
        <vue-slider v-model="championship.taskCount"
                    :disabled="championship.status !== 1"
                    :min="1"
                    :max="10"
                    :marks="true"
                    :tooltip-placement="'bottom'"
                    :style="{ margin: '0 10px' }"
                    @change="changeTaskCount">
          <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
            <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ value }}</div>
          </template>
        </vue-slider>
        <div class="hr" style="margin: 1.5rem 0 0.5rem"/>
        <p>количество ячеек для задач</p>
        <vue-slider v-model="championship.taskCellCount"
                    :disabled="championship.status !== 1"
                    :min="10"
                    :max="maxTaskCellCount"
                    :style="{ margin: '0 10px' }"
                    @change="changeTaskCellCount">
          <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
            <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ value }}</div>
          </template>
        </vue-slider>
        <div class="hr"/>
        <p>уровень чемпионата</p>
        <toggle-switch :defaultItems="levelChItems"
                       :selectedItem="championship.level"
                       :background-first-color="'rgba(241,243,244,0.15)'"
                       :background-second-color="'rgba(241,243,244,0.30)'"
                       :text-first-color="'#F5F5F5'"
                       :text-second-color="'#F5F5F5'"
                       :border-color="'rgba(0,0,0,0.5)'"
                       :disabled="championship.status !== 1"
                       style="position: relative; width: 100%"
                       @changeSelection="changeLevelCh"/>
        <div class="hr"/>
        <p v-if="championship.level === '1'">этап чемпионата</p>
        <model-select v-if="championship.level === '1'"
                      :options="stagesChItems"
                      :isDisabled="championship.status !== 1"
                      placeholder="Этап чемпионата"
                      v-model="championship.stage" />
        <div v-if="championship.level === '1' && championship.stage.text !== ''">
          <div class="hr"/>
          <p style="font-size: 0.9rem">{{ championship.stage.text }}</p>
          <p>дата начала чемпионата</p>
          <datetime-picker v-model="championship.date"
                           :confirm="true"
                           :show-second="false"
                           :minute-step="10"
                           :placeholder="'Дата'"
                           :type="'datetime'"
                           :style="{ width: '100%' }"
                           :disabled="championship.status !== 1"
                           @change="changeDate"/>
          <p>длительность чемпионата</p>
          <datetime-picker v-model="championship.time"
                           :confirm="true"
                           :show-second="false"
                           :minute-step="10"
                           :disabled-time="checkTime"
                           :default-value="new Date().setHours(2, 0, 0, 0)"
                           :placeholder="'Длительность, ч'"
                           :type="'time'"
                           :style="{ width: '100%' }"
                           :disabled="championship.status !== 1"
                           @change="changeTime"/>

        </div>
        <div v-if="championship.level === '2'">
          <p style="font-size: 0.9rem">личный чемпионат</p>
          <p>дата начала чемпионата</p>
          <datetime-picker v-model="championship.date"
                           :confirm="true"
                           :show-second="false"
                           :minute-step="10"
                           :placeholder="'Дата'"
                           :type="'datetime'"
                           :style="{ width: '100%' }"
                           :disabled="championship.status !== 1"
                           @change="changeDate"/>
          <p>длительность чемпионата</p>
          <datetime-picker v-model="championship.time"
                           :confirm="true"
                           :show-second="false"
                           :minute-step="10"
                           :disabled-time="checkTime"
                           :default-value="new Date().setHours(2, 0, 0, 0)"
                           :placeholder="'Длительность, ч'"
                           :type="'time'"
                           :style="{ width: '100%' }"
                           :disabled="championship.status !== 1"
                           @change="changeTime"/>
        </div>
      </div>
    </div>
    <div class="champ-body">
      <div class="champ-body-header">
        <toggle-switch :defaultItems="editChItems"
                       :selectedItem="editCh"
                       :background-first-color="'rgba(241,243,244,0.15)'"
                       :background-second-color="'rgba(241,243,244,0.30)'"
                       :text-first-color="'#F5F5F5'"
                       :text-second-color="'#F5F5F5'"
                       :border-color="'rgba(0,0,0,0.5)'"
                       style="height: 50px; padding-bottom: 10px"
                       @changeSelection="changeEditCh"/>
      </div>
      <div class="hr-header"/>
      <div class="champ-content">
        <div v-if="editCh === '1'">
          <p style="margin: 0.5rem 20px 0;">учебные заведения</p>
          <multi-select placeholder="Учебные заведения"
                        :options="allInstitutions"
                        :selected-options="championship.institutions"
                        :isDisabled="championship.status !== 1"
                        style="margin: 0 20px 20px; width: unset"
                        @select="changeInstitution"/>
          <div class="hr"/>
          <p style="margin: 0.5rem 20px 0;">отдельные команды</p>
          <multi-select placeholder="Отдельные команды"
                        :options="allTeams"
                        :selected-options="championship.teams"
                        :isDisabled="championship.status !== 1"
                        style="margin: 0 20px 20px; width: unset"
                        @select="changeTeam"/>
        </div>

        <div v-if="editCh === '2'">
          <p v-if="Object.keys(championship.map).length !== 0">выбранная карта</p>
          <maps v-if="Object.keys(championship.map).length !== 0"
                :clear="true"
                :preloaded-map="this.championship.map"
                :preloaded="true"
                :show-search="false"
                :disabled="championship.status !== 1"
                @deleteMap="changeMap"/>
          <div v-if="Object.keys(championship.map).length !== 0 && championship.status === 1" class="hr"/>
          <p v-if="championship.status === 1">доступные карты</p>
          <maps v-if="championship.status === 1"
                :clear="true"
                :canvas-size="100"
                @addMap="changeMap"/>
        </div>

        <div v-if="editCh === '3'">
          <p v-if="championship.tasks.length !== 0">выбранные задания</p>
          <tasks v-if="championship.tasks.length !== 0"
                :clear="true"
                :preloaded-tasks="this.championship.tasks"
                :preloaded="true"
                :show-search="false"
                :canvas-size="100"
                :disabled="championship.status !== 1"
                @deleteTask="deleteTask"/>
          <div v-if="championship.tasks.length !== 0 && championship.status === 1" class="hr"/>
          <p v-if="championship.status === 1">доступные задания</p>
          <tasks v-if="championship.status === 1"
                 :clear="true"
                 :canvas-size="100"
                 @addTask="changeTask"/>
        </div>
      </div>
    </div>
    <message/>
  </div>
</template>

<script>
import axios from 'axios';
import DatePicker from 'vue2-datepicker';
import VueSlider from 'vue-slider-component';
import 'vue-slider-component/theme/antd.css';
import 'vue-search-select/dist/VueSearchSelect.css';
import 'vue2-datepicker/index.css';
import { MultiSelect, ModelSelect } from 'vue-search-select';
import CustomInput from '../Main/CustomInput';
import ToggleSwitch from '../Main/ToggleSwitch';
import Maps from '../Maps';
import Tasks from '../Tasks';
import Message from '../Main/Message';


export default {
  name: 'Championship',
  components: {
    'custom-input': CustomInput,
    'toggle-switch': ToggleSwitch,
    'multi-select': MultiSelect,
    'model-select': ModelSelect,
    'datetime-picker': DatePicker,
    'maps': Maps,
    'tasks': Tasks,
    'vue-slider': VueSlider,
    'message': Message,
  },
  data() {
    return {
      pathGetInstitutions: 'http://localhost:5050/allInstitutionsText',
      pathGetTeams: 'http://localhost:5050/allTeamsText',
      pathSaveChampionship: 'http://localhost:5050/saveChampionship',

      championship: {},
      borderType: 'border',
      roomType: 'room',

      maxTaskCellCount: 100,
      defaultMaxTaskCellCount: 100,

      dateOptions: {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        weekday: 'long',
        timezone: 'UTC',
        hour: 'numeric',
        minute: 'numeric',
        second: 'numeric',
      },
      timeOptions: {
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit',
      },

      editChItems: [
        {
          type: '1',
          name: 'участники',
        },
        {
          type: '2',
          name: 'карта',
        },
        {
          type: '3',
          name: 'задачи',
        },
      ],
      editCh: '1',

      levelChItems: [
        {
          type: '1',
          name: 'глобальный',
        },
        {
          type: '2',
          name: 'личный',
        },
      ],
      stagesChItems: [
        { value: 1, text: 'отборочный тур' },
        { value: 2, text: 'основной тур' },
        { value: 3, text: 'финальный тур' },
      ],
      allInstitutions: [],
      allTeams: [],
    };
  },
  methods: {
    mainClick(event) {
      this.$emit('mainClick', { event: event.event });
    },
    closeCh() {
      this.showMessage('отменить все изменения',
        'прервать ' + (this.championship.isNew ? 'создание' : 'редактирование') + ' чемпионата?',
        'confirm-error',
        15000,
        this.sendCloseCh);
    },
    sendCloseCh() {
      this.$emit('closeCh');
      this.$emit('closeMessage');
    },
    deleteCh() {
      this.showMessage('удалить чемпионат?',
        '',
        'confirm-error',
        15000,
        this.sendDeleteCh);
    },
    sendDeleteCh() {
      this.$emit('deleteCh', { id: this.championship.id });
      this.$emit('closeMessage');
    },
    saveCh() {
      // console.log(this.championship);
      this.showMessage('сохранить все изменения',
        'закончить редактирование и сохранить чемпионат?',
        'confirm',
        15000,
        this.checkCh);
    },
    checkCh() {
      if (this.championship.name === null || this.championship.name === '') {
        this.showMessage('ошибка сохранения',
          'имя чемпионата обязательно',
          'error',
          5000);
        return;
      }
      if (this.championship.level === '1' && (this.championship.stage === null || this.championship.stage.text === '')) {
        this.showMessage('ошибка сохранения',
          'у глобального чемпионата должен быть выбран этап',
          'error',
          5000);
        return;
      }
      if (this.championship.date === null || this.championship.date === '') {
        this.showMessage('ошибка сохранения',
          'у чемпионата должна быть выбрана дата проведения',
          'error',
          5000);
        return;
      }
      if (this.championship.time === null || this.championship.time === '') {
        this.showMessage('ошибка сохранения',
          'у чемпионата должна быть выбрана длительность проведения',
          'error',
          5000);
        return;
      }
      if ((this.championship.institutions === null || this.championship.institutions.length === 0) && (this.championship.teams === null || this.championship.teams.length === 0)) {
        this.showMessage('ошибка сохранения',
          'у чемпионата должны быть участники - команды от указанных учебных заведений или отдельные команды',
          'error',
          8000);
        return;
      }
      if (this.championship.tasks === null || this.championship.tasks.length < this.championship.taskCount) {
        let taskCount = this.championship.taskCount - this.championship.tasks.length;
        this.showMessage('ошибка сохранения',
          'выберите ещё ' + taskCount + (taskCount === 1 ? ' задачу' : taskCount > 1 && taskCount < 5 ? ' задачи' : ' задач'),
          'error',
          8000);
        return;
      }
      if (Object.keys(this.championship.map).length === 0) {
        this.showMessage('ошибка сохранения',
          'выберите карту для проведения чемпионата',
          'error',
          8000);
        return;
      }

      let map = this.championship.map.map;
      let sizeY = this.championship.map.sizeY;
      let sizeX = this.championship.map.sizeX;
      let heroPosition = [];

      for (let y = 0; y < sizeY; y++) {
        for (let x = 0; x < sizeX; x++) {
          if (map[y][x].type === this.roomType) {
            heroPosition.push({ x, y });
          }
        }
      }
      for (let i = 0; i < 5; i++) {
        let hero = heroPosition.splice(Math.floor(Math.random() * heroPosition.length), 1)[0];
        map[hero.y][hero.x].heroPosition = true;
      }
      let taskCells = [];
      for (let y = 0; y < sizeY; y++) {
        for (let x = 0; x < sizeX; x++) {
          if (map[y][x].type === this.borderType &&
            (y !== 0 && map[y - 1][x].type === this.roomType ||
              y !== sizeY - 1 && map[y + 1][x].type === this.roomType ||
              x !== 0 && map[y][x - 1].type === this.roomType ||
              x !== sizeX - 1 && map[y][x + 1].type === this.roomType)) {
            taskCells.push({ x, y });
          }
        }
      }
      while (taskCells.length > this.championship.taskCellCount) {
        let testIndex = Math.floor(Math.random() * taskCells.length);
        taskCells.splice(testIndex, 1);
      }
      for (let taskCell of taskCells) {
        map[taskCell.y][taskCell.x].taskCell = true;
      }
      for (let task of this.championship.tasks) {
        let taskP = taskCells.splice(Math.floor(Math.random() * taskCells.length), 1)[0];
        map[taskP.y][taskP.x].task = task.id;
      }

      let data = {
        id: this.championship.id,
        name: this.championship.name.trim(),
        stage: this.championship.stage.text,
        date: this.championship.date,
        time: this.championship.time.getHours() * 3600000 + this.championship.time.getMinutes() * 60000,
        level: parseInt(this.championship.level, 10),
        institutions: this.championship.institutions.map(i => i.value),
        teams: this.championship.teams.map(i => i.value),
        taskCount: this.championship.taskCount,
        taskCellCount: this.championship.taskCellCount,
        map,
        mapId: this.championship.map.id,
        tasks: this.championship.tasks.map(i => i.id),
        author: JSON.parse(localStorage.getItem('user')).id,
      };

      axios.post(this.pathSaveChampionship, data)
        .then(() => {
          this.showMessage('сохранение чемпионата',
            'чемпионат добавлен успешно',
            'success',
            5000);
          this.$emit('saveCh');
        })
        .catch((error) => {
          for (let y = 0; y < sizeY; y++) {
            for (let x = 0; x < sizeX; x++) {
              map[y][x].task = -1;
              map[y][x].taskCell = false;
              map[y][x].heroPosition = false;
            }
          }
          console.error(error);
          this.showMessage('ошибка при сохранении',
            'подробности в консоли браузера',
            'error',
            5000);
        });
    },
    changeName(data) {
      if (Object.keys(this.championship).includes('name')) {
        this.championship.name = data.value;
      }
    },
    changeEditCh(data) {
      this.editCh = data['selection'];
    },
    changeLevelCh(data) {
      this.championship.level = data['selection'];
      this.championship.stage = {
        value: 0,
        text: '',
      };
      this.championship.date = null;
      this.championship.time = 0;

      this.showMessage('смена параметров',
        this.championship.level === '1' ? 'чемпионат доступен всем' : 'чемпионат доступен только вам',
        this.championship.level === '1' ? 'info' : 'special',
        5000);
    },
    // changeStages(items) {
    //   this.championship.stage = items;
    // },
    changeInstitution(items) {
      this.championship.institutions = items;
    },
    changeTeam(items) {
      this.championship.teams = items;
    },
    changeDate(date) {
      if (date !== null) {
        if (this.championship.level === '1') {
          let stage = this.championship.stage.text.split(' ')[0];
          stage = stage.slice(0, stage.length - 2, 2) + 'ого';
          this.showMessage('дата ' + stage + ' тура',
            'дата проведения ' + stage + ' тура: ' + date.toLocaleString('ru', this.dateOptions),
            'info',
            8000);
        } else {
          this.showMessage('дата личного чемпионата',
            'дата проведения: ' + date.toLocaleString('ru', this.dateOptions),
            'info',
            8000);
        }
      }
    },
    changeTime(time) {
      if (time !== null) {
        if (this.championship.level === '1') {
          let stage = this.championship.stage.text.split(' ')[0];
          stage = stage.slice(0, stage.length - 2, 2) + 'ого';
          this.showMessage('длительность ' + stage + ' тура',
            'длительность проведения ' + stage + ' тура: ' + time.toLocaleString('ru', this.timeOptions),
            'info',
            8000);
        } else {
          this.showMessage('длительность личного чемпионата',
            'длительность проведения: ' + time.toLocaleString('ru', this.timeOptions),
            'info',
            8000);
        }
      }
    },
    changeMap(data) {
      this.championship.map = {};
      this.$nextTick(() => { this.championship.map = data.map; });
      if (Object.keys(data.map).length === 0) {
        if (this.championship.taskCellCount > this.defaultMaxTaskCellCount) {
          this.championship.taskCellCount = this.defaultMaxTaskCellCount;
        }
        this.maxTaskCellCount = this.defaultMaxTaskCellCount;
        this.showMessage('удаление карты',
          'выберите карту для чемпионата',
          'info',
          5000);
      } else {
        if (this.championship.taskCellCount > data.map.taskCellCount) {
          this.championship.taskCellCount = data.map.taskCellCount;
        }
        this.maxTaskCellCount = data.map.taskCellCount;
        this.showMessage('добавление карты',
          'карта для чемпионата выбрана',
          'success',
          5000);
      }
    },
    changeTaskCount() {
      this.showMessage('смена параметров',
        'задач в чемпионате: ' + this.championship.taskCount,
        'info',
        5000);
      if (this.championship.taskCount < this.championship.tasks.length) {
        this.updateTasks(this.championship.taskCount - 1, this.championship.tasks.length - this.championship.taskCount);
      }
    },
    changeTaskCellCount() {
      this.showMessage('смена параметров',
        'ячеек для задач на карте: ' + this.championship.taskCellCount,
        'info',
        5000);
    },
    deleteTask(data) {
      this.showMessage('удаление задачи',
        'осталось добавить еще ' + (this.championship.taskCount + 1 - this.championship.tasks.length) + ' шт.',
        'info',
        5000);
      this.updateTasks(data.index, 1);
    },
    changeTask(data) {
      if (!this.championship.tasks.some(t => t.id === data.task.id)) {
        if (this.championship.taskCount - this.championship.tasks.length > 0) {
          this.championship.tasks.push(data.task);
          this.showMessage('добавление задачи',
            this.championship.taskCount - this.championship.tasks.length === 0 ?
              'все задачи добавлены' :
              'осталось добавить еще ' + (this.championship.taskCount - this.championship.tasks.length) + ' шт.',
            this.championship.taskCount - this.championship.tasks.length === 0 ? 'success' : 'info',
            5000);
        } else {
          this.showMessage('добавление задачи',
            'добавлено максимальное количество задач (' + this.championship.taskCount + ')',
            'error',
            5000);
        }
      } else {
        this.showMessage('добавление задачи',
          'задача уже добавлена',
          'error',
          5000);
      }
    },
    checkTime(date) {
      return date.getHours() > 10;
    },
    updateTasks(index, count) {
      this.championship.tasks.splice(index, count);
      let savedTasks = this.championship.tasks;
      this.championship.tasks = [];
      this.$nextTick(() => { this.championship.tasks = savedTasks; });
    },
    showMessage(title, message, messageType, delay, functionConfirm) {
      this.$emit('showMessage', { title, message, messageType, delay, functionConfirm });
    },
  },
  created() {
    this.showMessage('создание чемпионата',
      'настройте исходные данные чемпионата, выберите задачи, карту и участников',
      'special',
      15000);
    this.championship = this.defaultChampionship;
    if (this.championship.map) {
      this.maxTaskCellCount = this.championship.map.taskCellCount;
    }

    this.$parent.$on('mainClick', this.mainClick);
    axios.get(this.pathGetInstitutions)
      .then((res) => {
        this.allInstitutions = res.data.institutions;
      })
      .catch((error) => {
        console.error(error);
        this.showMessage('ошибка при загрузке институтов',
          'подробности в консоли браузера',
          'error',
          5000);
      });

    axios.get(this.pathGetTeams)
      .then((res) => {
        this.allTeams = res.data.teams;
      })
      .catch((error) => {
        console.error(error);
        this.showMessage('ошибка при загрузке команд',
          'подробности в консоли браузера',
          'error',
          5000);
      });
  },
  props: {
    defaultChampionship: {
      type: Object,
      default: () => {
        return {
          name: '',
          level: '1',
          stage: {
            value: 0,
            text: '',
          },
          date: null,
          time: 0,
          institutions: [],
          teams: [],
          taskCount: 5,
          taskCellCount: 50,
          map: {},
          tasks: [],
          isNew: true,
        };
      },
    },
  },
};
</script>

<style scoped>
.champ {
  width: 100%;
  height: calc(100% - 270px);
  margin-top: 10px;
  margin-left: 10px;
  position: relative;
  display: grid;
  grid-template-columns: 347px 1fr;
  gap: 0 10px;
}
.champ-content {
  position: absolute;
  width: calc(100% - 13px);
  padding-right: 5px;
  margin-top: 50px;
  max-height: 100%;
  height: calc(100% - 70px);
  overflow: scroll;
}
.champ-header {
  /*width: 340px;*/
  max-height: 100%;
  /*overflow: scroll;*/
  background-color: rgba(241,243,244,0);
  border-radius: 0.25rem;
  border: 1px solid rgb(33, 37, 41);
  padding: 10px;
  transition: all 0.2s ease;
  position: relative;
  color: #F5F5F5;
}
.champ-content p,
.champ-header p {
  margin: 0.5rem 0 0;
  font-size: 0.8em;
}
.champ-body {
  max-height: 100%;
  background-color: rgba(241,243,244,0);
  border-radius: 0.25rem;
  border: 1px solid rgb(33, 37, 41);
  padding: 10px;
  transition: all 0.2s ease;
  position: relative;
  color: #F5F5F5;
  display: flex;
  flex-direction: column;
  align-items: center;
}
.champ-body-header {
  width: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  /*display: grid;*/
  /*grid-template-columns: 5fr 3fr;*/
}
.champ-body-header-events {
  width: 100%;
  display: flex;
  flex-direction: column;
  justify-content: left;
}
.champ-body-header-events p {
  margin: 0;
  font-size: 0.8em;
}
.hr {
  height: 1px;
  width: 100%;
  margin: 1rem 0 0.5rem;
  box-shadow: inset 0 -1px 0 rgb(255 255 255 / 12%);
}
.hr-header {
  height: 1px;
  width: calc(100% - 20px);
  top: 60px;
  left: 10px;
  position: absolute;
  box-shadow: inset 0 -1px 0 rgb(255 255 255 / 12%);
}
*::-webkit-scrollbar{
  display: block;
  width: 6px;
  height: 0;
}
*::-webkit-scrollbar-thumb {
  -webkit-border-radius: 10px;
  border-radius: 10px;
  padding: 2px;
  background: rgba(241,243,244,0.4);
  -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5);
}
*::-webkit-scrollbar-thumb:hover {
  background: rgba(241,243,244,0.6);
  -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5);
}
</style>
