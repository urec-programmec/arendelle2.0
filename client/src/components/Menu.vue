<template>
  <div class="sidebar"
    :class="isOpened ? 'open' : ''"
    :style="cssVars"
  @click="mainClick">
    <div class="logo-details"
      style="margin: 0 14px">
      <i class="bx icon"
        :class="menuIcon"/>
      <div class="logo_name">
        {{ menuTitle }}
      </div>
      <i class="bx"
        :class="isOpened ? 'bx-menu-alt-right' : 'bx-menu'"
        id="btn"
        @click="openCloseMenu"/>
    </div>

    <div :style="{ 'height': 'calc(100% - 60px)' }">
      <div class="my-settings">
        <ul style="overflow: visible;">
            <span>
              <li style="overflow: hidden">
              <div :class="['menu_item', 'menu_item_not_hover', {'selected-menu-item' : isSettingsOpened}]">
                <div class="menu_item_row"
                     @click="openSettingsMenu">
                  <i class="bx bx-cog"/>
                  <span class="links_name">общее</span>
                </div>
                <div :class="['menu_item_row', 'menu_item_content', {'menu_item_closed': !isOpened}]"
                     :style="{ maxHeight: isSettingsOpened ? '150px' : 0,
                               padding: isSettingsOpened ? '10px 20px' : '0 20px',
                               overflow: 'inherit',
                               display: 'unset'}">
                  <div class="settings">
                    <p style="margin: 0">ширина</p>
                    <vue-slider v-model="mapSizeX"
                                :tooltip-formatter="val => val + ''"
                                :min="50"
                                :max="100"
                                @drag-start="() => isResizing = true"
                                @drag-end="() => {isResizing = false; sendChangeParameters();}"
                                @change="() => {if(!isResizing) sendChangeParameters()}">
                      <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
                        <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ value }}</div>
                      </template>
                    </vue-slider>
                    <p>высота</p>
                    <vue-slider v-model="mapSizeY"
                                :tooltip-formatter="val => val + ''"
                                :min="50"
                                :max="100"
                                @drag-start="() => isResizing = true"
                                @drag-end="() => {isResizing = false; sendChangeParameters();}"
                                @change="() => {if(!isResizing) sendChangeParameters()}">
                      <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
                        <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ value }}</div>
                      </template>
                    </vue-slider>
                    <p>количество ячеек для задач</p>
                    <vue-slider v-model="mapTaskCountValue"
                                :tooltip-formatter="val => val + ''"
                                :min="10"
                                :max="100">
                      <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
                        <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ value }}</div>
                      </template>
                    </vue-slider>
                  </div>
                </div>
              </div>
            </li>
            </span>
          <span>
              <li>
                <div :class="['menu_item', 'menu_item_not_hover', {'selected-menu-item' : isLocationMenuOpenedAsync}]">
                  <div class="menu_item_row"
                       @click="openLocationMenu"
                       @mouseenter="isLocationIconHover = true"
                       @mouseleave="isLocationIconHover = false"
                       :style="{overflow: isLocationMenuOpenedAsync ? 'initial' : 'hidden'}">
                    <i class="bx bx-map-pin"/>
                    <span class="links_name">локации</span>
                    <span :class="['bx', 'links_name', 'settings-locations', isLocationMenuOpenedAsync ? 'bx-chevron-left' : 'bx-chevron-right', {'settings-locations-icon': isLocationIconHover}]"></span>
                  </div>
                </div>
                <div :class="['locationMenu', {'locationMenuClosed' : !isLocationMenuOpenedAsync}]"
                     @click="stopPropagation">
                  <p style="text-align: center; display: block">локации</p>
                  <div style="width: 100%; height: 100%; overflow: auto; padding: 5px 10px">
                    <span v-for="(locationItem, locationIndex) in locationItems"
                          :key="locationIndex"
                          :class="['bx', { 'locationSelected': locationValue === locationItem.name }]"
                          @click="onSelectLocation(locationItem.name, locationItem.type, locationItem.icon)">
                      <i class="bx" :class="locationItem.icon" style="height: 25px; line-height: 25px; min-width: 40px;"/>
                      <p>{{ locationItem.name }}</p>
                    </span>
                  </div>
                </div>
              </li>
            </span>
        </ul>
      </div>

      <div class="my-settings">
        <ul style="margin: 0">
          <span>
            <li>
                <div :class="['menu_item', 'location_info']">
                  <div class="menu_item_row" style="grid-template-columns: 50px 1fr; overflow: hidden;">
                    <i class="bx" :class="locationIcon"/>
                    <div style="display: flex; flex-direction: column; align-items: center;">
                      <span class="links_name" style="font-size: 0.6em;">текущая локация</span>
                      <span class="links_name">{{ locationValue }}</span>
                    </div>
                  </div>
                </div>
            </li>
          </span>
        </ul>
      </div>

      <div id="my-scroll"
           class="my-settings"
           :style="{maxHeight: calculateMaxHeight()}">
        <ul>
            <span v-for="(menuItem, menuIndex) in menuItems"
                  :key="menuIndex">
              <li>
                <div :class="['menu_item', 'menu_item_not_hover', {'selected-menu-item' : menuItem.isOpen}]">
                  <div class="menu_item_row"
                       @click="() => {isOpened = true; menuItem.isOpen = !menuItem.isOpen}">
                    <i class="bx" :class="menuItem.icon"/>
                    <span class="links_name">{{ menuItem.name }}</span>
                  </div>
                  <div :class="['menu_item_row', 'menu_item_content', {'menu_item_closed': !isOpened || !menuItem.isOpen}]"
                       :style="{ maxHeight: (37 * Math.ceil(menuItem.childs.filter(i => i.split('/')[1] === locationType).length / 5) + 32) + 'px' }">
                    <div v-for="(item, itemIndex) in menuItem.childs.filter(i => i.split('/')[1] === locationType)"
                         :key="itemIndex"
                         :style="{'background-image': `url(${require(`../assets/images/${item}`)})`,
                                  'background-repeat': 'no-repeat',
                                  'background-size': 'cover'}"
                         :class="['ceil_item', 'bx', { 'ceil_item_selected': colorType === menuItem.type && colorValue === item.split('/')[2] && colorIndex === itemIndex }]"
                         @click="changeColor(menuItem.type, item.split('/')[2], itemIndex, menuItem.icon)"/>
                  </div>
                </div>
              </li>
            </span>
        </ul>
      </div>
      <div class="exit"
           style="position: absolute; bottom: 40px;"
           v-if="colorValue !== '' && colorType !== ''">
        <li style="height: 32px; width: 100%; margin: 0;">
          <i class="bx" :class="[colorIcon, 'exit_menu_item']"/>
          <i class="bx" :style="{'background-image': `url(${require('../assets/images/' + colorType + '/' + locationType + '/' + colorValue)})`,
                                 borderRadius: '6px',
                                 boxShadow: '0 0 6px 6px rgba(54, 171, 255, 0.2)'}"/>
        </li>
      </div>
      <div class="exit secondaryColor"
          style="min-height: 40px; position: absolute; bottom: 0;">
        <i class="bx bx-log-out secondaryColor"
          id="log_out"
          @click.stop="$emit('button-exit-clicked')"/>
      </div>
    </div>
  </div>
</template>

<script>
import 'vue-slider-component/theme/antd.css';
import VueSlider from 'vue-slider-component';

import '../assets/css/custom-dot.css';

export default {
  name: 'Menu',
  components: { 'vue-slider': VueSlider },
  data() {
    return {
      isOpened: false,
      colorType: '',
      colorValue: '',
      colorIndex: -1,
      colorIcon: '',

      mapSizeX: 50,
      mapSizeY: 50,
      isResizing: false,

      mapTaskCountValue: 10,
      isLocationIconHover: false,
      isLocationMenuOpened: false,
      isLocationMenuOpenedAsync: false,
      isSettingsOpened: false,
      locationValue: '',
      locationType: '',
      locationIcon: '',
    };
  },
  props: {
    //! Menu settings
    imagesSrc: {
      type: Array,
      default: () => [],
    },
    isMenuOpen: {
      type: Boolean,
      default: false,
    },
    menuTitle: {
      type: String,
      default: 'карта',
    },
    menuIcon: {
      type: String,
      default: 'bx-terminal',
    },
    //! Menu items
    menuItems: {
      type: Array,
      default: () => [
        {
          name: 'комнаты',
          icon: 'bxs-dashboard',
          type: 'room',
          childs: [],
          isOpen: false,
        },
        {
          name: 'стены',
          icon: 'bx-border-radius',
          type: 'border',
          childs: [],
          isOpen: false,
        },
        {
          name: 'переходы',
          icon: 'bx-trip',
          type: 'trip',
          childs: [],
          isOpen: false,
        },
      ],
    },
    locationItems: {
      type: Array,
      default: () => [
        {
          name: 'подземелье замка',
          icon: 'bxs-institution',
          type: 'dungeon',
        },
        {
          name: 'древний лес',
          icon: 'bxs-tree',
          type: 'forest',
        },
        {
          name: 'китайская деревня',
          icon: 'bx-home',
          type: 'village',
        },
        {
          name: 'озёрное королевство',
          icon: 'bxs-ship',
          type: 'lake_kingdom',
        },
        {
          name: 'воздух-воздух',
          icon: 'bx-cloud',
          type: 'air_air',
        },
      ],
    },
    //! Styles
    bgColor: {
      type: String,
      default: 'rgba(17, 16, 29, 0.85)',
    },
    secondaryColor: {
      type: String,
      default: 'hsl(210, 70%, 15%)',
    },
    logoTitleColor: {
      type: String,
      default: '#fff',
    },
    iconsColor: {
      type: String,
      default: '#fff',
    },
    searchInputTextColor: {
      type: String,
      default: '#fff',
    },
    menuItemsHoverColor: {
      type: String,
      default: '#fff',
    },
    menuItemsTextColor: {
      type: String,
      default: '#fff',
    },
    menuFooterTextColor: {
      type: String,
      default: '#fff',
    },
  },
  mounted() {
    this.isOpened = this.isMenuOpen;
    this.locationValue = this.locationItems[0].name;
    this.locationType = this.locationItems[0].type;
    this.locationIcon = this.locationItems[0].icon;
    for (let i of this.menuItems) {
      for (let img of this.imagesSrc) {
        let spl = img.split('/');
        if (spl.length === 3 && spl[0] === i.type) {
          i.childs.push(img);
        }
      }
    }
    this.sendChangeParameters();
  },
  methods: {
    mainClick() {
      if (this.isLocationMenuOpened) {
        this.isLocationMenuOpenedAsync = false;
        this.closeLocationMenuAsync();
      }
    },
    stopPropagation(event) {
      event.stopPropagation();
    },
    close() {
      if (this.isOpened) {
        this.openCloseMenu();
      }
    },
    openSettingsMenu() {
      if (!this.isOpened) {
        setTimeout(() => {
          this.isOpened = true;
        }, 0);
      }
      this.isSettingsOpened = !this.isSettingsOpened;
    },
    openLocationMenu(event) {
      if (this.isOpened) {
        this.isLocationMenuOpenedAsync = !this.isLocationMenuOpenedAsync;
        if (this.isLocationMenuOpened) {
          this.closeLocationMenuAsync();
        } else {
          this.isLocationMenuOpened = true;
        }
      } else {
        this.isOpened = true;
        this.isLocationMenuOpened = true;
        this.isLocationMenuOpenedAsync = true;
      }
      event.stopPropagation();
    },
    closeLocationMenuAsync() {
      setTimeout(() => { this.isLocationMenuOpened = this.isLocationMenuOpenedAsync; }, 300);
    },
    openCloseMenu() {
      if (this.isOpened) {
        for (let i of this.menuItems) {
          i['isOpen'] = false;
        }
        this.isLocationMenuOpened = false;
        this.isLocationMenuOpenedAsync = false;
        this.isSettingsOpened = false;
      }
      this.isOpened = !this.isOpened;
      this.$emit('openCloseMenu', { isOpen: this.isOpened });
    },
    changeColor(type, color, index, icon) {
      if (!(this.colorType === type && this.colorValue === color && this.colorIndex === index)) {
        this.colorType = type;
        this.colorValue = color;
        this.colorIndex = index;
        this.colorIcon = icon;
      } else {
        this.resetColor();
      }
      this.sendChangeParameters();
    },
    resetColor() {
      this.colorType = '';
      this.colorValue = '';
      this.colorIndex = -1;
      this.colorIcon = '';
    },
    sendChangeParameters() {
      this.$emit('changeParameters', {
        drawValue: this.colorValue,
        drawType: this.colorType,
        location: this.locationType,
        mapSizeX: this.mapSizeX,
        mapSizeY: this.mapSizeY,
      });
    },
    onSelectLocation(location, type, icon) {
      if (this.locationValue !== location) {
        this.locationValue = location;
        this.locationType = type;
        this.locationIcon = icon;
        this.resetColor();
        this.sendChangeParameters();
      }
    },
    calculateMaxHeight() {
      return `calc(100% - 40px - ${this.colorValue !== '' && this.colorType !== '' ? 60 : 0}px - 1rem - ${this.isSettingsOpened ? 223 : 92}px - 8px - 48px)`;
    },
  },
  computed: {
    cssVars() {
      return {
        '--bg-color': this.bgColor,
        '--secondary-color': this.secondaryColor,
        '--logo-title-color': this.logoTitleColor,
        '--icons-color': this.iconsColor,
        '--serach-input-text-color': this.searchInputTextColor,
        '--menu-items-hover-color': this.menuItemsHoverColor,
        '--menu-items-text-color': this.menuItemsTextColor,
        '--menu-footer-text-color': this.menuFooterTextColor,
        overflowX: (this.isLocationMenuOpened ? 'visible' : 'hidden'),
      };
    },
  },
  created() {
    this.$parent.$on('closeMenu', this.close);
  },
};
</script>

<style>
/* Google Font Link */
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap');
@import url('https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css');
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Poppins', sans-serif;
}
body {
  transition: all 0.5s ease;
}
.sidebar {
  display: flex;
  flex-direction: column;
  position: absolute;
  left: 0;
  top: 0;
  height: calc(100% - 40px);
  min-height: min-content;
  /* overflow-y: auto; */
  width: 78px;
  background: var(--bg-color);
  /* padding: 6px 14px 0 14px; */
  transition: all 0.5s ease;
  overflow-x: hidden;
  z-index: 5;
}
.sidebar.open {
  width: 238px;
}
.sidebar .logo-details {
  height: 60px;
  display: flex;
  align-items: center;
  position: relative;
}
.sidebar .logo-details .icon {
  opacity: 0;
  transition: all 0.5s ease;
}
.sidebar .logo-details .logo_name {
  color: var(--logo-title-color);
  font-size: 20px;
  font-weight: 600;
  opacity: 0;
  transition: all 0.5s ease;
}
.sidebar.open .logo-details .icon,
.sidebar.open .logo-details .logo_name {
  opacity: 1;
}
.sidebar .logo-details #btn {
  position: absolute;
  top: 50%;
  right: 0;
  transform: translateY(-50%);
  font-size: 22px;
  transition: all 0.4s ease;
  font-size: 23px;
  text-align: center;
  cursor: pointer;
  transition: all 0.5s ease;
}
.sidebar.open .logo-details #btn {
  text-align: right;
}
.sidebar i {
  color: var(--icons-color);
  height: 60px;
  min-width: 50px;
  font-size: 28px;
  text-align: center;
  line-height: 60px;
}
.sidebar li {
  position: relative;
  margin: 8px 0;
  list-style: none;
}
.sidebar li .menu_item {
  display: flex;
  flex-direction: column;
  height: 100%;
  width: 100%;
  border-radius: 12px;
  align-items: center;
  text-decoration: none;
  transition: all 0.4s ease;
  background: var(--bg-color);
}
.sidebar li .menu_item_not_hover {
  border: 1px solid;
  background: none;
}
.location_info {
  box-shadow: 0 0 6px 6px rgba(54, 171, 255, 0.2);
  /*border: 1px solid;*/
  /*background: var(--bg-color);*/
}
.selected-menu-item,
.sidebar li .menu_item_not_hover:hover,
.sidebar.open li .menu_item_not_hover:hover {
  background: var(--bg-color) !important;
  color: var(--menu-items-text-color) !important;
}
.sidebar li .menu_item_not_hover:hover,
.sidebar.open li .menu_item_not_hover:hover {
  cursor: pointer;
}
.sidebar li .menu_item .menu_item_row {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  align-items: center;
  align-content: center;
  /*justify-content: left;*/
  width: 100%;
  border-radius: 12px;
  color: var(--menu-items-text-color);
}
.sidebar .menu_item .menu_item_content {
  padding: 10px;
  flex-wrap: wrap;
  transition: all 0.5s cubic-bezier(0.51, 0.42, 0, 1.01);
  overflow: hidden;
}
.sidebar li .menu_item .links_name {
  color: var(--menu-items-text-color);
  font-size: 15px;
  font-weight: 400;
  white-space: nowrap;
  opacity: 0;
  pointer-events: none;
  transition: 0.4s;
}
.sidebar.open li .menu_item .links_name {
  opacity: 1;
  pointer-events: auto;
}
.sidebar li i {
  height: 40px;
  line-height: 40px;
  font-size: 18px;
  border-radius: 12px;
}
.sidebar div.exit {
  position: relative;
  min-height: 60px;
  width: 78px;
  /* left: 0;
  bottom: 0; */
  padding: 14px 23px;
  transition: all 0.5s ease;
  overflow: hidden;
}
.sidebar div.secondaryColor,
.sidebar div i.secondaryColor  {
  background: var(--secondary-color);
}

.sidebar.open div.exit {
  width: 238px;
}
.sidebar div img {
  height: 45px;
  width: 45px;
  object-fit: cover;
  border-radius: 6px;
  margin-right: 10px;
}
.sidebar .exit .exit_menu_item {
  z-index: 1;
  line-height: 2rem;
}
.sidebar .exit .exit_menu_item::before {
  background: rgba(0, 0, 0, 0.6);
  border-radius: 2px;
}
.sidebar .exit i {
  position: absolute;
  top: 50%;
  left: 0;
  transform: translateY(-50%);
  width: 100%;
  height: 100%;
  line-height: 60px;
  transition: all 0.5s ease;
  min-width: 32px;
}
.sidebar .exit #log_out,
.sidebar.open .exit #log_out {
  width: 28px;
  margin: 0 25px 0 20px;
  color: rgba(255,255,255,1);
  transition: all .3s ease-in-out;

  background: linear-gradient(to right, rgba(155, 23, 4, 0.99), rgba(255, 115, 0, 1));
  background-size: 100%;
  animation: color-change 0.3s;
  animation-fill-mode: forwards;
  background-clip: text;
  -webkit-background-clip: text;
  line-height: 40px;
}
.sidebar.open .exit #log_out {
  margin: 0 16px;
  opacity: 0.5;
}
.sidebar.open .exit #log_out:hover,
.sidebar.open .exit:hover #log_out {
  opacity: 1;
}
.sidebar.open .exit:hover #log_out,
.sidebar .exit:hover #log_out {
  color:rgba(255,255,255,0);
}
@keyframes color-change {
  0%{background-position:left}
  100%{background-position:right}
}
#my-scroll {
  overflow: scroll;
  transition: all 0.5s cubic-bezier(0.51, 0.42, 0, 1.01);
  margin-right: 4px;
  padding-right: 4px;
}
#my-scroll::-webkit-scrollbar{
  display: block;
  width: 6px;
  height: 0;
}
.ceil_item {
  height: 32px;
  width: 32px;
  margin: 0 5px 5px 0;
  border-radius: 5px;
  cursor: pointer;
  transition: all 0.3s ease;
}
.ceil_item_selected {
  transform: scale(1.15);
  box-shadow: 0 0 6px 6px rgba(54, 171, 255, 0.2);
}
.locationSelected:before,
.ceil_item_selected:before {
  content: "\ec9b";
  position: absolute;
  top: -3.5px;
  right: -3.5px;
  font-size: 9px;
  color: rgb(225, 33, 33);
  animation: scaling 2s cubic-bezier(0.4, 0, 1, 1) infinite alternate;
}
@keyframes scaling {
  0%   { transform: scale(1); opacity: 0.8 }
  100% { transform: scale(1.3); opacity: 1 }
}
.menu_item_closed {
  max-height: 0 !important;
  padding: 0 12px !important;
}
.settings {
  width: 100%;
  display: flex;
  flex-direction: column;
}
.settings p,
.settings-locations p {
  margin: 0;
  font-size: 10px;
  margin: 5px 0px 1px 0px;
}
.settings-locations {
  font-size: 24px !important;
  position: absolute;
  right: 10px;
}
.settings-locations-icon {
  animation: scaling 0.8s cubic-bezier(0.4, 0, 1, 1) infinite alternate;
}
@keyframes scaling {
  0%   { transform: scale(1); }
  100% { transform: scale(1.4); }
}
.locationSelected {
  box-shadow: 0 0 6px 6px rgb(54 171 255 / 20%);
  background: rgba(17, 16, 29, 0.85);
}
.locationMenu {
  background: var(--bg-color);
  border-color: var(--bg-color);
  color: #fff;
  border-radius: 12px;
  height: fit-content;
  max-height: 300px;
  width: max-content;
  position: absolute;
  left: calc(100% + 29px);
  top: -10px;
  transition: all 0.3s ease;
  display: flex;
  flex-direction: column;
  z-index: -1;
}
.locationMenu span {
  display: flex;
  flex-direction: row;
  align-items: center;
  border-radius: 7px;
  margin-bottom: 5px;
  transition: all 0.4s ease;
  border: 1px solid;
  border-color: #212529;
  padding: 0 10px 0 0;
  position: relative;
}
.locationMenu span:hover {
  background: var(--bg-color);
  border-color: #F5F5F5;
  cursor: pointer;
}
.locationMenu p {
  margin: 0;
  font-size: 15px;
}
.locationMenu div::-webkit-scrollbar {
  display: block !important;
}
.locationMenuClosed {
  left: calc(100% + 14px);
  opacity: 0;
}
.locationMenu::after {
  content: "";
  position: absolute;
  height: 0;
  width: 0;
  top: 17px;
  left: 0;
  transform: translate(-100%, 0);
  border-color: rgba(0, 0, 0, 0);
  border-style: solid;
  border-width: 8px;
  border-right-color: inherit;
}

.my-settings {
  margin: 0px 14px;
}
</style>
