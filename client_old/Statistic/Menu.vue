<template>
  <div class="sidebar"
       :class="isOpened ? 'open' : ''"
       :style="cssVars"
       @click="mainClick">
    <div class="logo-details"
      style="margin: 0 14px">
      <div class="bx icon" :style="{ background: userBackground, '--content': userInitials }"/>
      <div class="logo_name" :style="{ fontSize: ((235 / menuTitle.length) > 20 ? 20 : (235 / menuTitle.length)) + 'px' }">
        {{ menuTitle }}
      </div>
      <i class="bx"
        :class="isOpened ? 'bx-menu-alt-right' : 'bx-menu'"
        id="btn"
        @click="openCloseMenu"/>
    </div>

    <div :style="{ 'height': 'calc(100% - 60px)' }">
      <div class="exit secondaryColor"
          style="min-height: 40px; position: absolute; bottom: 0;">
        <i class="bx bx-log-out secondaryColor"
          id="log_out"
          @click.stop="$emit('exit')"/>
      </div>
    </div>
  </div>
</template>

<script>
import '../../client/src/assets/css/exit.css'

export default {
  name: 'Menu',
  data () {
    return {
      menuTitle: 'статистика',
      isOpened: false,
      userBackground: 'wheat',
      userInitials: '',

      colorType: '',
      colorValue: '',
      colorIndex: -1,
      colorIcon: '',

      mapSizeX: 50,
      mapSizeY: 50,
      isResizing: false,
      name: '',

      taskCount: 10,
      isLocationIconHover: false,
      isLocationMenuOpened: false,
      isLocationMenuOpenedAsync: false,
      isSettingsOpened: false
    }
  },
  props: {
    //! Menu settings
    defaultName: {
      type: String,
      default: 'новая задача'
    },
    isMenuOpen: {
      type: Boolean,
      default: false
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
          isOpen: false
        },
        {
          name: 'стены',
          icon: 'bx-border-radius',
          type: 'border',
          childs: [],
          isOpen: false
        },
        {
          name: 'переходы',
          icon: 'bx-trip',
          type: 'trip',
          childs: [],
          isOpen: false
        }
      ]
    },

    bgColor: {
      type: String,
      default: 'rgba(17, 16, 29, 0.85)'
    },
    secondaryColor: {
      type: String,
      default: 'hsl(210, 70%, 15%)'
    },
    logoTitleColor: {
      type: String,
      default: '#fff'
    },
    iconsColor: {
      type: String,
      default: '#fff'
    },
    searchInputTextColor: {
      type: String,
      default: '#fff'
    },
    menuItemsHoverColor: {
      type: String,
      default: '#fff'
    },
    menuItemsTextColor: {
      type: String,
      default: '#fff'
    },
    menuFooterTextColor: {
      type: String,
      default: '#fff'
    }
  },
  mounted () {
    this.isOpened = this.isMenuOpen
    this.menuTitle = JSON.parse(localStorage.getItem('user')).nickname
  },
  methods: {
    mainClick () {
      if (this.isLocationMenuOpened) {
        this.isLocationMenuOpenedAsync = false
        this.closeLocationMenuAsync()
      }
    },
    stopPropagation (event) {
      event.stopPropagation()
    },
    close () {
      if (this.isOpened) {
        this.openCloseMenu()
      }
    },
    initMapSize (data) {
      this.mapSizeX = data['sizeX']
      this.mapSizeY = data['sizeY']
    },
    openSettingsMenu () {
      if (!this.isOpened) {
        setTimeout(() => {
          this.isOpened = true
        }, 0)
      }
      this.isSettingsOpened = !this.isSettingsOpened
    },
    openLocationMenu (event) {
      if (this.isOpened) {
        this.isLocationMenuOpenedAsync = !this.isLocationMenuOpenedAsync
        if (this.isLocationMenuOpened) {
          this.closeLocationMenuAsync()
        } else {
          this.isLocationMenuOpened = true
        }
      } else {
        this.isOpened = true
        this.isLocationMenuOpened = true
        this.isLocationMenuOpenedAsync = true
      }
      event.stopPropagation()
    },
    closeLocationMenuAsync () {
      setTimeout(() => { this.isLocationMenuOpened = this.isLocationMenuOpenedAsync }, 300)
    },
    openCloseMenu () {
      if (this.isOpened) {
        for (let i of this.menuItems) {
          i['isOpen'] = false
        }
        this.isLocationMenuOpened = false
        this.isLocationMenuOpenedAsync = false
        this.isSettingsOpened = false
      }
      this.isOpened = !this.isOpened
      this.$emit('openCloseMenu', { isOpen: this.isOpened })
    },
    changeName () {
      if (this.name === '') {
        this.name = this.defaultName
      }
      this.$emit('changeMapName', { newMapName: this.name })
    },
    changeColor (type, color, index, icon) {
      if (!(this.colorType === type && this.colorValue === color && this.colorIndex === index)) {
        this.colorType = type
        this.colorValue = color
        this.colorIndex = index
        this.colorIcon = icon
      } else {
        this.resetColor()
      }
      this.sendChangeParameters()
    },
    resetColor () {
      this.colorType = ''
      this.colorValue = ''
      this.colorIndex = -1
      this.colorIcon = ''
    },
    sendChangeParameters () {
      this.$emit('changeParameters', {
        drawValue: this.colorValue,
        drawType: this.colorType,
        location: this.locationType,
        locationText: this.locationValue,
        mapSizeX: this.mapSizeX,
        mapSizeY: this.mapSizeY,
        taskCount: this.taskCount
      })
    },
    onSelectLocation (location, type, icon) {
      if (this.locationValue !== location) {
        this.locationValue = location
        this.locationType = type
        this.locationIcon = icon
        this.resetColor()
        this.sendChangeParameters()
      }
    },
    calculateMaxHeight () {
      return `calc(100% - 40px - ${this.colorValue !== '' && this.colorType !== '' ? 60 : 0}px - 1rem - ${this.isSettingsOpened ? 223 : 92}px - 8px - 48px)`
    }
  },
  computed: {
    cssVars () {
      return {
        '--bg-color': this.bgColor,
        '--secondary-color': this.secondaryColor,
        '--logo-title-color': this.logoTitleColor,
        '--icons-color': this.iconsColor,
        '--serach-input-text-color': this.searchInputTextColor,
        '--menu-items-hover-color': this.menuItemsHoverColor,
        '--menu-items-text-color': this.menuItemsTextColor,
        '--menu-footer-text-color': this.menuFooterTextColor
        // overflowX: (this.isLocationMenuOpened ? 'visible' : 'hidden'),
      }
    }
  },
  created () {
    this.$parent.$on('closeMenu', this.close)
    this.$parent.$on('initMapSize', this.initMapSize)
    let user = JSON.parse(localStorage.getItem('user'))
    this.userBackground = user.color
    this.userInitials = '\''.concat(user.name[0], user.surname[0], '\'').toUpperCase()
  }
}
</script>

<style scoped>
/* Google Font Link */
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap');
@import url('https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css');
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}
body {
  transition: all 0.2s ease;
}
.sidebar {
  display: flex;
  flex-direction: column;
  position: absolute;
  left: 0;
  top: 0;
  height: 100%;
  min-height: min-content;
  /* overflow-y: auto; */
  width: 78px;
  background: var(--bg-color);
  /* padding: 6px 14px 0 14px; */
  transition: all 0.2s ease;
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
.sidebar.open .logo-details .icon {
  width: 40px;
  height: 40px;
  margin: 0 5px;
  border-radius: 20px;
  position: relative;
}
.sidebar.open .logo-details .icon:before {
  content: var(--content);
  font-family: "GothamPro", sans-serif;
  color: #F5F5F5;
  position: absolute;
  display: block;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
}
.sidebar .logo-details .icon {
  opacity: 0;
  transition: all 0.5s ease;
}
.sidebar .logo-details .logo_name {
  background: inherit;
  border: none;
  color: var(--logo-title-color);
  font-size: 20px;
  font-weight: 600;
  opacity: 0;width: calc(100% - 83px);
  white-space: nowrap;
  overflow: hidden;
  transition: all 0.2s ease;
  border-radius: 0.25rem;
}
.sidebar .logo-details .logo_name:focus {
  position: absolute;
  left: 33px;
  transform: scale(1.2);
  width: 300px;
  background: rgba(17, 16, 29, 0.85);
  z-index: 10;
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
  transition: all 0.2s ease;
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
  transition: all 0.2s cubic-bezier(0.51, 0.42, 0, 1.01);
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
.sidebar div.secondaryColor,
.sidebar div i.secondaryColor  {
  background: var(--secondary-color);
}
.sidebar div img {
  height: 45px;
  width: 45px;
  object-fit: cover;
  border-radius: 6px;
  margin-right: 10px;
}
#my-scroll {
  overflow: scroll;
  transition: all 0.2s cubic-bezier(0.51, 0.42, 0, 1.01);
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
