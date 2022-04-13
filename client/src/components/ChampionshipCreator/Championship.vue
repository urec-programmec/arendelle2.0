<template>
  <div class="champ">
    <div class="champ-header">
      <custom-input :placeholder="'Название чемпионата'"
                    :icon-right-class="'bx-check'"
                    :icon-left-class="'bx-x-circle'"
                    :clear-on-left-click="false"
                    @do="changeName"
                    @leftClick="closeCh"
                    @rightClick="saveCh"
                    style="margin: 0"/>
      <div class="champ-content" style="margin-top: 50px">
        <p>количество задач</p>
        <vue-slider v-model="championship.taskCount"
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
        <p>максимальное количество ячеек для задач</p>
        <vue-slider v-model="championship.taskCellCount"
                    :min="10"
                    :max="100"
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
                       style="position: relative; width: 100%"
                       @changeSelection="changeLevelCh"/>
        <div class="hr"/>
        <p v-if="championship.level === '1'">этапы чемпионата</p>
        <multi-select placeholder="Этапы чемпионата"
                      v-if="championship.level === '1'"
                      :options="stagesChItems"
                      :selected-options="championship.stages"
                      @select="changeStages"/>
        <div v-if="championship.level === '1'"
             v-for="(stage, index) in championship.stages"
             :key="index">
          <div class="hr"/>
          <p style="font-size: 0.9rem">{{ stage.text }}</p>
          <p>дата начала чемпионата</p>
          <datetime-picker v-model="stage.value.date"
                           :confirm="true"
                           :show-second="false"
                           :minute-step="10"
                           :placeholder="'Дата'"
                           :type="'datetime'"
                           @change="changeDate"/>
          <p>длительность чемпионата</p>
          <datetime-picker v-model="stage.value.time"
                           :confirm="true"
                           :show-second="false"
                           :minute-step="10"
                           :disabled-time="checkTime"
                           :default-value="new Date().setHours(2, 0, 0, 0)"
                           :placeholder="'Длительность, ч'"
                           :type="'time'"
                           @change="changeTime"/>

        </div>
        <div v-if="championship.level === '2'">
          <p style="font-size: 0.9rem">личный чемпионат</p>
          <p>дата начала чемпионата</p>
          <datetime-picker v-model="championship.stages[0].value.date"
                           :confirm="true"
                           :show-second="false"
                           :minute-step="10"
                           :placeholder="'Дата'"
                           :type="'datetime'"
                           @change="changeDate"/>
          <p>длительность чемпионата</p>
          <datetime-picker v-model="championship.stages[0].value.time"
                           :confirm="true"
                           :show-second="false"
                           :minute-step="10"
                           :disabled-time="checkTime"
                           :default-value="new Date().setHours(2, 0, 0, 0)"
                           :placeholder="'Длительность, ч'"
                           :type="'time'"
                           @change="changeTime"/>
        </div>
      </div>
    </div>
    <div class="champ-body">
      <div class="champ-body-header">
<!--        <div class="champ-body-header-events">-->
<!--          <div style="margin: 0 20%">-->
<!--            <p v-if="editCh === '2'">количество ячеек для задач</p>-->
<!--            <vue-slider v-model="taskCellCount"-->
<!--                        v-if="editCh === '2'"-->
<!--                        :min="10"-->
<!--                        :max="100">-->
<!--              <template #dot="{ value, focus }" style="display: flex; justify-content: center;">-->
<!--                <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ value }}</div>-->
<!--              </template>-->
<!--            </vue-slider>-->
<!--          </div>-->
<!--        </div>-->
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
                        style="margin: 0 20px 20px; width: unset"
                        @select="changeInstitution"/>
          <div class="hr"/>
          <p style="margin: 0.5rem 20px 0;">отдельные команды</p>
          <multi-select placeholder="Отдельные команды"
                        :options="allTeams"
                        :selected-options="championship.teams"
                        style="margin: 0 20px 20px; width: unset"
                        @select="changeTeam"/>
        </div>

        <div v-if="editCh === '2'">
          <p v-if="Object.keys(championship.map).length !== 0">выбранная карта</p>
          <maps v-if="Object.keys(championship.map).length !== 0"
                :clear="true"
                :preloaded-map="this.championship.map"
                :preloaded="true"
                @deleteMap="changeMap"/>
          <div v-if="Object.keys(championship.map).length !== 0" class="hr"/>
          <p>доступные карты</p>
          <maps :clear="true"
                :canvas-size="100"
                @addMap="changeMap"/>
        </div>

        <div v-if="editCh === '3'">
          <p v-if="championship.tasks.length !== 0">выбранные задания</p>
          <tasks v-if="championship.tasks.length !== 0"
                :clear="true"
                :preloaded-tasks="this.championship.tasks"
                :preloaded="true"
                :canvas-size="100"
                @deleteTask="deleteTask"/>
          <div v-if="championship.tasks.length !== 0" class="hr"/>
          <p>доступные задания</p>
          <tasks :clear="true"
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
import 'vue2-datepicker/index.css';
import { MultiSelect } from 'vue-search-select';
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

      championship: {
        name: '',
        level: '1',
        stages: [],
        institutions: [],
        teams: [],
        taskCount: 5,
        taskCellCount: 50,
        map: {},
        tasks: [],
      },

      dateOptions: {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        weekday: 'long',
        timezone: 'UTC',
        hour: 'numeric',
        minute: 'numeric',
        second: 'numeric'
      },
      timeOptions: {
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit'
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
      // levelCh: '1',

      stagesChItems: [
        { value: [], text: 'отборочный тур' },
        { value: [], text: 'основной тур' },
        { value: [], text: 'финальный тур' },
      ],
      // stagesCh: [],

      // specialStage: {},

      allInstitutions: [],
      // selectedInstitutions: [],

      allTeams: [],
      // selectedTeams: [],

      // taskCount: 5,
      // taskCellCount: 50,

      // map: {},
      // tasks: [],
    };
  },
  methods: {
    mainClick(event) {
      this.$emit('mainClick', { event: event.event });
    },
    closeCh() {
      this.showMessage('отменить создание',
        'прервать создание чемпионата?',
        'confirm-error',
        15000,
        () => {  });
    },
    // resetCh() {
    //   this.championship.name = '';
    //   this.championship.level = '1';
    //   this.championship.stages = [];
    //   this.championship.institutions = [];
    //   this.championship.teams = [];
    //   this.championship.taskCount = 5;
    //   this.championship.taskCellCount = 50;
    //   this.championship.map = {};
    //   this.championship.tasks = [];
    // },
    // newCh(data) {
    //   this.resetCh();
    //   this.championship.name = data.value;
    // },
    saveCh() {
      this.showMessage('сохранить чемпионат',
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
      if (this.championship.stages === null || this.championship.stages.length === 0) {
        this.showMessage('ошибка сохранения',
          'у глобального чемпионата должны быть выбраны этапы',
          'error',
          5000);
        return;
      }
      for (let stage of this.championship.stages) {
        if (!Object.keys(stage.value).includes('date') || stage.value.date === null || stage.value.date === '') {
          this.showMessage('ошибка сохранения',
            'у каждого этапа чемпионата должы быть выбрана дата проведения',
            'error',
            5000);
          return;
        }
        if (!Object.keys(stage.value).includes('time') || stage.value.time === null || stage.value.time === '') {
          this.showMessage('ошибка сохранения',
            'у каждого этапа чемпионата должы быть выбрана длительность проведения',
            'error',
            5000);
          return;
        }
      }
      if (this.championship.stages === null || this.championship.stages.length === 0) {
        this.showMessage('ошибка сохранения',
          'у глобального чемпионата должны быть выбраны этапы',
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
      this.showMessage('ок',
        'всё хорошо',
        'confirm',
        5000);
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
      this.championship.stages = this.championship.level === '1' ?  [] : [{ value: { date: null, time: null } }];
      this.showMessage('смена параметров',
        this.championship.level === '1' ? 'чемпионат доступен всем' : 'чемпионат доступен только вам',
        this.championship.level === '1' ? 'info' : 'special',
        5000);
    },
    changeStages(items) {
      this.championship.stages = items;
    },
    changeInstitution(items) {
      this.championship.institutions = items;
    },
    changeTeam(items) {
      this.championship.teams = items;
    },
    changeDate(date) {
      if (date !== null) {
        if (this.championship.level === '1') {
          let stage = this.championship.stages[this.championship.stages.length - 1].text.split(' ')[0]
          stage = stage.slice(0, stage.length - 2, 2) + 'ого';
          this.showMessage('дата ' + stage +  ' тура',
            'дата проведения ' + stage +  ' тура: ' + date.toLocaleString('ru', this.dateOptions),
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
          let stage = this.championship.stages[this.championship.stages.length - 1].text.split(' ')[0]
          stage = stage.slice(0, stage.length - 2, 2) + 'ого';
          this.showMessage('длительность ' + stage +  ' тура',
            'длительность проведения ' + stage +  ' тура: ' + time.toLocaleString('ru', this.timeOptions),
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
        this.showMessage('удаление карты',
          'выберите карту для чемпионата',
          'info',
          5000);
      } else {
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
  mounted() {
    // this.showMessage('создание чемпионата',
    //   'настройте исходные данные чемпионата, выберите задачи, карту и участников',
    //   'special',
    //   15000);

    this.$parent.$on('mainClick', this.mainClick);
    axios.get(this.pathGetInstitutions)
      .then((res) => {
        this.allInstitutions = res.data.institutions;
      })
      .catch((error) => {
        console.error(error);
        this.showMessage('ошибка при загрузке',
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
        this.showMessage('ошибка при загрузке',
          'подробности в консоли браузера',
          'error',
          5000);
      });
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
