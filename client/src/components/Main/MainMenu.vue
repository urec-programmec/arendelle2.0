<template>
  <div class="sidebar"
       :class="isOpen ? 'open' : ''"
       :style="cssVars">
    <div class="logo-details"
         style="margin: 0 14px">
      <div class="bx icon" :style="{ background: userBackground, '--content': userInitials }"/>
      <div class="logo_name" :style="{ fontSize: ((235 / menuTitle.length) > 20 ? 20 : (235 / menuTitle.length)) + 'px' }">
        {{ menuTitle }}
      </div>
      <i class="bx"
         :class="isOpen ? 'bx-menu-alt-right' : 'bx-menu'"
         id="btn"
         @click="openCloseMenu"/>
    </div>

    <div :style="{ 'height': 'calc(100% - 60px)' }">
      <div id="my-scroll"
           class="my-settings">
        <ul>
            <span v-for="(menuItem, menuIndex) in menuItems"
                  :key="menuIndex"
                  v-if="menuItem.availableFor.includes(userRole)">
              <li>
                <div :class="['menu_item', 'menu_item_not_hover', { 'selected-menu-item': openedItem === menuItem.id }]">
                  <div class="menu_item_row"
                       @click="openCloseMenuItem(menuItem.id)">
                    <i class="bx" :class="menuItem.icon"/>
                    <span class="links_name">{{ menuItem.name }}</span>
                    <span :class="['bx', 'links_name', 'settings-item',
                    openedItem === menuItem.id ? 'bxs-right-arrow-alt' : 'bx-chevron-right',
                    { 'settings-item-open': isOpen && openedItem === menuItem.id },
                    { 'settings-item-hover': isOpen }]"/>
                  </div>
                </div>
              </li>
            </span>
        </ul>
      </div>
      <div class="exit secondaryColor"
           style="min-height: 40px; position: absolute; bottom: 0;">
        <i class="bx bx-log-out secondaryColor"
           id="log_out"
           @click.stop="$emit('logout')"/>
      </div>
    </div>
  </div>
</template>

<script>
import 'vue-slider-component/theme/antd.css';
import VueSlider from 'vue-slider-component';

import '../../assets/css/custom-dot.css';
import '../../assets/css/exit.css';

export default {
  name: 'MainMenu',
  components: { 'vue-slider': VueSlider },
  data() {
    return {
      isOpen: false,
      openedItem: '',
    };
  },
  methods: {
    close() {
      if (this.isOpen) {
        this.openCloseMenu();
      }
    },
    changeTab(data) {
      this.openedItem = data.tab;
      for (let i of this.menuItems) {
        if (i['id'] === this.openedItem) {
          document.title = i['name'].charAt(0).toUpperCase() + i['name'].slice(1);
        }
      }
    },
    openCloseMenu() {
      if (this.isOpen) {
        for (let i of this.menuItems) {
          // i['isOpen'] = false;
          i['isHover'] = false;
        }
      }
      this.isOpen = !this.isOpen;
      this.$emit('openCloseMenu', { isOpen: this.isOpen });
    },
    openCloseMenuItem(id) {
      this.isOpen = true;
      for (let i of this.menuItems) {
        i['isOpen'] = false;
        if (i['id'] === id) {
          document.title = i['name'].charAt(0).toUpperCase() + i['name'].slice(1);
        }
      }
      this.openedItem = id;
      this.sendChangeTab();
    },
    sendChangeTab() {
      this.$router.replace({ path: this.openedItem }).catch(() => {});
      this.$emit('changeTab', { 'tab': this.openedItem });
    },
  },
  props: {
    menuTitle: {
      type: String,
      default: 'меню',
    },
    userBackground: {
      type: String,
      default: 'wheat',
    },
    userInitials: {
      type: String,
      default: '',
    },
    userRole: {
      type: Number,
      default: 0,
    },
    //! Menu items
    menuItems: {
      type: Array,
      default: () => [
        {
          name: 'профиль',
          icon: 'bxs-id-card',
          id: 'profile',
          availableFor: [1, 2, 3],
        },
        {
          name: 'чемпионаты',
          icon: 'bxs-bar-chart-alt-2',
          id: 'championships',
          availableFor: [1, 2, 3],
        },
        {
          name: 'шаблоны карт',
          icon: 'bxs-image',
          id: 'maps',
          availableFor: [2, 3],
        },
        {
          name: 'задачи',
          icon: 'bx-task',
          id: 'tasks',
          availableFor: [2, 3],
        },
        {
          name: 'пользователи',
          icon: 'bxs-user',
          id: 'users',
          availableFor: [2, 3],
        },
        {
          name: 'команды',
          icon: 'bxs-group',
          id: 'teams',
          availableFor: [1],
        },
        {
          name: 'уведомления',
          icon: 'bxs-bell',
          id: 'notifications',
          availableFor: [1, 2, 3],
        },
      ],
    },
    bgColor: {
      type: String,
      default: 'rgba(17, 16, 29, 0.85)',
    },
    menuItemsTextColor: {
      type: String,
      default: '#F5F5F5',
    },
  },
  computed: {
    cssVars() {
      return {
        '--bg-color': this.bgColor,
        '--menu-items-text-color': this.menuItemsTextColor,
      };
    },
  },
  created() {
    this.$parent.$on('closeMenu', this.close);
    this.$parent.$on('changeTab', this.changeTab);
  },
};
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
  transition: all 0.5s ease;
}
.sidebar {
  display: flex;
  flex-direction: column;
  position: absolute;
  left: 0;
  top: 0;
  height: 100%;
  min-height: min-content;
  width: 78px;
  background: var(--bg-color);
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
  color: #F5F5F5;
  font-weight: 600;
  opacity: 0;
  transition: all 0.5s ease;
  white-space: nowrap;
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
  color: #F5F5F5;
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
  width: 100%;
  border-radius: 12px;
  color: var(--menu-items-text-color);
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
.sidebar div img {
  height: 45px;
  width: 45px;
  object-fit: cover;
  border-radius: 6px;
  margin-right: 10px;
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
.settings-item {
  font-size: 24px !important;
  position: absolute;
  right: 10px;
  opacity: 0 !important;
}
.menu_item:hover .settings-item {
  animation: scaling 0.8s cubic-bezier(0.4, 0, 1, 1) infinite alternate;
}
.menu_item:hover .settings-item-hover,
.settings-item-open {
 opacity: 1 !important;
}
@keyframes scaling {
  0%   { transform: scale(1); }
  100% { transform: scale(1.4); }
}
.my-settings {
  margin: 0px 14px;
}
.secondaryColor {
  background: hsl(210, 70%, 15%);
}
</style>
