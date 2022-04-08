<template>
  <div class="champ">
    <div class="champ-header">
      <custom-input :placeholder="'Название чемпионата'"
                    :icon-class="''"
                    style="margin: 0"/>
      <div class="champ-content">
        <p>уровень чемпионата</p>
        <toggle-switch :defaultItems="levelChItems"
                       :selectedItem="levelCh"
                       :background-first-color="'rgba(241,243,244,0.06)'"
                       :background-second-color="'rgba(241,243,244,0.30)'"
                       :text-first-color="'#F5F5F5'"
                       :text-second-color="'#F5F5F5'"
                       :border-color="'rgba(0,0,0,0.5)'"
                       style="position: relative; width: 100%"
                       @changeSelection="changeLevelCh"/>
        <p v-if="levelCh === '1'">этапы чемпионата</p>
        <multi-select placeholder="Этапы чемпионата"
                      v-if="levelCh === '1'"
                      :options="stagesChItems"
                      :selected-options="stagesCh"
                      @select="changeStages"/>
        <div v-if="levelCh === '1'"
             v-for="(stage, index) in stagesCh"
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
        <div v-if="levelCh === '2'">
          <div class="hr"/>
          <p style="font-size: 0.9rem">личный чемпионат</p>
          <p>дата начала чемпионата</p>
          <datetime-picker v-model="specialStage.date"
                           :confirm="true"
                           :show-second="false"
                           :minute-step="10"
                           :placeholder="'Дата'"
                           :type="'datetime'"
                           @change="changeDate"/>
          <p>длительность чемпионата</p>
          <datetime-picker v-model="specialStage.time"
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
      <toggle-switch :defaultItems="editChItems"
                     :selectedItem="editCh"
                     :background-first-color="'rgba(241,243,244,0.06)'"
                     :background-second-color="'rgba(241,243,244,0.30)'"
                     :text-first-color="'#F5F5F5'"
                     :text-second-color="'#F5F5F5'"
                     :border-color="'rgba(0,0,0,0.5)'"
                     style="position: absolute; height: 50px; padding-bottom: 10px"
                     @changeSelection="changeEditCh"/>
      <div class="hr-header"/>
      <div class="champ-content">
        <div v-if="editCh === '1'">
          <p style="margin: 0.5rem 20px 0;">учебные заведения</p>
          <multi-select placeholder="Учебные заведения"
                        :options="allInstitutions"
                        :selected-options="selectedInstitutions"
                        style="margin: 0 20px 20px; width: unset"
                        @select="changeInstitution"/>
          <p style="margin: 0.5rem 20px 0;">отдельные команды</p>
          <multi-select placeholder="Отдельные команды"
                        :options="allTeams"
                        :selected-options="selectedTeams"
                        style="margin: 0 20px 20px; width: unset"
                        @select="changeTeam"/>
        </div>

        <div v-if="editCh === '2'">
          <p v-if="Object.keys(map).length !== 0">выбранная карта</p>
          <maps v-if="Object.keys(map).length !== 0"
                :clear="true"
                :preloaded-map="this.map"
                :preloaded="true"
                @deleteMap="changeMap"/>
          <div v-if="Object.keys(map).length !== 0" class="hr"/>
          <p>доступные карты</p>
          <maps :clear="true"
                @addMap="changeMap"/>
        </div>

        <div v-if="editCh === '3'">
          <p v-if="tasks.length !== 0">выбранные задания</p>
          <tasks v-if="tasks.length !== 0"
                :clear="true"
                :preloaded-tasks="this.tasks"
                :preloaded="true"
                @deleteTask="deleteTask"/>
          <div v-if="tasks.length !== 0" class="hr"/>
          <p>доступные задания</p>
          <tasks :clear="true"
                @addTask="changeTask"/>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import DatePicker from 'vue2-datepicker';
import 'vue2-datepicker/index.css';
import { MultiSelect } from 'vue-search-select';
import CustomInput from '../Main/CustomInput';
import ToggleSwitch from '../Main/ToggleSwitch';
import Maps from '../Maps';
import Tasks from '../Tasks';


export default {
  name: 'Championship',
  components: {
    'custom-input': CustomInput,
    'toggle-switch': ToggleSwitch,
    'multi-select': MultiSelect,
    'datetime-picker': DatePicker,
    'maps': Maps,
    'tasks': Tasks,
  },
  data() {
    return {
      pathGetInstitutions: 'http://localhost:5050/allInstitutionsText',
      pathGetTeams: 'http://localhost:5050/allTeamsText',

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
      levelCh: '1',

      stagesChItems: [
        { value: [], text: 'отборочный тур' },
        { value: [], text: 'основной тур' },
        { value: [], text: 'финальный тур' },
      ],
      stagesCh: [],

      specialStage: {},

      allInstitutions: [],
      selectedInstitutions: [],

      allTeams: [],
      selectedTeams: [],

      map: {},
      tasks: [],
    };
  },
  methods: {
    mainClick(event) {
      this.$emit('mainClick', { event: event.event });
    },
    changeEditCh(data) {
      this.editCh = data['selection'];
    },
    changeLevelCh(data) {
      this.levelCh = data['selection'];
    },
    changeStages(items) {
      this.stagesCh = items;
    },
    changeInstitution(items) {
      this.selectedInstitutions = items;
    },
    changeTeam(items) {
      this.selectedTeams = items;
    },
    changeDate(date) {
      console.log(date);
    },
    changeTime(time) {
      console.log(time);
    },
    changeMap(data) {
      this.map = {};
      this.$nextTick(() => { this.map = data.map; });
    },
    deleteTask(data) {
      this.tasks.splice(data.index, 1);
      let savedTasks = this.tasks;
      this.tasks = [];
      this.$nextTick(() => { this.tasks = savedTasks; });
    },
    changeTask(data) {
      if (!this.tasks.some(t => t.id === data.task.id)) {
        this.tasks.push(data.task);
      }
    },
    checkTime(date) {
      return date.getHours() > 10;
    },
    showMessage(title, message, messageType, delay, functionConfirm) {
      this.$emit('showMessage', { title, message, messageType, delay, functionConfirm });
    },
  },
  mounted() {
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
  background-color: rgba(241,243,244,0.11);
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
  background-color: rgba(241,243,244,0.11);
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
