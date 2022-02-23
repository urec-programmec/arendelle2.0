<template>
  <div class="sidebar"
    :class="isOpened ? 'open' : ''"
    :style="cssVars">
    <div class="logo-details"
      style="margin: 6px 14px 0 14px;">
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

    <div style="display: flex ; flex-direction:column; justify-content: space-between; flex-grow: 1; max-height: calc(100% - 60px); ">
      <div id="my-scroll"
        style="margin: 6px 14px 0 14px;">
        <ul class="nav-list"
          style="overflow: visible;">
          <span v-for="(menuItem, menuIndex) in menuItems"
                :key="menuIndex">
            <li>
              <div class="menu_item">
                <div class="menu_item_row menu_item_title"
                      @click="() => {isOpened = true; menuItem.isOpen = !menuItem.isOpen}">
                  <i class="bx" :class="menuItem.icon"/>
                  <span class="links_name">{{ menuItem.name }}</span>
                </div>
                <div :class="['menu_item_row', 'menu_item_content', {'menu_item_closed': !isOpened || !menuItem.isOpen}]"
                     :style="{ maxHeight: (37 * Math.ceil(menuItem.childs.length / 5) + 32) + 'px' }">
                  <div v-for="(item, itemIndex) in menuItem.childs"
                       :key="itemIndex"
                       :style="{'background-image': `url(${require('../assets/' + menuItem.type + '/' + item)})`,
                                'background-repeat': 'no-repeat',
                                'background-size': 'cover'}"
                       :class="['ceil_item', 'bx', { 'ceil_item_selected': colorType === menuItem.type && colorValue === item && colorIndex === itemIndex }]"
                       @click="changeColor(menuItem.type, item, itemIndex, menuItem.icon)"/>
                </div>
              </div>
            </li>
          </span>
        </ul>
      </div>

      <div class="exit"
          v-if="colorValue !== '' && colorType !== ''">
        <li style="height: 100%; width: 100%; margin: 0;">
          <i class="bx" :class="[colorIcon, 'exit_menu_item']"/>
          <i class="bx" :style="{'background-image': `url(${require('../assets/' + colorType + '/' + colorValue)})`,
                                 borderRadius: '6px',
                                 boxShadow: '0 0 6px 6px rgba(54, 171, 255, 0.2)'}"/>
        </li>
      </div>
      <div class="exit secondaryColor">
        <i v-if="isExitButton"
          class="bx bx-log-out secondaryColor"
          id="log_out"
          @click.stop="$emit('button-exit-clicked')"/>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Menu',
  data() {
    return {
      isOpened: false,
      colorType: '',
      colorValue: '',
      colorIndex: -1,
      colorIcon: '',
      img: '../assets/waves.png',
    };
  },
  props: {
    //! Menu settings
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
          childs: ['1.png', '2.png'],
          isOpen: false,
        },
        {
          name: 'стены',
          icon: 'bx-border-radius',
          type: 'border',
          childs: ['1.png', '2.png', '3.gif', '4.gif', '5.png', '6.png', '7.png', '8.jpeg', '9.jpeg'],
          isOpen: false,
        },
        {
          name: 'переходы',
          icon: 'bx-trip',
          type: 'trip',
          childs: ['1.png'],
          isOpen: false,
        },
        {
          name: 'специальные места',
          icon: 'bxs-flag-alt',
          type: 'special',
          childs: ['1.jpeg', '2.jpeg', '3.jpeg', '4.jpeg', '5.jpeg', '6.jpeg'],
          isOpen: false,
        },
      ],
    },
    isExitButton: {
      type: Boolean,
      default: true,
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
    homeSectionColor: {
      type: String,
      default: '#e4e9f7',
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
  },
  methods: {
    openCloseMenu() {
      if (this.isOpened) {
        for (let i of this.menuItems) {
          i['isOpen'] = false;
        }
      }
      this.isOpened = !this.isOpened;
    },
    changeColor(type, color, index, icon) {
      if (!(this.colorType === type && this.colorValue === color && this.colorIndex === index)) {
        this.colorType = type;
        this.colorValue = color;
        this.colorIndex = index;
        this.colorIcon = icon;
      } else {
        this.colorType = '';
        this.colorValue = '';
        this.colorIndex = -1;
        this.colorIcon = '';
      }
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
      };
    },
    styles() {
      return {
        'background-image': `url(${this.img})`,
        'background-repeat': 'no-repeat',
        'background-size': 'cover'
      }
    }
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
.sidebar .nav-list {
  margin-top: 20px;
  /* margin-bottom: 60px; */
  /* height: 100%; */
  /* min-height: min-content; */
}
.sidebar li {
  position: relative;
  margin: 8px 0;
  list-style: none;
}
.sidebar input {
  font-size: 15px;
  color: var(--serach-input-text-color);
  font-weight: 400;
  outline: none;
  height: 50px;
  width: 100%;
  width: 50px;
  border: none;
  border-radius: 12px;
  transition: all 0.5s ease;
  background: var(--secondary-color);
}
.sidebar.open input {
  padding: 0 20px 0 50px;
  width: 100%;
}
.sidebar .bx-search {
  position: absolute;
  top: 50%;
  left: 0;
  transform: translateY(-50%);
  font-size: 22px;
  background: var(--secondary-color);
  color: var(--icons-color);
}
.sidebar.open .bx-search:hover {
  background: var(--secondary-color);
  color: var(--icons-color);
}
.sidebar .bx-search:hover {
  background: var(--menu-items-hover-color);
  color: var(--bg-color);
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
.sidebar li .menu_item .menu_item_row {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: left;
  width: 100%;
  border-radius: 12px;
}
.sidebar li .menu_item .menu_item_content {
  padding: 12px;
  flex-wrap: wrap;
  transition: all 0.5s cubic-bezier(0.51, 0.42, 0, 1.01);
  overflow: hidden;
}
.sidebar li .menu_item .menu_item_title:hover {
  background: var(--menu-items-hover-color);
  cursor: pointer;
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
.sidebar li .menu_item .menu_item_title:hover .links_name,
.sidebar li .menu_item .menu_item_title:hover i {
  transition: all 0.5s ease;
  color: var(--bg-color);
}
.sidebar li i {
  height: 50px;
  line-height: 50px;
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
.sidebar.open .exit #log_out {
  width: 50px;
  background: var(--secondary-color);
  opacity: 0.5;
}
.sidebar.open .exit:hover #log_out {
  opacity: 1;
}
.sidebar.open .exit #log_out:hover {
  opacity: 1;
  color: red;
}
.sidebar .exit #log_out:hover {
  color: red;
}
#my-scroll {
  overflow-y: auto;
  height: calc(100% - 60px);
}
#my-scroll::-webkit-scrollbar{
  display:none;
}
.ceil_item {
  height: 32px;
  width: 32px;
  margin: 0 5px 5px 0;
  border-radius: 5px;
  cursor: pointer;
}
.ceil_item_selected {
  transform: scale(1.2);
  box-shadow: 0 0 6px 6px rgba(54, 171, 255, 0.2);
}
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
</style>
