<template>
  <main id="dairMap-main" @click="globalClick">
    <div class="background" :style="{ '--background-before-url': backgroundImage}"></div>
    <span class="footer top-panel">
      <div v-for="(action, index) in globalActions"
           :style="{'background-image': action.url, 'height': '40px'}"
           :key="index" :class="['top-panel-item', 'top-panel-item-actions', action.id === selectedGlobalAction.id ? 'top-panel-item-actions-selected' : action.id === preSelectedGlobalAction.id ? 'top-panel-item-actions-pre-selected' : '' ]"
           @mouseover="preSelectedGlobalAction = action" @mouseleave="preSelectedGlobalAction = {}" @click="selectGlobalAction">
          <p>{{ action.name }}</p>
      </div>
    </span>
    <span class="footer top-panel sub-top-panel" v-if="selectedGlobalAction.id === 1">
      <div v-for="(subAction1, index) in globalSubActions1"
           :style="{'background-image': subAction1.url}"
           :key="index" :class="['top-panel-item', 'top-panel-item-sub-actions-1', subAction1.id === selectedGlobalSubAction1.id ? 'top-panel-item-sub-actions-1-selected' : subAction1.id === preSelectedGlobalSubAction1.id ? 'top-panel-item-sub-actions-1-pre-selected' : '' ]"
           @mouseover="preSelectedGlobalSubAction1 = subAction1" @mouseleave="preSelectedGlobalSubAction1 = {}" @click="selectGlobalSubAction1">
          <p>{{ subAction1.name }}</p>
        </div>
    </span>
    <span class="footer top-panel sub-top-panel" v-if="selectedGlobalAction.id === 2">
      <div :style="{'background-image': globalSubActions2[1].url}"
           :class="['top-panel-item', 'top-panel-item-sub-actions-2', globalSubActions2[1].id === selectedGlobalSubAction2.id ? 'top-panel-item-sub-actions-2-selected' : globalSubActions2[1].id === preSelectedGlobalSubAction2.id ? 'top-panel-item-sub-actions-2-pre-selected' : '' ]"
           @mouseover="preSelectedGlobalSubAction2 = globalSubActions2[1]" @mouseleave="preSelectedGlobalSubAction2 = {}" @click="selectGlobalSubAction2">
          <p>{{ globalSubActions2[1].name }}</p>
      </div>
      <i class='bx bx-minus bx-rotate-90' style="margin: 0 5px 0 5px !important; font-size: 1.8em"/>
      <div class="top-panel-container" style="width: 80%;">
        <div v-for="(subAction2, index) in globalSubActions2" v-if="subAction2.id !== 1"
             :style="{'background-image': subAction2.url}"
             :key="index" :class="['top-panel-item', 'top-panel-item-sub-actions-2', subAction2.id === selectedGlobalSubAction2.id ? 'top-panel-item-sub-actions-2-selected' : subAction2.id === preSelectedGlobalSubAction2.id ? 'top-panel-item-sub-actions-2-pre-selected' : '' ]"
             @mouseover="preSelectedGlobalSubAction2 = subAction2" @mouseleave="preSelectedGlobalSubAction2 = {}" @click="selectGlobalSubAction2">
          <p>{{ subAction2.name }}</p>
        </div>
      </div>
    </span>
    <div class="dairMap-container">
      <div :style="{ minWidth: getDairSizeX() + 'px',
                     // display: 'none',
                     // marginTop: '5px',
                     maxWidth: getDairSizeX() + 'px',
                     minHeight: getDairSizeY() + 'px',
                     maxHeight: getDairSizeY() + 'px'}">
        <canvas id="dairCanvas"
                :style="{width: getDairSizeX() + 'px',
                         height: getDairSizeY() + 'px'}"
                @mousemove="move"
                @mouseleave="clear"
                @mousedown="tryDo"/>
      </div>
    </div>
    <span class="footer">
      <div v-if="selectedGlobalAction.id === 2" class= "footerResources">
         <div class="footerResourcesSettings">
          <i :class="['bx', 'bx-download', 'bx-rotate-270']" style="font-size: 1.2em; margin-left: 0; color: inherit"/>
          <div style="color: inherit">Следующий период</div>
        </div>
      </div>
      <vue-slider v-model="dairZoom"
                  :tooltip-formatter="val => (Math.round((val / minDairZoom) * 10) / 10) + 'x'"
                  :min="minDairZoom"
                  :max="maxDairZoom"
                  :style="{margin: '0',
                           width: '260px'}"
                  @drag-start="() => isResizing = true"
                  @drag-end="() => {isResizing = false; drawCanvas(true);}"
                  @change="() => {if(!isResizing) drawCanvas(true)}">
        <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
          <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ Math.round((value / minDairZoom) * 10) / 10 }}</div>
        </template>
      </vue-slider>
    </span>
  </main>
</template>

<script>
import axios from 'axios';
import 'vue-slider-component/theme/antd.css';
import VueSlider from 'vue-slider-component';
import '../assets/css/custom-dot.css';

export default {
  name: 'Dair',
  components: { 'vue-slider': VueSlider },
  data() {
    return {
      documentTitle: 'DND',
      dairMap: [],
      backgroundImage: `url(${require('../assets/images/dairs/meisters.jpg')})`,
      pathSave: 'http://localhost:5050/saveDair',
      pathGet: 'http://localhost:5050/getDair',

      minDairZoom: 30,
      dairZoom: 30,
      maxDairZoom: 90,
      canvas: null,
      context: null,
      isResizing: false,

      dairSizeY: 25,
      dairSizeX: 40,

      isDrawing: false,

      preSelectedGlobalAction: {},
      preSelectedGlobalSubAction1: {},
      preSelectedGlobalSubAction2: {},
      selectedGlobalAction: {
        id: 1,
      },

      selectedGlobalSubAction1: {
        id: 1,
      },

      selectedGlobalSubAction2: {
        id: 1,
      },

      globalSubActions1: {
        1: {
          id: 1,
          name: 'Карта',
          url: `url(${require('../assets/images/subactions/create.jpg')})`,
        },
        2: {
          id: 2,
          name: 'Персонажи',
          url: `url(${require('../assets/images/subactions/units.png')})`,
        },
      },

      globalSubActions2: {
        1: {
          id: 1,
          name: 'Общий вид',
          url: `url(${require('../assets/images/subactions/global.jpg')})`,
        },
        2: {
          id: 2,
          name: 'Ресурсы',
          url: `url(${require('../assets/images/subactions/resources.jpg')})`,
        },
        3: {
          id: 3,
          name: 'Здания',
          url: `url(${require('../assets/images/subactions/buildings.png')})`,
        },
        4: {
          id: 4,
          name: 'Специальные места',
          url: `url(${require('../assets/images/subactions/special.jpg')})`,
        },
        5: {
          id: 5,
          name: 'Юниты',
          url: `url(${require('../assets/images/subactions/units.png')})`,
        },
      },

      globalActions: {
        1: {
          id: 1,
          name: 'Подготовка',
          url: `url(${require('../assets/images/subactions/global.jpg')})`,
        },
        2: {
          id: 2,
          name: 'DND',
          url: `url(${require('../assets/images/subactions/resources.jpg')})`,
        },
      },
    };
  },
  methods: {
    loadAll() {
      this.canvas = document.getElementById('dairCanvas');
      this.context = this.canvas.getContext('2d');
    },
    stopPropagation(event) {
      event.stopPropagation();
    },
    move(e) {},
    clear() {},
    draw() {},
    onDrawEnd(event) {},
    tryDo() {},
    getDairSizeX() {
      return this.dairSizeX * this.dairZoom;
    },
    getDairSizeY() {
      return this.dairSizeY * this.dairZoom;
    },
    drawCanvas(isClear) {},
    exists(x, y) {
      if (x < 0 || x >= this.dairSizeX) {
        return false;
      }
      if (y < 0 || y >= this.dairSizeY) {
        return false;
      }
      return true;
    },
    selectGlobalAction() {
      this.selectedGlobalAction = this.preSelectedGlobalAction;
      this.selectedGlobalSubAction1 = this.globalSubActions1[1];
      this.selectedGlobalSubAction2 = this.globalSubActions2[1];
    },
    selectGlobalSubAction1() {
      this.selectedGlobalSubAction1 = this.preSelectedGlobalSubAction1;
    },
    selectGlobalSubAction2() {
      this.selectedGlobalSubAction2 = this.preSelectedGlobalSubAction2;
      this.drawCanvas(false);
    },
    globalClick(event) {
      this.onDrawEnd(event);
    },
  },
  computed: {
  },
  created() {
    document.title = this.documentTitle;
  },
  mounted() {
    // window.onbeforeunload = () => true;
    this.loadAll();
  },
};
</script>
<style scoped>
@import url('https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css');
* {
  user-select:none;
  color: #F5F5F5;
}
#dairMap-main {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  position: fixed;
}
.dairMap-container {
  display: -webkit-box;
  overflow: scroll;
  padding-top: 10px;
  min-width: 100%;
  height: 100%;
  justify-content: center;
  align-items: start;
}
.dairMap-container::-webkit-scrollbar {
  display: block !important;
}
.modalContainer {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: max-content;
  /*height: 60%;*/
  /*border: 1px solid rgba(255, 214, 0, 0.8);*/
  /*box-shadow: 0 0 0 5px rgba(201, 255, 54, 0.2);*/
  /*border: 1px solid rgba(255, 255, 255, 1);*/
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border-radius: 12px;
  background: rgba(17, 16, 29, 0.85);
  padding: 10px;
}
.nextPeriodContainerItemResourcesContainer {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
  margin: 0 10px;
}
.nextPeriodContainerItemResources {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-evenly;
}
.nextPeriodContainerItem {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  margin-bottom: 20px;
  padding: 5px 10px;
  border-radius: 12px;
  /*border: var(--first-color);*/
}
.marketOwnersItem{
  font-size: 0.9em;
  margin: 7px;
  border-radius: 8px;
  display: flex;
  justify-content: center;
  width: 80%;
  padding: 1px 5px;
  position: relative;
  transition: all 0.1s ease;
  border: 2px solid rgba(0, 0, 0, 0);
}
.canSelectedMarketOwnersItem:hover {
  border-color:  var(--first-color) !important;
  color: rgba(255, 255, 255, 1) !important;
  cursor: pointer;
}
.marketOwners {
  display: flex;
  width: 200px;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  border-radius: 12px;
  margin: 5px;
}
.marketPlaceSubContainer {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: left;
  width: 100%;
}
.marketPlaceSubContainerTime {
  position: absolute;
  font-size: 0.9em;
  top: -1.1em;
  left: 0;
  opacity: 0.7;
}
.marketPlaceContainer {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: left;
  width: 100%;
}
.marketPlace {
  border: 1px solid;
  height: max-content;
  width: 350px;
  padding: 0 20px;
}
.modalContainerContainer {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-evenly;
  /*margin: 0 10px;*/
}
.marketOwnersSelected {
  border: var(--border-color) !important;
  box-shadow: var(--second-color) !important;
}
.modalWindow {
  position: fixed;
  width: 100%;
  height: 100%;
  background: rgba(17, 16, 29, 0.46);
  z-index: 100;
}
#itemMenu {
  position: absolute;
  background: rgba(17, 16, 29, 0.85);
  transition: all 0.15s ease;
  border-radius: 12px;
  bottom: 80px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: right;
  padding: 5px 10px 5px 10px;
  border: var(--first-color);
  box-shadow: var(--second-color);
}
.close:hover {
  color: #F5F5F5;
}
.itemMenuInfo {
  width: 100%;
  /*height: 100%;*/
  font-size: 0.9em;
}
.itemMenuManageActions i {
  font-size: 1.8em;
  padding: 6px;
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 8px;
  color: rgba(255, 255, 255, 0.7);
}
.itemMenuManageActions .actions {
  display: flex;
  flex-direction: column;
}
.itemMenuManageActions {
  width: 100%;
  display: flex;
  flex-direction: row;
  justify-content: space-evenly;
}
.itemMenuSubActionsResourcesContainer {
  position: absolute;
  bottom: -20px;
  width: 100%;
  display: flex;
  justify-content: space-evenly;
}
.itemMenuSubActionsManage, .itemMenuSubActionsManageOwner {
  font-size: 0.9em;
  margin: 3px;
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 8px;
  display: flex;
  justify-content: center;
  width: 70%;
  padding: 1px 5px;
  position: relative;
  transition: all 0.1s ease;
}
.itemMenuSubActionsManageOwner:hover {
  border-color:  var(--first-color) !important;
  color: rgba(255, 255, 255, 1) !important;
  cursor: pointer;
}
.itemMenuSubActionsManage:hover, .itemMenuSubActionsManageSelected {
  border-color:  rgba(255, 255, 255, 1);
  color: rgba(255, 255, 255, 1);
  cursor: pointer;
}
.cannotBuild, .deleteResource {
  border: 1px solid rgba(255, 0, 0, 0.4) !important;
  color: #ff4242 !important;
}
.deleteResource:hover {
  cursor: pointer;
  border: 1px solid red !important;
}
.cannotBuild:hover {
  cursor: unset !important;
}
.itemMenuSubActions {
  width: 100%;
  /*height: 100%;*/
  font-size: 0.9em;
  display: flex;
  flex-direction: column;
  justify-content: space-around;
}
.subtitle {
  font-size: 1em;
  margin-top: 15px;
  margin-bottom: 5px;
  width: 80%;
}
.title {
  font-size: 1.3em;
  margin-bottom: 15px;
  width: 100%;
  text-align: center;
}
.monster {
  background-position: center;
  background-repeat: no-repeat;
  background-size: contain !important;
  width: 100%;
  height: 200px;
  position: relative;
  top: 20px;
  z-index: 1;
}
.itemMenuSubActions .actions {
  transition: all 0.22s ease;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  margin-bottom: 7px;
  /*height: 100%;*/
}
.itemMenuSubActions .actions p {
  margin: 0;
}
.submit:hover {
  cursor: pointer;
  filter: none;
}
.submit {
  border-radius: 5px;
  padding: 3px 10px 3px 10px;
  margin-top: 23px !important;
  margin-bottom: 5px !important;
  color: inherit;
  line-height: 0.9em;
  text-align: center;
  background: rgba(74,255,54,0.2);
  border: 1px solid rgba(74,255,54,0.5);
  transition: all 0.15s ease;
  font-size: 1.2em;
}
.submitYes:hover, submitNo:hover {
  border-color: #26ee20;
  /*border-color: #F5F5F5;*/
  /*background: linear-gradient(to right, rgba(0, 65, 106, 0.5), rgba(121, 159, 12, 0.5), rgba(255, 224, 0, 0.5));*/
}
#destroy {
  font-size: 0.9em;
}
.itemMenuActions {
  width: 100%;
  height: 100%;
  font-size: 0.9em;
  display: flex;
  justify-content: space-around;
}
.itemMenuActions .actions, .marketActions {
  border: 1px solid rgba(255, 255, 255, 0.2);
  transition: all 0.15s ease;
  color: rgba(255, 255, 255, 0.7);
  border-radius: 8px;
  margin: 6px;
  padding: 6px;
  font-size: 2.3em;
}
.itemMenuActions .actions:hover, .itemMenuActionsSelected, .itemMenuManageActions i:hover, .footerResourcesSettings:hover, .marketActionsTradable:hover, .top-panel-item-actions:hover, .footerResourcesMap:hover {
  border-color:  rgba(255, 255, 255, 1) !important;
  color: rgba(255, 255, 255, 1) !important;
  cursor: pointer;
}
.itemMenuText {
  position: absolute;
  top: -1.3em;
  left: 5px;
  font-size: 0.8em;
}
.itemMenuTextAction {
  font-size: 0.8em;
}
.itemMenuTextSubAction {
  font-size: 0.8em;
}
.itemMenuValue {
  margin-left: 10px;
  font-size: 1em;
}
.itemMenuContainer {
  /*height: 30px;*/
  display : flex;
  align-items: center;
  margin-bottom: 1.3em;
  position: relative;
}
.itemMenuContainerActions {
  display : flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  /*margin-bottom: 1.3em;*/
  position: relative;
}
.itemMenuContainer i {
  font-size: 1.3em;
  cursor: unset;
  margin-left: 5px;
}
.top-panel {
  height: 80px;
  padding: 0 10px !important;
  justify-content: space-evenly !important;
  width: 100%;
}
.sub-top-panel {
  height: 80px;
}
.top-panel-container {
  height: 100%;
  width: 80%;
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-evenly !important;
}
.top-panel-item-sub-actions-1 {
  width: 42% !important;
}
.top-panel-item-sub-actions-1-selected {
  width: 53% !important;
}
.top-panel-item-sub-actions-1-pre-selected {
  width: 45% !important;
}
.top-panel-item-sub-actions-2 {
  width: 28% !important;
}
.top-panel-item-sub-actions-2-selected {
  width: 37% !important;
}
.top-panel-item-sub-actions-2-pre-selected {
  width: 30% !important;
}
.top-panel-item-sub-actions-3 {
  width: 17% !important;
}
.top-panel-item-sub-actions-4 {
  width: 17% !important;
}
.top-panel-item-sub-actions-4-selected {
  width: 33% !important;
}
.top-panel-item-sub-actions-4-pre-selected {
  width: 19% !important;
}
.top-panel-item-sub-actions-3-selected, .top-panel-item-sub-actions-4-selected {
  width: 25% !important;
  filter: none !important;
  border: var(--first-color);
  box-shadow: var(--second-color);
}
.top-panel-item-sub-actions-3-pre-selected, .top-panel-item-sub-actions-4-pre-selected {
  width: 20% !important;
  cursor: pointer;
  filter: none !important;
  box-shadow: var(--second-color);
}
.top-panel-item-sub-actions-1, .top-panel-item-sub-actions-2, .top-panel-item-sub-actions-3, .top-panel-item-sub-actions-4 {
  height: 66% !important;
}
.top-panel-item-actions {
  width: 40% !important;
}
.top-panel-item-actions-selected {
  width: 50% !important;
}
.top-panel-item-actions-pre-selected {
  width: 45% !important;
}
.top-panel-item-actions-pre-selected, .top-panel-item-sub-actions-1-pre-selected, .top-panel-item-sub-actions-2-pre-selected {
  cursor: pointer;
  filter: none !important;
  box-shadow: 0 0 0 5px rgba(255, 255, 255, 0.2);
}
.top-panel-item-actions-selected, .top-panel-item-sub-actions-1-selected, .top-panel-item-sub-actions-2-selected {
  filter: none !important;
  border: 2px solid #F5F5F5;
  box-shadow: 0 0 0 5px rgba(255, 255, 255, 0.2);
}
.top-panel-item {
  transition: all 0.22s ease;
  width: 15%;
  height: 63%;
  border-radius: 12px;
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
  margin-left: 5px;
  margin-right: 5px;
  background-position: center;
  background-size: cover;
  filter: grayscale(100%);
}
.top-panel-item-selected {
  width: 30% !important;
  filter: none;
  border: var(--first-color);
  box-shadow: var(--second-color);
}
.top-panel-item-pre-selected {
  width: 20% !important;
  cursor: pointer;
  filter: none;
  box-shadow: var(--second-color);
}
.dairMap-first-selected {
  width: 100% !important;
  filter: none;
  border: var(--first-color);
  box-shadow: var(--second-color);
}
.dairMap-first-pre-selected {
  width: 100% !important;
  cursor: pointer;
  filter: none;
  box-shadow: var(--second-color);
}
.top-panel p {
  width: fit-content !important;
  padding: 3px;
  border-radius: 3px;
  background: rgba(17, 16, 29, 0.85);
}
.footerResourcesSettings {
  display: flex;
  align-items: center;
  margin-left: 25px;
  padding: 5px 20px;
  color: rgba(255, 255, 255, 0.8);
  border: 1px solid rgba(255, 255, 255, 0.35);
  transition: all 0.15s ease;
  border-radius: 6px;
}
.footerResourcesMap {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  margin: 5px;
  padding: 3px;
  color: rgba(255, 255, 255, 0.8);
  border: 1px solid rgba(255, 255, 255, 0.35);
  transition: all 0.15s ease;
  border-radius: 6px;
}
.footerResources {
  display: flex;
  align-items: center;
  justify-content: space-around;
  position: absolute;
  left: 0;
  width: fit-content;
}
.footer {
  min-height: 50px;
  background: rgba(17, 16, 29, 0.85);
  padding-right: 20px;
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
  font-size: 0.9em;
  text-align: center;
  line-height: 1em;
}
.background {
  background: black;
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
  background-image: var(--background-before-url);
  background-position: center;
  background-size: cover;
  transition: all 0.25s ease;
  position: absolute;
  margin: 0;
  padding: 0;
  width: 130%;
  height: 130%;
  /*left: -15%;*/
  /*top: -15%;*/
  filter: blur(4px);
}
</style>
