<template>
  <main id="dairMap-main" @click="globalClick">
    <div class="background" :style="{ '--background-before-url': backgroundImage}"></div>
    <instrument-panel v-if="selectedGlobalAction.id === 1 && selectedGlobalSubAction1.id === 1" @changeParameters="changeCursorParameters"
                      :type="'places'"
                      :w="275"/>
    <instrument-panel v-if="selectedGlobalAction.id === 1 && selectedGlobalSubAction1.id === 2" @changeParameters="changeCursorParameters"
                      :type="'dairs'"/>
    <span v-if="showMenu" class="footer top-panel">
      <div v-for="(action, index) in globalActions"
           :style="{'background-image': action.url, 'height': '30px'}"
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
    <span class="footer top-panel sub-top-panel" v-if="selectedGlobalAction.id === 2 && showMenu">
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
    <span class="footer top-panel sub-top-panel" v-if="selectedGlobalAction.id === 3 && showMenu">
      <div v-for="(subAction3, index) in globalSubActions3"
         :style="{'background-image': dairs[subAction3.id].url,
                    '--first-color': '2px solid ' + dairs[subAction3.id].color,
                    '--second-color': '0 0 0 5px ' + dairs[subAction3.id].colorSecond}"
         :key="index" :class="['top-panel-item', 'top-panel-item-sub-actions-3', subAction3.id === selectedGlobalSubAction3.id ? 'top-panel-item-sub-actions-3-selected' : subAction3.id === preSelectedGlobalSubAction3.id ? 'top-panel-item-sub-actions-3-pre-selected' : '' ]"
         @mouseover="preSelectedGlobalSubAction3 = subAction3" @mouseleave="preSelectedGlobalSubAction3 = {}" @click="selectGlobalSubAction3">
        <p>{{ dairs[subAction3.id].name }}</p>
      </div>
    </span>
    <span class="footer top-panel sub-top-panel" v-if="selectedGlobalAction.id === 4 && showMenu">
      <div :style="{'background-image': globalSubActions4[1].url,
                      '--first-color': '2px solid #ff4900',
                      '--second-color': '0 0 0 5px rgba(255,114,24,0.26)'}"
           :class="['top-panel-item', 'top-panel-item-sub-actions-4', globalSubActions4[1].id === selectedGlobalSubAction4.id ? 'top-panel-item-sub-actions-4-selected' : globalSubActions4[1].id === preSelectedGlobalSubAction4.id ? 'top-panel-item-sub-actions-4-pre-selected' : '' ]"
           @mouseover="preSelectedGlobalSubAction4 = globalSubActions4[1]" @mouseleave="preSelectedGlobalSubAction4 = {}" @click="selectGlobalSubAction4">
          <p>{{ globalSubActions4[1].name }}</p>
      </div>
      <i class='bx bx-minus bx-rotate-90' style="margin: 0 5px 0 5px !important; font-size: 1.8em"/>
      <div class="top-panel-container">
        <div v-for="(subAction4, index) in globalSubActions4" v-if="subAction4.id !== 0"
             :style="{'background-image': dairs[subAction4.id].url,
                      '--first-color': '2px solid ' + dairs[subAction4.id].color,
                      '--second-color': '0 0 0 5px ' + dairs[subAction4.id].colorSecond}"
             :key="index" :class="['top-panel-item', 'top-panel-item-sub-actions-4', subAction4.id === selectedGlobalSubAction4.id ? 'top-panel-item-sub-actions-4-selected' : subAction4.id === preSelectedGlobalSubAction4.id ? 'top-panel-item-sub-actions-3-pre-selected' : '' ]"
             @mouseover="preSelectedGlobalSubAction4 = subAction4" @mouseleave="preSelectedGlobalSubAction4 = {}" @click="selectGlobalSubAction4">
          <p>{{ dairs[subAction4.id].name }}</p>
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
      <div v-if="selectedGlobalAction.id === 3" class= "footerResources">
        <div v-for="(resource, index) in selectedDair.resources" :key="index" style="margin-left: 25px">
           <div :style="{ 'display': 'flex', 'align-items': 'center' }">
            <i :class="['bx', resourcesTypes[index].i]" style="font-size: 1.2em"/>
            <div style="font-size: 0.85em; margin-right: 0.5em">{{resourcesTypes[index].name + ':'}}</div>
            <div :style="{ 'font-size': '0.9em', 'color' : selectedDair.resources[index] === 0 ? '#ff4242' : '' }">{{selectedDair.resources[index]}}</div>
          </div>
        </div>
      </div>
      <div v-if="selectedGlobalAction.id === 2" class= "footerResources">
         <div class="footerResourcesSettings" @click="nextPeriodPanelOpen">
          <i :class="['bx', 'bx-download', 'bx-rotate-270']" style="font-size: 1.2em; margin-left: 0; color: inherit"/>
          <div style="color: inherit">Следующий период</div>
        </div>
        <div class="footerResourcesSettings" @click="marketPanelOpen">
          <i :class="['bx', 'bx-transfer']" style="font-size: 1.2em; margin-left: 0; color: inherit"/>
          <div style="color: inherit">Торговля</div>
        </div>
        <div class="footerResourcesSettings" @click="loadResourcesPanelOpen">
          <i :class="['bx', 'bx-download']" style="font-size: 1.2em; margin-left: 0; color: inherit"/>
          <div style="color: inherit">Ввод/вывод ресурсов</div>
        </div>
      </div>
      <div v-if="selectedGlobalAction.id === 4 && selectedGlobalSubAction4.id !== 0" class= "footerResources">
         <div class="footerResourcesSettings" @click="showMapChange">
          <i :class="['bx', showMap ? 'bx-notification-off' : 'bx-notification']" style="font-size: 1.2em; margin-left: 0; color: inherit"/>
          <div style="color: inherit">{{ showMap ? 'Отключить элементы карты' : 'Включить элементы карты' }}</div>
        </div>
         <div v-if="showMenu" class="footerResourcesSettings" @click="businessPanelOpen">
          <i :class="['bx', 'bx-receipt']" style="font-size: 1.2em; margin-left: 0; color: inherit"/>
          <div style="color: inherit">Договоры</div>
        </div>
      </div>
      <vue-slider v-model="dairZoom"
                  :tooltip-formatter="val => (Math.round((val / minDairZoom) * 10) / 10) + 'x'"
                  :min="minDairZoom"
                  :max="maxDairZoom"
                  :style="{margin: '0',
                           width: '320px'}"
                  @drag-start="() => isResizing = true"
                  @drag-end="() => {isResizing = false; drawCanvas(true);}"
                  @change="() => {if(!isResizing) drawCanvas(true)}">
        <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
          <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ Math.round((value / minDairZoom) * 10) / 10 }}</div>
        </template>
      </vue-slider>
      <div v-if="showMenu" :style="{ display: 'flex',
                     flexDirection: 'column',
                     'margin-left': '15px'}">
        <div class="footerResourcesMap" @click="downloadMap">
          <p style="font-size: 0.8em; margin-bottom: 2px; margin-left: 0; width: fit-content">карта</p>
          <i :class="['bx', 'bxs-download']" style="font-size: 1.2em; color: inherit"/>
        </div>
      </div>
      <div v-if="selectedGlobalAction.id === 4 && selectedGlobalSubAction4.id !== 0 || selectedGlobalAction.id === 3" :style="{ display: 'flex',
                     flexDirection: 'column',
                     'margin-left': showMenu ? '' : '15px'}">
        <div class="footerResourcesMap" @click="changeShowMenu">
          <p style="font-size: 0.8em; margin-bottom: 2px; margin-left: 0; width: fit-content">{{ showMenu ? 'дэир' : '' }}</p>
          <i :class="['bx', showMenu ? 'bx-landscape' : 'bx-cog']" :style="{ 'font-size': '1.2em', 'color': 'inherit', 'margin': showMenu ? '0 10px' : '0 5px' }"/>
        </div>
      </div>
      <div :style="{ display: 'flex',
                     flexDirection: 'column'}">
        <p style="font-size: 0.8em; margin-bottom: 5px">размеры</p>
        <p style="font-size: 1em">{{ dairSizeX }}:{{ dairSizeY }}</p>
      </div>
      <div :style="{ display: 'flex',
                     flexDirection: 'column'}">
        <p style="font-size: 0.8em; margin-bottom: 5px">период</p>
        <p style="font-size: 1em">{{ period }}</p>
      </div>
      <div :style="{ display: 'flex',
                     flexDirection: 'column'}">
        <p style="font-size: 0.8em; margin-bottom: 5px">ячейка</p>
        <p style="font-size: 1em">{{ (cursorPositionX === -1 && cursorPositionY === -1) ? '—' : dairLetterPositions[cursorPositionY] + ':' + (cursorPositionX + 1) }}</p>
      </div>
    </span>
    <div id="itemMenu" :style="{ 'opacity' : itemMenu.visible ? '1' : '0', 'right' : itemMenu.visible ? '30px' : '-300px',
                      'overflow': collapsedMenu ? 'hidden' : 'scroll',
                      'width' : collapsedMenu ? '60px' : '320px',
                      'max-height': showMenu ? 'calc(100% - 240px)' : 'calc(100% - 100px)',
                      'height': 'fit-content',
                      'min-height': '31px',
                      '--first-color': isEmpty(itemMenu.owner) ? '2px solid rgba(0, 0, 0, 0)' : '2px solid ' + itemMenu.owner.color,
                      '--second-color': isEmpty(itemMenu.owner) ? '' : '0 0 0 5px ' + itemMenu.owner.colorSecond }" @click="stopPropagation">
      <i @click="unselectMenuAction" class='bx bx-x close' style="margin: 0 5px 0 5px !important; font-size: 1.1em; transform: scale(1.4); position: absolute; right: 0;"/>
      <i @click="collapseMenu" :class="['bx', collapsedMenu ? 'bx-window' : 'bx-windows', 'close']" style="margin: 0 5px 0 5px !important; font-size: 1.1em; position: absolute; right: 1.3em;"/>
      <p style="margin-bottom: 1.5em;" v-if="!collapsedMenu">ячейка {{ itemMenu.visible ? itemMenu.text : '' }}</p>

      <div class="itemMenuInfo" v-if="!hasMonsterCreateAccess && !collapsedMenu">
        <div class="title" style="margin-bottom: 0" v-if="hasScoutAccess">{{ getScoutAccess.length > 1 ? 'Разведчики' : 'Разведчик' }}</div>
        <div class="monster" :style="{ backgroundImage: `url(${require('../assets/images/units/scout.png')})` }" v-if="hasScoutAccess"/>
        <div class="place" v-if="hasScoutAccess"/>

        <div class="title" style="margin-bottom: 0" v-if="hasWarriorAccess">Воин</div>
        <div class="monster" :style="{ backgroundImage: `url(${require('../assets/images/units/warrior.png')})` }" v-if="hasWarriorAccess"/>
        <div class="place" v-if="hasWarriorAccess"/>

        <div class="title" style="margin-bottom: 0" v-if="hasKnightAccess">Князь</div>
        <div class="monster" :style="{ backgroundImage: `url(${require('../assets/images/units/knight.png')})` }" v-if="hasKnightAccess"/>
        <div class="place" v-if="hasKnightAccess"/>

        <div class="title" style="margin-bottom: 0" v-if="hasMonsterAccess">{{ monsterTypes[itemMenu.monster.type].name }}</div>
        <div class="monster" :style="{ backgroundImage: monsterTypes[itemMenu.monster.type].url }" v-if="hasMonsterAccess"/>
        <div class="place" v-if="hasMonsterAccess"/>

        <div class="title" v-if="(selectedGlobalSubAction2.id === 5 || selectedGlobalAction.id === 4) && (!hasMonsterAccess || selectedGlobalSubAction4.id !== 0)">Общая информация</div>
        <div class="itemMenuContainer" v-if="!hasMonsterAccess || selectedGlobalSubAction4.id !== 0">
          <i :class="['bx', menuInformation[1].i]"/>
          <div class="itemMenuText">{{ menuInformation[1].text }}</div>
          <div class="itemMenuValue">{{ isEmpty(itemMenu.groundType) ? '—' : itemMenu.groundType.name }}</div>
        </div>
        <div class="itemMenuContainer" v-if="!hasMonsterAccess || selectedGlobalSubAction4.id !== 0">
          <i :class="['bx', menuInformation[2].i]"/>
          <div class="itemMenuText">{{ menuInformation[2].text }}</div>
          <div class="itemMenuValue">{{ isEmpty(itemMenu.specialType) ? '—' : itemMenu.specialType.name }}</div>
        </div>
        <div class="itemMenuContainer" v-if="!hasMonsterAccess || selectedGlobalSubAction4.id !== 0">
          <i :class="['bx', menuInformation[3].i]"/>
          <div class="itemMenuText">{{ menuInformation[3].text }}</div>
          <div class="itemMenuValue">{{ isEmpty(itemMenu.resourcesType) ? '—' : (itemMenu.resourcesType.name + ': ' + itemMenu.resourcesCount) }}</div>
        </div>
        <div class="itemMenuContainer" style="height: 38px" v-if="!hasMonsterAccess || selectedGlobalSubAction4.id !== 0">
          <i :class="['bx', menuInformation[4].i]"/>
          <div class="itemMenuText">{{ menuInformation[4].text }}</div>
          <div class="itemMenuValue" style="font-size: 0.9em">{{ isEmpty(itemMenu.building) ? '—' : getBuildingManageString(itemMenu.building) }}</div>
        </div>
        <div class="itemMenuContainer" :style="{ marginBottom: selectedGlobalAction.id === 4 ? '1.3em' : '10px' }" v-if="!hasMonsterAccess || selectedGlobalSubAction4.id !== 0">
          <i :class="['bx', menuInformation[5].i]"/>
          <div class="itemMenuText">{{ menuInformation[5].text }}</div>
          <div class="itemMenuValue" :style="{'color' : isEmpty(itemMenu.owner) ? '' : itemMenu.owner.color }">{{ isEmpty(itemMenu.owner) ? '—' : itemMenu.owner.name }}</div>
        </div>
        <div class="itemMenuContainer" style="height: 38px" v-if="selectedGlobalAction.id === 4 && selectedGlobalSubAction4.id !== 0">
          <i :class="['bx', menuInformation[6].i]"/>
          <div class="itemMenuText">{{ menuInformation[6].text }}</div>
          <div class="itemMenuValue" :style="{'color' : dairs[selectedGlobalSubAction4.id].color, 'font-size' : '0.9em' }">{{ itemMenu.peoples === 0 ? '—' : itemMenu.peoples + ' чел.' }}</div>
        </div>

        <div v-for="(id, index) in getScoutAccess" :key="index">
          <div class="title" v-if="hasScoutAccess">Информация о разведчике</div>
          <div class="itemMenuContainer" v-if="hasScoutAccess">
            <i :class="['bx', menuScout[1].i]"/>
            <div class="itemMenuText">{{ menuScout[1].text }}</div>
            <div class="itemMenuValue" :style="{'color' : itemMenu.units.scouts[id].stepsCount === 0 ? '#ff4242' : '' }">{{ itemMenu.units.scouts[id].stepsCount }}</div>
          </div>
          <div class="itemMenuContainer" v-if="hasScoutAccess">
            <i :class="['bx', menuScout[2].i]"/>
            <div class="itemMenuText">{{ menuScout[2].text }}</div>
            <div class="itemMenuValue" :style="{'color' : dairs[id].color }">{{ dairs[id].name }}</div>
          </div>
        </div>

        <div class="title" v-if="hasWarriorAccess">Информация о воине</div>
        <div class="itemMenuContainer" v-if="hasWarriorManageAccess">
          <i :class="['bx', menuWarrior[1].i]"/>
          <div class="itemMenuText">{{ menuWarrior[1].text }}</div>
          <div class="itemMenuValue" :style="{'color' : itemMenu.units.warrior.stepsCount === 0 ? '#ff4242' : '' }">{{ itemMenu.units.warrior.stepsCount }}</div>
        </div>
        <div class="itemMenuContainer" v-if="hasWarriorAccess">
          <i :class="['bx', menuWarrior[2].i]"/>
          <div class="itemMenuText">{{ menuWarrior[2].text }}</div>
          <div class="itemMenuValue" :style="{'color' : dairs[itemMenu.units.warrior.owner].color }">{{ dairs[itemMenu.units.warrior.owner].name }}</div>
        </div>
        <div class="itemMenuContainer" v-if="hasWarriorManageAccess">
          <i :class="['bx', menuWarrior[3].i]"/>
          <div class="itemMenuText">{{ menuWarrior[3].text }}</div>
          <div class="itemMenuValue" :style="{'color' : itemMenu.units.warrior.peoples === 0 ? '#ff4242' : '' }">{{ itemMenu.units.warrior.peoples }}</div>
        </div>
        <div v-for="(people, index) in getPeoplesBusiness()" :key="index + 'x'" v-if="selectedGlobalAction.id === 4 && hasWarriorManageAccess">
          <div class="itemMenuContainer" style="margin-bottom: 0">
            <i :class="['bx', menuWarrior[4].i]"/>
            <div class="itemMenuText">{{ menuWarrior[4].text }}</div>
            <div class="itemMenuValue" :style="{'color' : dairs[people].color }">{{ dairs[people].name }}</div>
          </div>
          <div class="itemMenuContainer">
            <div style="display: flex; justify-content: center; width: 100%">
              <vue-slider v-model="itemMenu.units.warrior.peoples"
                          :min="0"
                          :max="itemMenu.units.warrior.peoples + getPeoplesById(people)"
                          :disabled="itemMenu.units.warrior.peoples + getPeoplesById(people) === 0"
                          :style="{width: '85%'}"
                          :silent="true"
                          :lazy="true"
                          :clickable="false"
                          @drag-start="startWarriorPeoples"
                          @drag-end="setWarriorPeoples(people)">
                <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
                  <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ value }}</div>
                </template>
              </vue-slider>
            </div>
          </div>
        </div>

        <div class="title" v-if="hasKnightAccess">Информация о князе</div>
        <div class="itemMenuContainer" v-if="hasKnightManageAccess">
          <i :class="['bx', menuKnight[1].i]"/>
          <div class="itemMenuText">{{ menuKnight[1].text }}</div>
          <div class="itemMenuValue" :style="{'color' : itemMenu.units.knight.stepsCount === 0 ? '#ff4242' : '' }">{{ itemMenu.units.knight.stepsCount }}</div>
        </div>
        <div class="itemMenuContainer" v-if="hasKnightAccess">
          <i :class="['bx', menuKnight[2].i]"/>
          <div class="itemMenuText">{{ menuKnight[2].text }}</div>
          <div class="itemMenuValue" :style="{'color' : dairs[itemMenu.units.knight.owner].color }">{{ dairs[itemMenu.units.knight.owner].name }}</div>
        </div>
        <div class="itemMenuContainer" v-if="hasKnightManageAccess">
          <i :class="['bx', menuKnight[3].i]"/>
          <div class="itemMenuText">{{ menuKnight[3].text }}</div>
          <div class="itemMenuValue" :style="{'color' : itemMenu.units.knight.peoples === 0 ? '#ff4242' : '' }">{{ itemMenu.units.knight.peoples }}</div>
        </div>
        <div v-for="(people, index) in getPeoplesBusiness()" :key="index + 'y'" v-if="selectedGlobalAction.id === 4 && hasKnightManageAccess">
          <div class="itemMenuContainer" style="margin-bottom: 0">
            <i :class="['bx', menuKnight[4].i]"/>
            <div class="itemMenuText">{{ menuKnight[4].text }}</div>
            <div class="itemMenuValue" :style="{'color' : dairs[people].color }">{{ dairs[people].name }}</div>
          </div>
          <div class="itemMenuContainer">
            <div style="display: flex; justify-content: center; width: 100%">
              <vue-slider v-model="itemMenu.units.knight.peoples"
                          :min="0"
                          :max="itemMenu.units.knight.peoples + getPeoplesById(people)"
                          :disabled="itemMenu.units.knight.peoples + getPeoplesById(people) === 0"
                          :style="{width: '85%'}"
                          :silent="true"
                          :lazy="true"
                          :clickable="false"
                          @drag-start="startKnightPeoples"
                          @drag-end="setKnightPeoples(people)">
                <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
                  <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ value }}</div>
                </template>
              </vue-slider>
            </div>
          </div>
        </div>

        <div class="title" v-if="hasMonsterAccess">Информация о монстре</div>
        <div class="itemMenuContainer" v-if="hasMonsterAccess">
          <i :class="['bx', menuMonster[2].i]"/>
          <div class="itemMenuText">{{ menuMonster[2].text }}</div>
          <div class="itemMenuValue" :style="{'color' : itemMenu.monster.power === 0 ? '#ff4242' : '' }">{{ itemMenu.monster.power }}</div>
        </div>
        <div class="itemMenuContainer" v-if="hasMonsterAccess">
          <i :class="['bx', menuMonster[3].i]"/>
          <div class="itemMenuText">{{ menuMonster[3].text }}</div>
          <div class="itemMenuValue" :style="{'color' : itemMenu.monster.hp === 0 ? '#ff4242' : '' }">{{ itemMenu.monster.hp }}</div>
        </div>
        <div class="itemMenuContainer" v-if="hasMonsterAccess && (selectedGlobalAction.id === 4 && selectedGlobalSubAction4.id === 0 || selectedGlobalSubAction2.id === 5)">
          <i :class="['bx', menuMonster[4].i]"/>
          <div class="itemMenuText">{{ menuMonster[4].text }}</div>
          <div class="itemMenuValue" :style="{'font-size': '0.9em', 'color' : itemMenu.monster.stepsCount === 0 ? '#ff4242' : ''}">{{ itemMenu.monster.stepsCount }}</div>
        </div>
        <div class="itemMenuContainer" v-if="hasMonsterAccess && (selectedGlobalAction.id === 4 && selectedGlobalSubAction4.id === 0 || selectedGlobalSubAction2.id === 5)">
          <i :class="['bx', menuMonster[5].i]"/>
          <div class="itemMenuText">{{ menuMonster[5].text }}</div>
          <div class="itemMenuValue">{{ itemMenu.monster.visionCount }}</div>
        </div>
        <div class="itemMenuContainer" v-if="hasMonsterAccess">
          <i :class="['bx', menuMonster[6].i]"/>
          <div class="itemMenuText">{{ menuMonster[6].text }}</div>
          <div class="itemMenuValue">{{ itemMenu.monster.destroyBuildings ? 'Да' : 'Нет' }}</div>
        </div>
        <div class="itemMenuContainer" v-if="hasMonsterAccess">
          <i :class="['bx', menuMonster[7].i]"/>
          <div class="itemMenuText">{{ menuMonster[7].text }}</div>
          <div class="itemMenuValue">{{ itemMenu.monster.goWater ? 'Да' : 'Нет' }}</div>
        </div>
      </div>

      <div class="itemMenuSubActions" v-if="!collapsedMenu">
        <div class="actions" v-show="hasSpecialAccess"
             :style="{ 'opacity': hasSpecialAccess ? 1 : 0, 'margin-top': '10px' }">
          <div class="title">Специальные места</div>
          <div class="itemMenuSubActionsManage deleteResource" @click="manageSpecial(1)" style="margin-bottom: 15px">Очистить место</div>
          <div class="itemMenuSubActionsManage" @click="manageSpecial(2)">{{specialTypes[2].name}}</div>
          <div class="itemMenuSubActionsManage" @click="manageSpecial(3)">{{specialTypes[3].name}}</div>
          <div class="itemMenuSubActionsManage" @click="manageSpecial(4)">{{specialTypes[4].name}}</div>
          <div class="itemMenuSubActionsManage" @click="manageSpecial(5)">{{specialTypes[5].name}}</div>
        </div>

        <div class="actions" v-show="hasManageAccess"
             :style="{ 'opacity': hasManageAccess ? 1 : 0}">
          <div class="title">Ресурсы</div>
          <div class="itemMenuSubActionsManage deleteResource" @click="manageResources(-1)" style="margin-bottom: 15px">Удалить ресурс</div>
          <div class="itemMenuSubActionsManage" @click="manageResources(1)">{{resourcesTypes[1].name}}</div>
          <div class="itemMenuSubActionsManage" @click="manageResources(2)">{{resourcesTypes[2].name}}</div>
          <div class="itemMenuSubActionsManage" @click="manageResources(3)">{{resourcesTypes[3].name}}</div>
          <div class="itemMenuSubActionsManage" @click="manageResources(4)">{{resourcesTypes[4].name}}</div>
          <div class="itemMenuSubActionsManage" @click="manageResources(5)">{{resourcesTypes[5].name}}</div>
          <vue-slider v-model="resourcesCount"
                      :min="0"
                      :max="100"
                      :style="{margin: '10px 0 10px 0',
                           width: '85%'}">
            <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
              <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ value }}</div>
            </template>
          </vue-slider>
        </div>

        <div class="actions" v-show="hasBuildingsAccess"
             :style="{ 'opacity': hasBuildingsAccess ? 1 : 0 }">
          <div class="title">Здания</div>
          <div class="itemMenuSubActionsManage deleteResource" @click="manageBuilding(-1)" style="margin-bottom: 5px" v-if="!hasBuildingsManageAccess">Разрушить здание</div>
          <div v-for="(building, index) in getBuildings()" :class="['itemMenuSubActionsManage', !canBuild(building) ? 'cannotBuild' : '']" @click="manageBuilding(building)" :key="index" :style="{ 'margin': hasBuildingsManageAccess ? '3px 0 20px 0' :  '5px' }">
            <div style="color: inherit">{{getBuildingManageString(buildings[building])}}</div>
            <div class="itemMenuSubActionsResourcesContainer" v-if="hasBuildingsManageAccess">
              <div v-for="(cost, i) in getBuildingCost(building)" :key="i">
                <div :style="{ 'display': 'flex', 'align-items': 'center', 'color': !hasResources(cost, i + 1) ? 'red' : '#F5F5F5' }">
                  <i :class="['bx', resourcesTypes[i + 1].i]" style="color: inherit"/>
                  <div style="margin-left: 2px; color: inherit">{{cost}}</div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="actions" v-show="hasMonsterCreateAccess"
             :style="{ 'opacity': hasMonsterCreateAccess ? 1 : 0 }">
          <div class="title" style="margin-bottom: 0">{{ monsterTypes[selectedMonsterType].name }}</div>
          <div class="monster" :style="{ backgroundImage: monsterTypes[selectedMonsterType].url }"/>
          <div class="place"/>
          <div :class="['itemMenuSubActionsManage', selectedMonsterType === 1 ? 'itemMenuSubActionsManageSelected' : '']" @click="manageMonster(1)">{{monsterTypes[1].name}}</div>
          <div :class="['itemMenuSubActionsManage', selectedMonsterType === 2 ? 'itemMenuSubActionsManageSelected' : '']" @click="manageMonster(2)">{{monsterTypes[2].name}}</div>
          <div :class="['itemMenuSubActionsManage', selectedMonsterType === 3 ? 'itemMenuSubActionsManageSelected' : '']" @click="manageMonster(3)">{{monsterTypes[3].name}}</div>
          <div :class="['itemMenuSubActionsManage', selectedMonsterType === 4 ? 'itemMenuSubActionsManageSelected' : '']" @click="manageMonster(4)">{{monsterTypes[4].name}}</div>
          <div :class="['itemMenuSubActionsManage', selectedMonsterType === 5 ? 'itemMenuSubActionsManageSelected' : '']" @click="manageMonster(5)">{{monsterTypes[5].name}}</div>
          <div class="subtitle">Сила монстра</div>
          <vue-slider v-model="monsterPower"
                      :min="0"
                      :max="100"
                      :style="{width: '85%'}">
            <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
              <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ value }}</div>
            </template>
          </vue-slider>
          <div class="subtitle">Защита монстра</div>
          <vue-slider v-model="monsterHP"
                      :min="0"
                      :max="100"
                      :style="{width: '85%'}">
            <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
              <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ value }}</div>
            </template>
          </vue-slider>
          <div class="subtitle">Шагов за период</div>
          <vue-slider v-model="stepsCount"
                      :min="1"
                      :max="10"
                      :style="{width: '85%'}">
            <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
              <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ value }}</div>
            </template>
          </vue-slider>
          <div class="subtitle">Видимость (клеток)</div>
          <vue-slider v-model="visionCount"
                      :min="1"
                      :max="5"
                      :style="{width: '85%'}">
            <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
              <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ value }}</div>
            </template>
          </vue-slider>
          <div style="margin-top: 15px" :class="['itemMenuSubActionsManage', destroyBuildings ? 'itemMenuSubActionsManageSelected' : '']" @click="destroyBuildings = !destroyBuildings">Разрушает постройки</div>
          <div style="margin-top: 15px" :class="['itemMenuSubActionsManage', goWater ? 'itemMenuSubActionsManageSelected' : '']" @click="goWater = !goWater">Перемещается по воде</div>
          <div style="display: flex; justify-content: space-evenly; width: 100%">
            <p class="submit submitYes" @click="createMonster">Создать монстра</p>
          </div>
        </div>

        <div class="actions" v-show="hasGoAccess"
             :style="{ 'opacity': hasGoAccess ? 1 : 0}">
          <div class="title">Добавить юнита</div>
          <div class="itemMenuSubActionsManage" @click="createScout">Разведчик</div>
          <div class="itemMenuSubActionsManage" @click="createWarrior">Воин</div>
          <div class="itemMenuSubActionsManage" @click="createKnight">Князь</div>
        </div>

        <div class="actions" v-show="getUnitsAccess"
             :style="{ 'opacity': getUnitsAccess ? 1 : 0}">
          <div class="itemMenuSubActionsManage deleteResource" @click="clearUnits" style="margin-bottom: 5px">Очистить ячейку</div>
        </div>
      </div>
    </div>
    <div class="modalWindow" v-if="periodOpen" @click="nextPeriodPanelClose">
      <div class="modalContainer" @click="stopPropagation">
        <i @click="nextPeriodPanelClose" class='bx bx-x close' style="margin: 0 5px 0 5px !important; font-size: 1.4em; position: absolute; right: 0; top: 3px;"/>
        <div class="modalContainerContainer">
          <div style="margin-bottom: 20px; font-size: 1.2em">{{'Ресурсы на следующий ' + (period + 1) + ' период'}}</div>
          <div v-for="(id, index) in [1, 2, 3, 4, 5]" :key="index" class="nextPeriodContainerItem">
            <div :style="{ 'margin-bottom': '10px', 'color': dairs[id].color, 'font-size' : '1.3em' }">{{ dairs[id].name }}</div>
            <div class="nextPeriodContainerItemResources">
              <div class="nextPeriodContainerItemResourcesContainer" v-for="(resource, indexResource) in resourcesTypes" :key="indexResource">
                <i :class="['bx', resource.i]" style="font-size: 1em"/>
                <div style="font-size: 0.85em; margin-right: 0.5em; margin-left: 5px">{{resource.name + ':'}}</div>
                <div :style="{ 'font-size': '0.9em', 'color' : getNextPeriodResource(id, indexResource) <= 0 ? '#ff4242' : '' }">
                  {{ (getNextPeriodResource(id, indexResource) > 0 ? getNextPeriodResource(id, indexResource) : '0') + ' (' +  (getAdditionalNextPeriodResource(id, indexResource) > 0 ? '+' : '') + getAdditionalNextPeriodResource(id, indexResource) + ')'  }}
                </div>
              </div>
            </div>
          </div>
          <div class="footerResourcesSettings" @click="nextPeriod" style="margin-bottom: 10px; margin-top: 30px">
            <i :class="['bx', 'bx-download', 'bx-rotate-270']" style="font-size: 1.2em; margin-right: 10px; color: inherit"/>
            <div style="color: inherit">Сменить период</div>
          </div>
        </div>
      </div>
    </div>
    <div class="modalWindow" v-if="marketOpen" @click="marketPanelClose">
      <div class="modalContainer" @click="stopPropagation">
        <i @click="marketPanelClose" class='bx bx-x close' style="margin: 0 5px 0 5px !important; font-size: 1.4em; position: absolute; right: 0; top: 3px;"/>
        <div style="margin-bottom: 15px; font-size: 1.2em">Торговля</div>
        <div class="modalContainerContainer" style="flex-direction: row; margin-bottom: 10px">
          <div class="marketOwners">
            <div :class="['marketOwnersItem', market2 === 1 ? '' : 'canSelectedMarketOwnersItem', market1 === 1 ? 'marketOwnersSelected' : '']" @click="setMarket1(1)" :style="{ 'border-color': dairs[1].colorSecond, '--first-color' : dairs[1].color, '--border-color' : '2px solid ' + dairs[1].color, '--second-color': '0 0 0 5px ' + dairs[1].colorSecond }">{{dairs[1].name}}</div>
            <div :class="['marketOwnersItem', market2 === 2 ? '' : 'canSelectedMarketOwnersItem', market1 === 2 ? 'marketOwnersSelected' : '']" @click="setMarket1(2)" :style="{ 'border-color': dairs[2].colorSecond, '--first-color' : dairs[2].color, '--border-color' : '2px solid ' + dairs[2].color, '--second-color': '0 0 0 5px ' + dairs[2].colorSecond }">{{dairs[2].name}}</div>
            <div :class="['marketOwnersItem', market2 === 3 ? '' : 'canSelectedMarketOwnersItem', market1 === 3 ? 'marketOwnersSelected' : '']" @click="setMarket1(3)" :style="{ 'border-color': dairs[3].colorSecond, '--first-color' : dairs[3].color, '--border-color' : '2px solid ' + dairs[3].color, '--second-color': '0 0 0 5px ' + dairs[3].colorSecond }">{{dairs[3].name}}</div>
            <div :class="['marketOwnersItem', market2 === 4 ? '' : 'canSelectedMarketOwnersItem', market1 === 4 ? 'marketOwnersSelected' : '']" @click="setMarket1(4)" :style="{ 'border-color': dairs[4].colorSecond, '--first-color' : dairs[4].color, '--border-color' : '2px solid ' + dairs[4].color, '--second-color': '0 0 0 5px ' + dairs[4].colorSecond }">{{dairs[4].name}}</div>
            <div :class="['marketOwnersItem', market2 === 5 ? '' : 'canSelectedMarketOwnersItem', market1 === 5 ? 'marketOwnersSelected' : '']" @click="setMarket1(5)" :style="{ 'border-color': dairs[5].colorSecond, '--first-color' : dairs[5].color, '--border-color' : '2px solid ' + dairs[5].color, '--second-color': '0 0 0 5px ' + dairs[5].colorSecond }">{{dairs[5].name}}</div>
          </div>
          <div class="marketOwners marketPlace" :style="{ 'border-color' : notMarket1Selected() ? 'rgba(255, 255, 255, 0.7)' : dairs[market1].color }">
            <div :style="{ 'margin': '10px', 'color': notMarket1Selected() ? '' : dairs[market1].color, 'font-size' : '1.1em' }">{{ notMarket1Selected() ? '—' : dairs[market1].name }}</div>
            <div class="marketPlaceContainer" v-for="(resource, indexResource) in resourcesTypes" :key="indexResource">
              <div class="marketPlaceSubContainer">
                <i :class="['bx', resource.i]" style="font-size: 1em"/>
                <div style="font-size: 0.85em; margin-right: 0.5em; margin-left: 5px">{{resource.name}}</div>
              </div>
              <div class="marketPlaceSubContainer" style="margin-bottom: 10px">
                <div style="margin-right: 15px">{{0}}</div>
                <vue-slider v-model="marketResource1[indexResource]"
                            :min="0"
                            :max="marketMaxResource1[indexResource]"
                            :disabled="notMarket1Selected() || notMarket2Selected() || marketMaxResource1[indexResource] === 0"
                            :style="{width: '100%'}">
                  <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
                    <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ value }}</div>
                  </template>
                </vue-slider>
                <div :style="{ 'margin-left': '15px', 'color': marketMaxResource1[indexResource] === 0 ? '#ff4242' : '' }">{{marketMaxResource1[indexResource]}}</div>
              </div>
            </div>
            <div class="marketPlaceSubContainer" style="justify-content: space-evenly; margin: 20px 0 10px 0">
              <div v-for="(resource, index) in getMarketResources(1)" :key="index" style="font-size: 0.9em">
                <div :style="{ 'display': 'flex', 'align-items': 'center' }">
                  <i :class="['bx', resourcesTypes[index].i]" style="font-size: 1.2em; margin-right: 5px"/>
                  <div :style="{ 'color' : (notMarket1Selected() ? 0 : (resource - marketResource1[index] + marketResource2[index])) === 0 ? '#ff4242' : '' }">{{notMarket1Selected() ? 0 : (resource - marketResource1[index] + marketResource2[index])}}</div>
                </div>
              </div>
            </div>
          </div>
          <i :class="['bx', 'bx-transfer', 'marketActions', !notMarket1Selected() && !notMarket2Selected() ? 'marketActionsTradable' : '']" style="margin: 25px; font-size: 2em" @click="trade"/>
          <div class="marketOwners marketPlace" :style="{ 'border-color' : notMarket2Selected() ? 'rgba(255, 255, 255, 0.7)' : dairs[market2].color }">
            <div :style="{ 'margin': '10px', 'color': notMarket2Selected() ? '' : dairs[market2].color, 'font-size' : '1.1em' }">{{ notMarket2Selected() ? '—' : dairs[market2].name }}</div>
            <div class="marketPlaceContainer" v-for="(resource, indexResource) in resourcesTypes" :key="indexResource">
              <div class="marketPlaceSubContainer">
                <i :class="['bx', resource.i]" style="font-size: 1em"/>
                <div style="font-size: 0.85em; margin-right: 0.5em; margin-left: 5px">{{resource.name}}</div>
              </div>
              <div class="marketPlaceSubContainer" style="margin-bottom: 10px">
                <div style="margin-right: 15px">{{0}}</div>
                <vue-slider v-model="marketResource2[indexResource]"
                            :min="0"
                            :max="marketMaxResource2[indexResource]"
                            :disabled="notMarket2Selected() || notMarket1Selected()|| marketMaxResource2[indexResource] === 0"
                            :style="{width: '100%'}">
                  <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
                    <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ value }}</div>
                  </template>
                </vue-slider>
                <div :style="{ 'margin-left': '15px', 'color': marketMaxResource2[indexResource] === 0 ? '#ff4242' : '' }">{{marketMaxResource2[indexResource]}}</div>
              </div>
            </div>
            <div class="marketPlaceSubContainer" style="justify-content: space-evenly; margin: 20px 0 10px 0">
              <div v-for="(resource, index) in getMarketResources(2)" :key="index" style="font-size: 0.9em">
                <div :style="{ 'display': 'flex', 'align-items': 'center' }">
                  <i :class="['bx', resourcesTypes[index].i]" style="font-size: 1.2em; margin-right: 5px"/>
                  <div :style="{ 'color' : (notMarket2Selected() ? 0 : (resource - marketResource2[index] + marketResource1[index])) === 0 ? '#ff4242' : '' }">{{notMarket2Selected() ? 0 : (resource - marketResource2[index] + marketResource1[index])}}</div>
                </div>
              </div>
            </div>
          </div>
          <div class="marketOwners">
            <div :class="['marketOwnersItem', market1 === 1 ? '' : 'canSelectedMarketOwnersItem', market2 === 1 ? 'marketOwnersSelected' : '']" @click="setMarket2(1)" :style="{ 'border-color': dairs[1].colorSecond, '--first-color' : dairs[1].color, '--border-color' : '2px solid ' + dairs[1].color, '--second-color': '0 0 0 5px ' + dairs[1].colorSecond }">{{dairs[1].name}}</div>
            <div :class="['marketOwnersItem', market1 === 2 ? '' : 'canSelectedMarketOwnersItem', market2 === 2 ? 'marketOwnersSelected' : '']" @click="setMarket2(2)" :style="{ 'border-color': dairs[2].colorSecond, '--first-color' : dairs[2].color, '--border-color' : '2px solid ' + dairs[2].color, '--second-color': '0 0 0 5px ' + dairs[2].colorSecond }">{{dairs[2].name}}</div>
            <div :class="['marketOwnersItem', market1 === 3 ? '' : 'canSelectedMarketOwnersItem', market2 === 3 ? 'marketOwnersSelected' : '']" @click="setMarket2(3)" :style="{ 'border-color': dairs[3].colorSecond, '--first-color' : dairs[3].color, '--border-color' : '2px solid ' + dairs[3].color, '--second-color': '0 0 0 5px ' + dairs[3].colorSecond }">{{dairs[3].name}}</div>
            <div :class="['marketOwnersItem', market1 === 4 ? '' : 'canSelectedMarketOwnersItem', market2 === 4 ? 'marketOwnersSelected' : '']" @click="setMarket2(4)" :style="{ 'border-color': dairs[4].colorSecond, '--first-color' : dairs[4].color, '--border-color' : '2px solid ' + dairs[4].color, '--second-color': '0 0 0 5px ' + dairs[4].colorSecond }">{{dairs[4].name}}</div>
            <div :class="['marketOwnersItem', market1 === 5 ? '' : 'canSelectedMarketOwnersItem', market2 === 5 ? 'marketOwnersSelected' : '']" @click="setMarket2(5)" :style="{ 'border-color': dairs[5].colorSecond, '--first-color' : dairs[5].color, '--border-color' : '2px solid ' + dairs[5].color, '--second-color': '0 0 0 5px ' + dairs[5].colorSecond }">{{dairs[5].name}}</div>
          </div>
        </div>
      </div>
    </div>
    <div class="modalWindow" v-if="loadResourcesOpen" @click="loadResourcesPanelClose">
      <div class="modalContainer" @click="stopPropagation">
        <i @click="loadResourcesPanelClose" class='bx bx-x close' style="margin: 0 5px 0 5px !important; font-size: 1.4em; position: absolute; right: 0; top: 3px;"/>
        <div style="margin-bottom: 15px; font-size: 1.2em">Ввод/вывод ресурсов</div>
        <div class="modalContainerContainer" style="flex-direction: row; margin-bottom: 10px">
          <div class="marketOwners">
            <div :class="['marketOwnersItem', market2 === 1 ? '' : 'canSelectedMarketOwnersItem', market1 === 1 ? 'marketOwnersSelected' : '']" @click="setMarketResources(1)" :style="{ 'border-color': dairs[1].colorSecond, '--first-color' : dairs[1].color, '--border-color' : '2px solid ' + dairs[1].color, '--second-color': '0 0 0 5px ' + dairs[1].colorSecond }">{{dairs[1].name}}</div>
            <div :class="['marketOwnersItem', market2 === 2 ? '' : 'canSelectedMarketOwnersItem', market1 === 2 ? 'marketOwnersSelected' : '']" @click="setMarketResources(2)" :style="{ 'border-color': dairs[2].colorSecond, '--first-color' : dairs[2].color, '--border-color' : '2px solid ' + dairs[2].color, '--second-color': '0 0 0 5px ' + dairs[2].colorSecond }">{{dairs[2].name}}</div>
            <div :class="['marketOwnersItem', market2 === 3 ? '' : 'canSelectedMarketOwnersItem', market1 === 3 ? 'marketOwnersSelected' : '']" @click="setMarketResources(3)" :style="{ 'border-color': dairs[3].colorSecond, '--first-color' : dairs[3].color, '--border-color' : '2px solid ' + dairs[3].color, '--second-color': '0 0 0 5px ' + dairs[3].colorSecond }">{{dairs[3].name}}</div>
            <div :class="['marketOwnersItem', market2 === 4 ? '' : 'canSelectedMarketOwnersItem', market1 === 4 ? 'marketOwnersSelected' : '']" @click="setMarketResources(4)" :style="{ 'border-color': dairs[4].colorSecond, '--first-color' : dairs[4].color, '--border-color' : '2px solid ' + dairs[4].color, '--second-color': '0 0 0 5px ' + dairs[4].colorSecond }">{{dairs[4].name}}</div>
            <div :class="['marketOwnersItem', market2 === 5 ? '' : 'canSelectedMarketOwnersItem', market1 === 5 ? 'marketOwnersSelected' : '']" @click="setMarketResources(5)" :style="{ 'border-color': dairs[5].colorSecond, '--first-color' : dairs[5].color, '--border-color' : '2px solid ' + dairs[5].color, '--second-color': '0 0 0 5px ' + dairs[5].colorSecond }">{{dairs[5].name}}</div>
          </div>
          <div class="marketOwners marketPlace" :style="{ 'border-color' : notMarket1Selected() ? 'rgba(255, 255, 255, 0.7)' : dairs[market1].color, 'height': '485px' }">
            <div :style="{ 'margin': '10px', 'color': notMarket1Selected() ? '' : dairs[market1].color, 'font-size' : '1.1em' }">{{ notMarket1Selected() ? '—' : dairs[market1].name }}</div>
            <div class="marketPlaceContainer" v-for="(resource, indexResource) in resourcesTypes" :key="indexResource">
              <div class="marketPlaceSubContainer">
                <i :class="['bx', resource.i]" style="font-size: 1em"/>
                <div style="font-size: 0.85em; margin-right: 0.5em; margin-left: 5px">{{resource.name}}</div>
              </div>
              <div class="marketPlaceSubContainer" style="margin-bottom: 10px">
                <div style="margin-right: 15px">{{0}}</div>
                <vue-slider v-model="marketResource1[indexResource]"
                            :min="0"
                            :max="marketMaxResource1[indexResource]"
                            :silent="true"
                            :disabled="notMarket1Selected()"
                            :style="{width: '100%'}">
                  <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
                    <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ value }}</div>
                  </template>
                </vue-slider>
                <div :style="{ 'margin-left': '15px', 'color': marketMaxResource1[indexResource] === 0 ? '#ff4242' : '' }">{{marketMaxResource1[indexResource]}}</div>
              </div>
            </div>
            <div class="marketPlaceSubContainer" style="justify-content: space-evenly; margin: 20px 0 10px 0">
              <div v-for="(resource, index) in resourcesTypes" :key="index" style="font-size: 0.9em">
                <div :style="{ 'display': 'flex', 'align-items': 'center' }">
                  <i :class="['bx', resource.i]" style="font-size: 1.2em; margin-right: 5px"/>
                  <div :style="{ 'color' : (notMarket1Selected() ? 0 : (marketResource1[index])) === 0 ? '#ff4242' : '' }">{{notMarket1Selected() ? 0 : marketResource1[index]}}</div>
                </div>
              </div>
            </div>
            <div class="itemMenuSubActionsManage" @click="loadResources" :style="{ 'font-size' : '1.2em', 'margin': '13px' }">{{ 'Ввод/вывод' }}</div>
          </div>
          <div class="marketOwners marketPlace" :style="{ 'border-color': 'rgba(255, 255, 255, 0.7)', 'height': '485px', 'width': '430px', 'justify-content': 'start', 'overflow': 'scroll' }">
            <div :style="{ 'margin': '10px', 'margin-bottom': '20px', 'font-size' : '1.1em' }">{{ 'История операций' }}</div>
            <div class="marketPlaceSubContainer" :style="{ 'font-size' : '0.9em', 'position': 'relative', 'margin-bottom': '15px' }" v-for="(resource, indexR) in getHistory()" :key="indexR">
              <div class="marketPlaceSubContainerTime">{{ resource.date.toLocaleString() }}</div>
              <div :style="{ 'color': dairs[resource.dair].color }">{{ dairs[resource.dair].name }}</div>
              <div :style="{ 'color': resource.count > 0 ? '#b9ffb8' : '#fdb8b8' }">{{ (resource.count > 0 ? '&nbsp;добавил&nbsp;' : '&nbsp;вывел&nbsp;') }}</div>
              <div>{{ Math.abs(resource.count) + ' шт' }}</div>
              <div>{{ ', ' + resourcesTypes[resource.resource].name + '&nbsp;' }}</div>
              <i :class="['bx', resourcesTypes[resource.resource].i]" style="font-size: 1em"/>
              <div>{{ ', ' + resource.period + ' период' }}</div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="modalWindow" v-if="businessOpen" @click="businessPanelClose">
      <div class="modalContainer" @click="stopPropagation">
        <i @click="businessPanelClose" class='bx bx-x close' style="margin: 0 5px 0 5px !important; font-size: 1.4em; position: absolute; right: 0; top: 3px;"/>
        <div style="margin-bottom: 15px; font-size: 1.2em">Заключение договоров</div>
        <div class="modalContainerContainer" style="flex-direction: row; margin-bottom: 10px">
          <div class="marketOwners">
            <div :class="['marketOwnersItem', market2 === 1 ? '' : 'canSelectedMarketOwnersItem', market1 === 1 ? 'marketOwnersSelected' : '']" @click="setMarket1(1)" :style="{ 'border-color': dairs[1].colorSecond, '--first-color' : dairs[1].color, '--border-color' : '2px solid ' + dairs[1].color, '--second-color': '0 0 0 5px ' + dairs[1].colorSecond }">{{dairs[1].name}}</div>
            <div :class="['marketOwnersItem', market2 === 2 ? '' : 'canSelectedMarketOwnersItem', market1 === 2 ? 'marketOwnersSelected' : '']" @click="setMarket1(2)" :style="{ 'border-color': dairs[2].colorSecond, '--first-color' : dairs[2].color, '--border-color' : '2px solid ' + dairs[2].color, '--second-color': '0 0 0 5px ' + dairs[2].colorSecond }">{{dairs[2].name}}</div>
            <div :class="['marketOwnersItem', market2 === 3 ? '' : 'canSelectedMarketOwnersItem', market1 === 3 ? 'marketOwnersSelected' : '']" @click="setMarket1(3)" :style="{ 'border-color': dairs[3].colorSecond, '--first-color' : dairs[3].color, '--border-color' : '2px solid ' + dairs[3].color, '--second-color': '0 0 0 5px ' + dairs[3].colorSecond }">{{dairs[3].name}}</div>
            <div :class="['marketOwnersItem', market2 === 4 ? '' : 'canSelectedMarketOwnersItem', market1 === 4 ? 'marketOwnersSelected' : '']" @click="setMarket1(4)" :style="{ 'border-color': dairs[4].colorSecond, '--first-color' : dairs[4].color, '--border-color' : '2px solid ' + dairs[4].color, '--second-color': '0 0 0 5px ' + dairs[4].colorSecond }">{{dairs[4].name}}</div>
            <div :class="['marketOwnersItem', market2 === 5 ? '' : 'canSelectedMarketOwnersItem', market1 === 5 ? 'marketOwnersSelected' : '']" @click="setMarket1(5)" :style="{ 'border-color': dairs[5].colorSecond, '--first-color' : dairs[5].color, '--border-color' : '2px solid ' + dairs[5].color, '--second-color': '0 0 0 5px ' + dairs[5].colorSecond }">{{dairs[5].name}}</div>
          </div>
          <div class="marketOwners marketPlace" :style="{ 'border-color' : notMarket1Selected() ? 'rgba(255, 255, 255, 0.7)' : dairs[market1].color }">
            <div :style="{ 'margin': '10px', 'color': notMarket1Selected() ? '' : dairs[market1].color, 'font-size' : '1.1em' }">{{ notMarket1Selected() ? '—' : dairs[market1].name }}</div>
            <div class="itemMenuSubActionsManage" :style="{ 'color' : notMarket1Selected() || notMarket2Selected() ? '' : getBusinessPiece(market1, market2) ? '#26ee20' : '#ff4242' }" @click="setBusinessPiece(market1, market2)">{{ notMarket1Selected() || notMarket2Selected() ? '—' : (getBusinessPiece(market1, market2) ? 'Свободный проход' : 'Захват территории') }}</div>
            <div class="itemMenuSubActionsManage" :style="{ 'color' : notMarket1Selected() || notMarket2Selected() ? '' : getBusinessTerritory(market1, market2) ? '#26ee20' : '#ff4242' }" @click="setBusinessTerritory(market1, market2)">{{ notMarket1Selected() || notMarket2Selected() ? '—' : (getBusinessTerritory(market1, market2) ? 'Территория открыта' : 'Территория скрыта') }}</div>
            <div class="itemMenuSubActionsManage" :style="{ 'color' : notMarket1Selected() || notMarket2Selected() ? '' : getBusinessArmy(market1, market2) ? '#26ee20' : '#ff4242', 'margin-bottom': '20px' }" @click="setBusinessArmy(market1, market2)">{{ notMarket1Selected() || notMarket2Selected() ? '—' : (getBusinessArmy(market1, market2) ? 'Войска доступны' : 'Войска недоступны') }}</div>
          </div>
          <div class="marketOwners marketPlace" :style="{ 'border-color' : notMarket2Selected() ? 'rgba(255, 255, 255, 0.7)' : dairs[market2].color }">
            <div :style="{ 'margin': '10px', 'color': notMarket2Selected() ? '' : dairs[market2].color, 'font-size' : '1.1em' }">{{ notMarket2Selected() ? '—' : dairs[market2].name }}</div>
            <div class="itemMenuSubActionsManage" :style="{ 'color' : notMarket1Selected() || notMarket2Selected() ? '' : getBusinessPiece(market2, market1) ? '#26ee20' : '#ff4242' }" @click="setBusinessPiece(market2, market1)">{{ notMarket1Selected() || notMarket2Selected() ? '—' : (getBusinessPiece(market2, market1) ? 'Свободный проход' : 'Захват территории') }}</div>
            <div class="itemMenuSubActionsManage" :style="{ 'color' : notMarket1Selected() || notMarket2Selected() ? '' : getBusinessTerritory(market2, market1) ? '#26ee20' : '#ff4242' }" @click="setBusinessTerritory(market2, market1)">{{ notMarket1Selected() || notMarket2Selected() ? '—' : (getBusinessTerritory(market2, market1) ? 'Территория открыта' : 'Территория скрыта') }}</div>
            <div class="itemMenuSubActionsManage" :style="{ 'color' : notMarket1Selected() || notMarket2Selected() ? '' : getBusinessArmy(market2, market1) ? '#26ee20' : '#ff4242', 'margin-bottom': '20px' }" @click="setBusinessArmy(market2, market1)">{{ notMarket1Selected() || notMarket2Selected() ? '—' : (getBusinessArmy(market2, market1) ? 'Войска доступны' : 'Войска недоступны') }}</div>
          </div>
          <div class="marketOwners">
            <div :class="['marketOwnersItem', market1 === 1 ? '' : 'canSelectedMarketOwnersItem', market2 === 1 ? 'marketOwnersSelected' : '']" @click="setMarket2(1)" :style="{ 'border-color': dairs[1].colorSecond, '--first-color' : dairs[1].color, '--border-color' : '2px solid ' + dairs[1].color, '--second-color': '0 0 0 5px ' + dairs[1].colorSecond }">{{dairs[1].name}}</div>
            <div :class="['marketOwnersItem', market1 === 2 ? '' : 'canSelectedMarketOwnersItem', market2 === 2 ? 'marketOwnersSelected' : '']" @click="setMarket2(2)" :style="{ 'border-color': dairs[2].colorSecond, '--first-color' : dairs[2].color, '--border-color' : '2px solid ' + dairs[2].color, '--second-color': '0 0 0 5px ' + dairs[2].colorSecond }">{{dairs[2].name}}</div>
            <div :class="['marketOwnersItem', market1 === 3 ? '' : 'canSelectedMarketOwnersItem', market2 === 3 ? 'marketOwnersSelected' : '']" @click="setMarket2(3)" :style="{ 'border-color': dairs[3].colorSecond, '--first-color' : dairs[3].color, '--border-color' : '2px solid ' + dairs[3].color, '--second-color': '0 0 0 5px ' + dairs[3].colorSecond }">{{dairs[3].name}}</div>
            <div :class="['marketOwnersItem', market1 === 4 ? '' : 'canSelectedMarketOwnersItem', market2 === 4 ? 'marketOwnersSelected' : '']" @click="setMarket2(4)" :style="{ 'border-color': dairs[4].colorSecond, '--first-color' : dairs[4].color, '--border-color' : '2px solid ' + dairs[4].color, '--second-color': '0 0 0 5px ' + dairs[4].colorSecond }">{{dairs[4].name}}</div>
            <div :class="['marketOwnersItem', market1 === 5 ? '' : 'canSelectedMarketOwnersItem', market2 === 5 ? 'marketOwnersSelected' : '']" @click="setMarket2(5)" :style="{ 'border-color': dairs[5].colorSecond, '--first-color' : dairs[5].color, '--border-color' : '2px solid ' + dairs[5].color, '--second-color': '0 0 0 5px ' + dairs[5].colorSecond }">{{dairs[5].name}}</div>
          </div>
        </div>
      </div>
    </div>
    <div class="modalWindow" v-if="warOpen" @click="warPanelClose">
      <div class="modalContainer" @click="stopPropagation">
        <i @click="warPanelClose" class='bx bx-x close' style="margin: 0 5px 0 5px !important; font-size: 1.4em; position: absolute; right: 0; top: 3px;"/>
        <div style="margin-bottom: 15px; font-size: 1.2em">Бой</div>
        <div class="modalContainerContainer" style="flex-direction: row; margin-bottom: 10px">
          <div class="marketOwners marketPlace" :style="{ 'border-color' : isAttackMonster() ? 'rgba(255, 255, 255, 0.7)' : dairs[warAttack.owner].color }">
            <div :style="{ 'margin': '10px', 'color': isAttackMonster() ? '' : dairs[warAttack.owner].color, 'font-size' : '1.1em' }">{{ 'Нападающий — ' + warAttack.name }}</div>
            <div :style="{ 'margin': '10px', 'font-size' : '1.2em' }" v-if="warAttack.type === 4">{{ monsterTypes[warAttack.unit.type].name }}</div>
            <div class="monster" :style="{ backgroundImage: `url(${require('../assets/images/units/scout.png')})` }" v-if="warAttack.type === 1"/>
            <div class="place" v-if="warAttack.type === 1"/>

            <div class="monster" :style="{ backgroundImage: `url(${require('../assets/images/units/warrior.png')})` }" v-if="warAttack.type === 2"/>
            <div class="place" v-if="warAttack.type === 2"/>

            <div class="monster" :style="{ backgroundImage: `url(${require('../assets/images/units/knight.png')})` }" v-if="warAttack.type === 3"/>
            <div class="place" v-if="warAttack.type === 3"/>

            <div class="monster" :style="{ backgroundImage: monsterTypes[warAttack.unit.type].url }" v-if="warAttack.type === 4"/>
            <div class="place" v-if="warAttack.type === 4"/>

            <div style="font-size: 0.8em" v-if="warAttack.type !== 1">{{ 'Боевые потери' }}</div>
            <vue-slider v-if="warAttack.type !== 1"
                        v-model="warAttack.power"
                        :min="0"
                        :max="warAttack.type === 3 || warAttack.type === 2 ? warAttack.unit.peoples : warAttack.unit.hp"
                        :disabled="warAttack.unit.peoples === 0"
                        :style="{width: '80%', 'margin-bottom': '5px'}">
              <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
                <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ value }}</div>
              </template>
            </vue-slider>
            <div :class="['marketOwnersItem']" :style="{ 'border-color': 'rgba(255, 255, 255, 0.15)', 'margin-bottom': '20px' }" v-if="warAttack.type === 3 || warAttack.type === 2">{{ 'Войско - ' + warAttack.power  }}</div>
            <div :class="['marketOwnersItem']" :style="{ 'border-color': 'rgba(255, 255, 255, 0.15)', 'margin-bottom': '0' }" v-if="warAttack.type === 4">{{ 'Сила - ' + warAttack.unit.power  }}</div>
            <div :class="['marketOwnersItem']" :style="{ 'border-color': 'rgba(255, 255, 255, 0.15)', 'margin-bottom': '20px' }" v-if="warAttack.type === 4">{{ 'Защита - ' + warAttack.power  }}</div>
            <div class="itemMenuSubActionsManage" @click="winAttack" :style="{ 'font-size' : '1.2em', 'margin-bottom': '13px' }" >{{ 'Победа атаки' }}</div>
          </div>
          <div class="marketOwners marketPlace" :style="{ 'border-color' : isDefendMonster() ? 'rgba(255, 255, 255, 0.7)' : dairs[warDefend.owner].color }">
            <div :style="{ 'margin': '10px', 'color': isDefendMonster() ? '' : dairs[warDefend.owner].color, 'font-size' : '1.1em' }">{{ 'Защищающийся — ' + warDefend.name }}</div>
            <div :style="{ 'font-size' : '1.2em' }" v-if="warDefend.type === 4">{{ monsterTypes[warDefend.unit.type].name }}</div>
            <div class="monster" :style="{ backgroundImage: `url(${require('../assets/images/units/scout.png')})` }" v-if="warDefend.type === 1"/>
            <div class="place" v-if="warDefend.type === 1"/>

            <div class="monster" :style="{ backgroundImage: `url(${require('../assets/images/units/warrior.png')})` }" v-if="warDefend.type === 2"/>
            <div class="place" v-if="warDefend.type === 2"/>

            <div class="monster" :style="{ backgroundImage: `url(${require('../assets/images/units/knight.png')})` }" v-if="warDefend.type === 3"/>
            <div class="place" v-if="warDefend.type === 3"/>

            <div class="monster" :style="{ backgroundImage: monsterTypes[warDefend.unit.type].url }" v-if="warDefend.type === 4"/>
            <div class="place" v-if="warDefend.type === 4"/>

            <div style="font-size: 0.8em" v-if="warDefend.type !== 1">{{ 'Боевые потери' }}</div>
            <vue-slider v-if="warDefend.type !== 1"
                        v-model="warDefend.power"
                        :min="0"
                        :max="warDefend.type === 3 || warDefend.type === 2 ? warDefend.unit.peoples : warDefend.unit.hp"
                        :disabled="warDefend.unit.peoples === 0"
                        :style="{width: '80%', 'margin-bottom': '5px'}">
              <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
                <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ value }}</div>
              </template>
            </vue-slider>
            <div :class="['marketOwnersItem']" :style="{ 'border-color': 'rgba(255, 255, 255, 0.15)', 'margin-bottom': '20px' }" v-if="warDefend.type === 3 || warDefend.type === 2">{{ 'Войско - ' + warDefend.power }}</div>
            <div :class="['marketOwnersItem']" :style="{ 'border-color': 'rgba(255, 255, 255, 0.15)', 'margin-bottom': '0' }" v-if="warDefend.type === 4">{{ 'Сила - ' + warDefend.unit.power  }}</div>
            <div :class="['marketOwnersItem']" :style="{ 'border-color': 'rgba(255, 255, 255, 0.15)', 'margin-bottom': '20px' }" v-if="warDefend.type === 4">{{ 'Защита - ' + warDefend.power  }}</div>
            <div class="itemMenuSubActionsManage" @click="winDefend" :style="{ 'font-size' : '1.2em', 'margin-bottom': '13px' }" >{{ 'Победа защиты' }}</div>
          </div>
        </div>
      </div>
    </div>
  </main>
</template>

<script>
import axios from 'axios';
import 'vue-slider-component/theme/antd.css';
import VueSlider from 'vue-slider-component';
import '../assets/css/custom-dot.css';
import InstrumentPanel from '../components/InstrumentPanel';

export default {
  name: 'Dair',
  components: { 'vue-slider': VueSlider, 'instrument-panel': InstrumentPanel },
  data() {
    return {
      documentTitle: 'Завеса',
      dairMap: [],
      backgroundImage: `url(${require('../assets/images/dairs/meisters.jpg')})`,
      pathSave: 'http://localhost:5050/saveDair',
      pathGet: 'http://localhost:5050/getDair',
      loadedDairs: [],
      loadedDairMap: {},
      loadedBusiness: {},
      loadedHistory: [],
      loadedPeriod: -1,
      minDairZoom: 30,
      dairZoom: 30,
      maxDairZoom: 90,
      dairLetterPositions: ['А', 'Б', 'В', 'Г', 'Д', 'Е', 'Ё', 'Ж', 'З', 'И', 'К', 'Л', 'М', 'Н', 'О', 'П', 'Р', 'С', 'Т', 'У', 'Ф', 'Х', 'Ц', 'Э', 'Ю', 'Я', 'АА', 'АБ', 'АВ', 'АГ', 'АД', 'АЕ', 'АЖ', 'АЗ', 'АИ', 'АК', 'АЛ', 'АМ', 'АН', 'АО', 'АП', 'АР', 'АС', 'АТ', 'АУ', 'АФ', 'АХ', 'АЦ', 'АЧ', 'АШ', 'АЩ', 'АЫ', 'АЭ', 'АЮ', 'АЯ', 'БА', 'ББ', 'БВ', 'БГ', 'БД', 'БЕ', 'БЖ', 'БЗ', 'БИ', 'БК', 'БЛ', 'БМ', 'БН', 'БО', 'БП', 'БР', 'БС', 'БТ', 'БУ', 'БФ', 'БХ', 'БЦ', 'БЧ', 'БШ', 'БЩ', 'БЫ', 'БЭ', 'БЮ', 'БЯ', 'ВА', 'ВБ', 'ВВ', 'ВГ', 'ВД', 'ВЕ', 'ВЖ', 'ВЗ', 'ВИ', 'ВК', 'ВЛ', 'ВМ', 'ВН'],
      canvas: null,
      context: null,
      spaceSize: 0,
      cursorPositionY: -1,
      cursorPositionX: -1,
      hiddenSrc: 'global/hidden.png',
      selectionSrc: 'global/selection.jpeg',
      images: [],
      loadedCount: 0,
      imagesSrc: [
        'global/selection.jpeg',
        'global/hidden.png',

        'buildings/foodbuild1.png',
        'buildings/foodbuild2.png',
        'buildings/woodbuild1.png',
        'buildings/woodbuild2.png',
        'buildings/ironbuild1.png',
        'buildings/ironbuild2.png',
        'buildings/oilbuild1.png',
        'buildings/oilbuild2.png',
        'buildings/peoples1.png',
        'buildings/peoples2.png',
        'buildings/ship1.png',
        'buildings/ship2.png',
        'buildings/shipbuild.png',
        'buildings/stonebuild1.png',
        'buildings/stonebuild2.png',
        'buildings/wall1.png',
        'buildings/wall2.png',
        'buildings/tower.png',

        'grounds/forest.png',
        'grounds/ground.jpg',
        'grounds/mountains.png',
        'grounds/water.png',

        'resources/food.png',
        'resources/iron.png',
        'resources/oil.png',
        'resources/stone.png',
        'resources/wood.png',

        'special/hole.png',
        'special/special.png',
        'special/market.png',
        'special/piece.png',


        'global/go.png',
        'global/goWarn.png',
        'global/goStop.png',
        'monsterIcons/iconStop.png',
        'monsterIcons/iconGo.png',
        'monster/darkSoul.png',
        'monster/golem.png',
        'monster/ork.png',
        'monster/darkKnight.png',
        'monster/dragon.gif',

        'units/scoutGo.png',
        'units/scoutStop.png',
        'units/knight.png',
        'units/warrior.png',
        'units/warriorGo.png',
        'units/warriorStop.png',
        'units/knightGo.png',
        'units/knightStop.png',

        'units/scout.png',
      ],
      isResizing: false,

      dairSizeY: 25,
      dairSizeX: 50,

      resourcesCount: 10,
      initialResourcesCount: 10,

      isDrawing: false,
      selectionColor: '#F5F5F5',

      oldSelectedItems: [],
      selectedItems: [],
      selectedItem: {},
      collapsedMenu: false,

      cursorSizeDelta: 1.5,
      cursorSize: 1,
      cursorSolid: true,
      cursorForm: 'circle',
      cursorPlace: 1,
      cursorDair: 1,

      savedCursorSize: 3,
      savedCursorSolid: true,
      savedCursorForm: 'circle',
      savedCursorPlace: 1,
      savedCursorDair: 1,

      period: 1,
      magicGroundId: 14,
      portBuildingId: 7,
      drakkarBuildingId: 10,
      hole: {
        x: -1,
        y: -1,
      },
      holeColor: '#ffd600',
      periodOpen: false,
      marketOpen: false,
      businessOpen: false,
      loadResourcesOpen: false,
      warOpen: false,
      market1: -1,
      market2: -1,
      history: [],
      warAttack: {
        unit: {},
        name: '',
        type: -1,
        power: 0,
        owner: -1,
        x: -1,
        y: -1,
      },
      warDefend: {
        unit: {},
        name: '',
        type: -1,
        power: 0,
        owner: -1,
        x: -1,
        y: -1,
      },
      marketResource1: {
        1: 0,
        2: 0,
        3: 0,
        4: 0,
        5: 0,
        6: 0,
      },
      marketResource2: {
        1: 0,
        2: 0,
        3: 0,
        4: 0,
        5: 0,
        6: 0,
      },
      marketMaxResource1: {
        1: 0,
        2: 0,
        3: 0,
        4: 0,
        5: 0,
        6: 0,
      },
      marketMaxResource2: {
        1: 0,
        2: 0,
        3: 0,
        4: 0,
        5: 0,
        6: 0,
      },

      business: {
        1: {
          1: {
            piece: false,
            territory: false,
            army: false,
          },
          2: {
            piece: false,
            territory: false,
            army: false,
          },
          3: {
            piece: false,
            territory: false,
            army: false,
          },
          4: {
            piece: false,
            territory: false,
            army: false,
          },
          5: {
            piece: false,
            territory: false,
            army: false,
          },
        },
        2: {
          1: {
            piece: false,
            territory: false,
            army: false,
          },
          2: {
            piece: false,
            territory: false,
            army: false,
          },
          3: {
            piece: false,
            territory: false,
            army: false,
          },
          4: {
            piece: false,
            territory: false,
            army: false,
          },
          5: {
            piece: false,
            territory: false,
            army: false,
          },
        },
        3: {
          1: {
            piece: false,
            territory: false,
            army: false,
          },
          2: {
            piece: false,
            territory: false,
            army: false,
          },
          3: {
            piece: false,
            territory: false,
            army: false,
          },
          4: {
            piece: false,
            territory: false,
            army: false,
          },
          5: {
            piece: false,
            territory: false,
            army: false,
          },
        },
        4: {
          1: {
            piece: false,
            territory: false,
            army: false,
          },
          2: {
            piece: false,
            territory: false,
            army: false,
          },
          3: {
            piece: false,
            territory: false,
            army: false,
          },
          4: {
            piece: false,
            territory: false,
            army: false,
          },
          5: {
            piece: false,
            territory: false,
            army: false,
          },
        },
        5: {
          1: {
            piece: false,
            territory: false,
            army: false,
          },
          2: {
            piece: false,
            territory: false,
            army: false,
          },
          3: {
            piece: false,
            territory: false,
            army: false,
          },
          4: {
            piece: false,
            territory: false,
            army: false,
          },
          5: {
            piece: false,
            territory: false,
            army: false,
          },
        },
      },

      selectedItemForMenu: {},

      itemMenuSelected: false,

      menuInformation: {
        1: {
          i: 'bx-landscape',
          text: 'тип местности',
          shortText: 'местность',
        },
        2: {
          i: 'bx-star',
          text: 'тип ячейки',
          shortText: 'тип ячейки',
        },
        3: {
          i: 'bx-data',
          text: 'ресурсы',
          shortText: 'ресурсы',
        },
        4: {
          i: 'bx-buildings',
          text: 'строение',
          shortText: '',
        },
        5: {
          i: 'bx-user',
          text: 'владелец',
          shortText: 'владелец',
        },
        6: {
          i: 'bx-male',
          text: 'войско',
          shortText: 'войско',
        },
      },

      menuMonster: {
        1: {
          i: 'bxs-skull',
          text: 'тип монстра',
        },
        2: {
          i: 'bxs-radiation',
          text: 'сила монстра',
        },
        3: {
          i: 'bx-shield-quarter',
          text: 'HP монстра',
        },
        4: {
          i: 'bxs-joystick-button',
          text: 'осталось ходов в данный период',
        },
        5: {
          i: 'bx-radar',
          text: 'количество клеток видимости',
        },
        6: {
          i: 'bxs-bolt',
          text: 'разрушение построек при прохождении',
        },
        7: {
          i: 'bx-water',
          text: 'перемещение по воде',
        },
      },

      menuScout: {
        1: {
          i: 'bxs-joystick-button',
          text: 'осталось ходов в данный период',
        },
        2: {
          i: 'bx-user',
          text: 'представитель дэира',
        },
      },

      menuWarrior: {
        1: {
          i: 'bxs-joystick-button',
          text: 'осталось ходов в данный период',
        },
        2: {
          i: 'bx-user',
          text: 'представитель дэира',
        },
        3: {
          i: 'bx-group',
          text: 'войска с собой',
        },
        4: {
          i: 'bx-user-plus',
          text: 'оставить/взять войска',
        },
      },

      menuKnight: {
        1: {
          i: 'bxs-joystick-button',
          text: 'осталось ходов в данный период',
        },
        2: {
          i: 'bx-user',
          text: 'представитель дэира',
        },
        3: {
          i: 'bx-group',
          text: 'войска с собой',
        },
        4: {
          i: 'bx-user-plus',
          text: 'оставить/взять войска',
        },
      },

      menuBuild: {
        1: {
          i: 'bxs-component',
          type: 1,
        },
        2: {
          i: 'bx-group',
          type: 2,
        },
        3: {
          i: 'bx-anchor',
          type: 3,
        },
        4: {
          i: 'bxs-ship',
          type: 4,
        },
        5: {
          i: 'bxs-castle',
          type: 5,
        },
        6: {
          i: 'bx-shield-quarter',
          type: 6,
        },
      },

      selectedSubAction: {},

      preSelectedDair: {},
      preSelectedGlobalAction: {},
      preSelectedGlobalSubAction1: {},
      preSelectedGlobalSubAction2: {},
      preSelectedGlobalSubAction3: {},
      preSelectedGlobalSubAction4: {},

      selectedDair: {
        id: 2,
        name: 'Фарредеир',
        color: '#be00ff',
        colorSecond: 'rgba(185,54,255,0.26)',
        buildings: [],
        resources: {
          1: 20,
          2: 20,
          3: 20,
          4: 20,
          5: 20,
          6: 20,
        },
        nextResources: {
          1: 0,
          2: 0,
          3: 0,
          4: 0,
          5: 0,
          6: 0,
        },
        url: `url(${require('../assets/images/dairs/farr.jpg')})`,
      },

      selectedGlobalAction: {
        id: 2,
        name: 'Настройка карты',
        url: `url(${require('../assets/images/global/create.png')})`,
      },

      selectedGlobalSubAction1: {
        id: 1,
        name: 'Карта',
        url: `url(${require('../assets/images/subactions/create.jpg')})`,
      },

      selectedGlobalSubAction2: {
        id: 1,
        name: 'Общий вид',
        url: `url(${require('../assets/images/subactions/global.jpg')})`,
      },

      selectedGlobalSubAction3: {
        id: 1,
      },

      selectedGlobalSubAction4: {
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
          name: 'Дэиры',
          url: `url(${require('../assets/images/subactions/map.png')})`,
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

      globalSubActions3: {
        1: {
          id: 1,
        },
        2: {
          id: 2,
        },
        3: {
          id: 3,
        },
        4: {
          id: 4,
        },
        5: {
          id: 5,
        },
      },

      globalSubActions4: {
        1: {
          id: 0,
          name: 'Монстры',
          url: `url(${require('../assets/images/subactions/monster.jpg')})`,
        },
        2: {
          id: 1,
        },
        3: {
          id: 2,
        },
        4: {
          id: 3,
        },
        5: {
          id: 4,
        },
        6: {
          id: 5,
        },
      },

      globalActions: {
        1: {
          id: 1,
          name: 'Создание карты',
          url: `url(${require('../assets/images/global/create.png')})`,
        },
        2: {
          id: 2,
          name: 'Настройка карты',
          url: `url(${require('../assets/images/global/create.png')})`,
        },
        3: {
          id: 3,
          name: 'Строительство в дэирах',
          url: `url(${require('../assets/images/global/create.png')})`,
        },
        4: {
          id: 4,
          name: 'Перемещение юнитов',
          url: `url(${require('../assets/images/global/create.png')})`,
        },
      },

      dairs: [
        {
          id: 1,
          name: 'Наместье Мейстеров',
          color: '#ffd600',
          colorSecond: 'rgba(201, 255, 54, 0.2)',
          resources: {
            1: 0,
            2: 0,
            3: 0,
            4: 0,
            5: 0,
            6: 0,
          },
          url: `url(${require('../assets/images/dairs/meisters.jpg')})`,
        },
        {
          id: 2,
          name: 'Фарредеир',
          color: '#be00ff',
          colorSecond: 'rgba(185,54,255,0.26)',
          buildings: [],
          isStorage: false,
          resources: {
            1: 20,
            2: 20,
            3: 20,
            4: 20,
            5: 20,
            6: 20,
          },
          nextResources: {
            1: 0,
            2: 0,
            3: 0,
            4: 0,
            5: 0,
            6: 0,
          },
          url: `url(${require('../assets/images/dairs/farr.jpg')})`,
        },
        {
          id: 3,
          name: 'Хиллдеир',
          color: '#26ee20',
          colorSecond: 'rgba(74,255,54,0.26)',
          buildings: [],
          isStorage: false,
          resources: {
            1: 20,
            2: 20,
            3: 20,
            4: 20,
            5: 20,
            6: 20,
          },
          nextResources: {
            1: 0,
            2: 0,
            3: 0,
            4: 0,
            5: 0,
            6: 0,
          },
          url: `url(${require('../assets/images/dairs/hill.jpg')})`,
        },
        {
          id: 4,
          name: 'Линдеир',
          color: '#36abff',
          colorSecond: 'rgba(54,171,255,0.25)',
          buildings: [],
          isStorage: false,
          resources: {
            1: 20,
            2: 20,
            3: 20,
            4: 20,
            5: 20,
            6: 20,
          },
          nextResources: {
            1: 0,
            2: 0,
            3: 0,
            4: 0,
            5: 0,
            6: 0,
          },
          url: `url(${require('../assets/images/dairs/lin.jpg')})`,
        },
        {
          id: 5,
          name: 'Аймадеир',
          color: '#ff8400',
          colorSecond: 'rgba(255,188,54,0.26)',
          buildings: [],
          isStorage: false,
          resources: {
            1: 20,
            2: 20,
            3: 20,
            4: 20,
            5: 20,
            6: 20,
          },
          nextResources: {
            1: 0,
            2: 0,
            3: 0,
            4: 0,
            5: 0,
            6: 0,
          },
          url: `url(${require('../assets/images/dairs/aim.jpeg')})`,
        },
        {
          id: 6,
          name: 'Нэрдеир',
          color: '#ff2828',
          colorSecond: 'rgba(255,54,54,0.26)',
          buildings: [],
          isStorage: false,
          resources: {
            1: 20,
            2: 20,
            3: 20,
            4: 20,
            5: 20,
            6: 20,
          },
          nextResources: {
            1: 0,
            2: 0,
            3: 0,
            4: 0,
            5: 0,
            6: 0,
          },
          url: `url(${require('../assets/images/dairs/ner.jpg')})`,
        },
      ],

      groundTypes: {
        1: {
          name: 'Пустошь',
          url: 'grounds/ground.jpg',
        },
        2: {
          name: 'Горная гряда',
          url: 'grounds/mountains.png',
        },
        3: {
          name: 'Лесные заросли',
          url: 'grounds/forest.png',
        },
        4: {
          name: 'Водное пространство',
          url: 'grounds/water.png',
        },
      },

      specialTypes: {
        1: {
          name: 'Обычная земля',
          url: '',
        },
        2: {
          name: 'Место силы',
          url: 'special/special.png',
        },
        3: {
          name: 'Предел',
          url: 'special/hole.png',
        },
        4: {
          name: 'Рынок',
          url: 'special/market.png',
        },
        5: {
          name: 'Защищённая зона',
          url: 'special/piece.png',
        },
      },

      resourcesTypes: {
        1: {
          name: 'Камень',
          i: 'bxs-cube',
          url: 'resources/stone.png',
        },
        2: {
          name: 'Руда',
          i: 'bxs-layer',
          url: 'resources/iron.png',
        },
        3: {
          name: 'Лес',
          i: 'bxs-tree-alt',
          url: 'resources/wood.png',
        },
        4: {
          name: 'Нефа',
          i: 'bxs-cylinder',
          url: 'resources/oil.png',
        },
        5: {
          name: 'Зерно',
          i: 'bxs-florist',
          url: 'resources/food.png',
        },
        6: {
          name: 'Золото',
          i: 'bxs-coin',
          url: '',
        },
      },

      selectedMonsterType: 1,
      monsterPower: 10,
      monsterHP: 10,
      stepsCount: 1,
      visionCount: 1,
      destroyBuildings: false,
      goWater: false,
      goAccessIcon: 'global/go.png',
      goWarnAccessIcon: 'global/goWarn.png',
      goStopAccessIcon: 'global/goStop.png',
      monsterIconStop: 'monsterIcons/iconStop.png',
      monsterIconGo: 'monsterIcons/iconGo.png',
      monsterGo: false,
      scoutGo: false,
      warriorGo: false,
      knightGo: false,

      scoutIcon: 'units/scout.png',
      scoutIconGo: 'units/scoutGo.png',
      scoutIconStop: 'units/scoutStop.png',
      knightIcon: 'units/knight.png',
      warriorIcon: 'units/warrior.png',
      warriorIconGo: 'units/warriorGo.png',
      warriorIconStop: 'units/warriorStop.png',
      knightIconGo: 'units/knightGo.png',
      knightIconStop: 'units/knightStop.png',
      // scoutStepsCount: 7,
      // warriorStepsCount: 4,
      // knightStepsCount: 5,
      scoutStepsCount: 20,
      warriorStepsCount: 20,
      knightStepsCount: 20,
      showMap: true,
      showMenu: true,

      peoplesCount: 0,

      monsterTypes: {
        1: {
          name: 'Падшая душа',
          url: `url(${require('../assets/images/monster/darkSoul.png')})`,
          shortUrl: 'monster/darkSoul.png',
        },
        2: {
          name: 'Голем',
          url: `url(${require('../assets/images/monster/golem.png')})`,
          shortUrl: 'monster/golem.png',
        },
        3: {
          name: 'Орк',
          url: `url(${require('../assets/images/monster/ork.png')})`,
          shortUrl: 'monster/ork.png',
        },
        4: {
          name: 'Тёмный рыцарь',
          url: `url(${require('../assets/images/monster/darkKnight.png')})`,
          shortUrl: 'monster/darkKnight.png',
        },
        5: {
          name: 'Дракон',
          url: `url(${require('../assets/images/monster/dragon.gif')})`,
          shortUrl: 'monster/dragon.gif',
        },
      },

      buildingsTypes: {
        1: {
          name: 'Добывающие установки',
          shortName: 'добыча',
        },
        2: {
          name: 'Казармы',
          shortName: 'казармы',
        },
        3: {
          name: 'Порт',
          shortName: 'порт',
        },
        4: {
          name: 'Корабли',
          shortName: 'корабли',
        },
        5: {
          name: 'Магические сооружения',
          shortName: 'магия',
        },
        6: {
          name: 'Оборонительные сооружения',
          shortName: 'оборона',
        },
      },

      buildings: {
        1: {
          type: 1,
          name: 'Каменоломня',
          performance: 5,
          resource: 1,
          cost: {
            1: 5,
            2: 0,
            3: 5,
            4: 0,
            5: 0,
            6: 0,
          },
          url: 'buildings/stonebuild1.png',
        },
        2: {
          type: 1,
          name: 'Шахта',
          performance: 3,
          resource: 2,
          cost: {
            1: 0,
            2: 5,
            3: 5,
            4: 0,
            5: 0,
            6: 0,
          },
          url: 'buildings/ironbuild1.png',
        },
        3: {
          type: 1,
          name: 'Лесопилка',
          performance: 5,
          resource: 3,
          cost: {
            1: 5,
            2: 0,
            3: 5,
            4: 0,
            5: 0,
            6: 0,
          },
          url: 'buildings/woodbuild1.png',
        },
        4: {
          type: 1,
          name: 'Нефтяная вышка',
          performance: 3,
          resource: 4,
          cost: {
            1: 0,
            2: 5,
            3: 5,
            4: 0,
            5: 0,
            6: 0,
          },
          url: 'buildings/oilbuild1.png',
        },
        5: {
          type: 1,
          name: 'Прииск',
          performance: 3,
          resource: 6,
          cost: {
            1: 0,
            2: 5,
            3: 5,
            4: 0,
            5: 0,
            6: 0,
          },
          url: 'buildings/foodbuild2.png',
        },
        6: {
          type: 5,
          name: 'Хранилище',
          resourcesCount: 5,
          cost: {
            1: 15,
            2: 0,
            3: 10,
            4: 0,
            5: 0,
            6: 0,
          },
          url: 'buildings/foodbuild1.png',
        },
        7: {
          type: 3,
          name: 'Порт',
          cost: {
            1: 0,
            2: 0,
            3: 0,
            4: 0,
            5: 0,
            6: 0,
          },
          url: 'buildings/shipbuild.png',
        },
        8: {
          type: 2,
          name: 'Казарма',
          size: 20,
          cost: {
            1: 15,
            2: 10,
            3: 10,
            4: 0,
            5: 0,
            6: 10,
          },
          url: 'buildings/peoples1.png',
        },
        9: {
          type: 4,
          name: 'Снекка',
          resourcesCount: 20,
          armyCount: 0,
          cost: {
            1: 0,
            2: 0,
            3: 5,
            4: 0,
            5: 0,
            6: 0,
          },
          url: 'buildings/ship1.png',
        },
        10: {
          type: 4,
          name: 'Драккар',
          resourcesCount: 0,
          armyCount: 15,
          cost: {
            1: 0,
            2: 0,
            3: 5,
            4: 5,
            5: 0,
            6: 0,
          },
          url: 'buildings/ship2.png',
        },
        11: {
          type: 5,
          name: 'Столп',
          cost: {
            1: 5,
            2: 0,
            3: 5,
            4: 10,
            5: 0,
            6: 10,
          },
          url: 'buildings/tower.png',
        },
        12: {
          type: 5,
          name: 'Оружейная',
          cost: {
            1: 5,
            2: 10,
            3: 5,
            4: 10,
            5: 0,
            6: 0,
          },
          url: 'buildings/ironbuild2.png',
        },
        13: {
          type: 6,
          name: 'Сторожевая башня',
          hp: 20,
          cost: {
            1: 20,
            2: 0,
            3: 10,
            4: 0,
            5: 0,
            6: 10,
          },
          url: 'buildings/wall1.png',
        },
        14: {
          type: 5,
          name: 'Место силы',
          cost: {
            1: 5,
            2: 5,
            3: 5,
            4: 5,
            5: 0,
            6: 0,
          },
          url: '',
        },
        15: {
          type: 5,
          name: 'Врата',
          cost: {
            1: 0,
            2: 0,
            3: 0,
            4: 0,
            5: 0,
            6: 0,
          },
          url: 'buildings/wall2.png',
        },
      },
    };
  },
  methods: {
    stopPropagation(event) {
      event.stopPropagation();
    },
    getDair() {
      if (!this.isEmpty(this.loadedDairMap)) {
        this.period = this.loadedPeriod;
        this.business = this.loadedBusiness;
        this.history = this.loadedHistory;
        for (let i of this.history) {
          i.date = new Date(i.date);
        }
        this.dairs[0] = this.loadedDairs[0];
        this.dairs[1] = this.loadedDairs[1];
        this.dairs[2] = this.loadedDairs[2];
        this.dairs[3] = this.loadedDairs[3];
        this.dairs[4] = this.loadedDairs[4];
        this.dairs[5] = this.loadedDairs[5];
        this.selectedDair = this.dairs[1];

        let row = [];
        for (let y = 0; y < this.dairSizeY; y++) {
          row = [];
          for (let x = 0; x < this.dairSizeX; x++) {
            if (this.loadedDairMap[y][x].specialType === 3) {
              this.hole.x = x;
              this.hole.y = y;
            }
            row.push({
              groundType: this.loadedDairMap[y][x].groundType,
              specialType: this.loadedDairMap[y][x].specialType,
              resourcesType: this.loadedDairMap[y][x].resourcesType,
              resourcesCount: this.loadedDairMap[y][x].resourcesCount,
              building: this.loadedDairMap[y][x].building,
              owner: this.loadedDairMap[y][x].owner,
              monster: {
                type: this.loadedDairMap[y][x].monster.type,
                power: this.loadedDairMap[y][x].monster.power,
                hp: this.loadedDairMap[y][x].monster.hp,
                stepsCount: this.loadedDairMap[y][x].monster.stepsCount,
                storedStepsCount: this.loadedDairMap[y][x].monster.storedStepsCount,
                visionCount: this.loadedDairMap[y][x].monster.visionCount,
                destroyBuildings: this.loadedDairMap[y][x].monster.destroyBuildings,
                goWater: this.loadedDairMap[y][x].monster.goWater,
              },
              units: {
                scouts: {
                  1: {
                    is: this.loadedDairMap[y][x].units.scouts[1].is,
                    stepsCount: this.loadedDairMap[y][x].units.scouts[1].stepsCount,
                  },
                  2: {
                    is: this.loadedDairMap[y][x].units.scouts[2].is,
                    stepsCount: this.loadedDairMap[y][x].units.scouts[2].stepsCount,
                  },
                  3: {
                    is: this.loadedDairMap[y][x].units.scouts[3].is,
                    stepsCount: this.loadedDairMap[y][x].units.scouts[3].stepsCount,
                  },
                  4: {
                    is: this.loadedDairMap[y][x].units.scouts[4].is,
                    stepsCount: this.loadedDairMap[y][x].units.scouts[4].stepsCount,
                  },
                  5: {
                    is: this.loadedDairMap[y][x].units.scouts[5].is,
                    stepsCount: this.loadedDairMap[y][x].units.scouts[5].stepsCount,
                  },
                },
                warrior: {
                  is: this.loadedDairMap[y][x].units.warrior.is,
                  stepsCount: this.loadedDairMap[y][x].units.warrior.stepsCount,
                  peoples: this.loadedDairMap[y][x].units.warrior.peoples,
                  owner: this.loadedDairMap[y][x].units.warrior.owner,
                },
                knight: {
                  is: this.loadedDairMap[y][x].units.knight.is,
                  stepsCount: this.loadedDairMap[y][x].units.knight.stepsCount,
                  peoples: this.loadedDairMap[y][x].units.knight.peoples,
                  owner: this.loadedDairMap[y][x].units.knight.owner,
                },
              },
              peoples: {
                1: this.loadedDairMap[y][x].peoples[1],
                2: this.loadedDairMap[y][x].peoples[2],
                3: this.loadedDairMap[y][x].peoples[3],
                4: this.loadedDairMap[y][x].peoples[4],
                5: this.loadedDairMap[y][x].peoples[5],
              },
              loadedBuilding: this.loadedDairMap[y][x].loadedBuilding,
              hasAccess: new Set(this.loadedDairMap[y][x].hasAccess),
            });
          }
          this.dairMap.push(row);
        }
      } else {
        let row = [];
        for (let y = 0; y < this.dairSizeY; y++) {
          row = [];
          for (let x = 0; x < this.dairSizeX; x++) {
            row.push({
              groundType: 1,
              specialType: 1,
              resourcesType: -1,
              resourcesCount: 0,
              building: -1,
              owner: -1,
              monster: {
                type: -1,
                power: 0,
                hp: 0,
                stepsCount: 0,
                storedStepsCount: 0,
                visionCount: 0,
                destroyBuildings: false,
                goWater: false,
              },
              units: {
                scouts: {
                  1: {
                    is: false,
                    stepsCount: 0,
                  },
                  2: {
                    is: false,
                    stepsCount: 0,
                  },
                  3: {
                    is: false,
                    stepsCount: 0,
                  },
                  4: {
                    is: false,
                    stepsCount: 0,
                  },
                  5: {
                    is: false,
                    stepsCount: 0,
                  },
                },
                warrior: {
                  is: false,
                  stepsCount: 0,
                  peoples: 0,
                  owner: -1,
                },
                knight: {
                  is: false,
                  stepsCount: 0,
                  peoples: 0,
                  owner: -1,
                },
              },
              peoples: {
                1: 0,
                2: 0,
                3: 0,
                4: 0,
                5: 0,
              },
              loadedBuilding: false,
              hasAccess: new Set(),
            });
          }
          this.dairMap.push(row);
        }
      }
      this.canvas = document.getElementById('dairCanvas');
      this.context = this.canvas.getContext('2d');
      this.loadedImages = 0;
      for (let i of this.imagesSrc) {
        let image = new Image(this.dairZoom - this.spaceSize, this.dairZoom - this.spaceSize);
        image.src = require(`../assets/images/${i}`);
        image.onload = () => {
          this.loadedCount++;
          if (this.loadedCount === this.images.length) {
            this.drawCanvas(true);
          }
        };
        this.images.push(image);
      }
    },
    getDelta(x, y, rowIndex, itemIndex) {
      return (rowIndex === y && itemIndex === x) ?
        0 :
        Math.sqrt((rowIndex - y) ** 2 + (itemIndex - x) ** 2);
    },
    move(e) {
      if (this.canvas === null) {
        return;
      }
      let params = this.getItemPosition(e);
      let rowIndex = Math.floor(params.y / this.dairZoom);
      let itemIndex = Math.floor(params.x / this.dairZoom);
      if (rowIndex < 0) rowIndex = 0;
      if (rowIndex >= this.dairSizeY) rowIndex = this.dairSizeY - 1;
      if (itemIndex < 0) itemIndex = 0;
      if (itemIndex >= this.dairSizeX) itemIndex = this.dairSizeX - 1;

      if (this.cursorPositionY === rowIndex && this.cursorPositionX === itemIndex) {
        return;
      }
      this.cursorPositionY = rowIndex;
      this.cursorPositionX = itemIndex;
      this.oldSelectedItems = this.selectedItems;
      this.selectedItems = [];
      let preSelectedItems = {};
      let tempCursorSize = this.cursorSize - 1;
      for (let y = rowIndex - tempCursorSize; y <= rowIndex + tempCursorSize; y++) {
        for (let x = itemIndex - tempCursorSize; x <= itemIndex + tempCursorSize; x++) {
          if (y < 0 || x < 0 || y >= this.dairSizeY || x >= this.dairSizeX ||
            this.selectedGlobalAction.id === 1 && this.selectedGlobalSubAction1.id === 2 && this.dairMap[y][x].groundType === -1 ||
            this.selectedGlobalAction.id === 4 && this.selectedGlobalSubAction4.id === 0 && this.dairMap[y][x].specialType === 3 ||
            this.selectedGlobalAction.id !== 1 && this.selectedGlobalAction.id !== 4 && this.selectedGlobalSubAction2.id !== 5 && this.isWater(x, y) && !this.nearPort(x, y) ||
            !this.hasAccess(x, y) || this.monsterGoAccess(x, y) || this.scoutGoAccess(x, y) || this.warriorGoAccess(x, y) || this.knightGoAccess(x, y)) {
            continue;
          }

          let item = {
            x: -1,
            y: -1,
            border: {
              top: false,
              right: false,
              left: false,
              bottom: false,
              topLeft: false,
              topRight: false,
              bottomLeft: false,
              bottomRight: false,
            },
          };

          let deltaMiddle = this.getDelta(x, y, rowIndex, itemIndex);

          if (this.cursorForm === 'circle') {
            let appendMiddle = (this.cursorSolid && deltaMiddle <= tempCursorSize ||
              !this.cursorSolid && tempCursorSize - deltaMiddle <= this.cursorSizeDelta && tempCursorSize - deltaMiddle >= 0 &&
              !(tempCursorSize === 1 && (rowIndex === y && itemIndex === x)));
            if (appendMiddle) {
              let deltaTop = this.getDelta(x, y - 1, rowIndex, itemIndex);
              let deltaRight = this.getDelta(x + 1, y, rowIndex, itemIndex);
              let deltaLeft = this.getDelta(x - 1, y, rowIndex, itemIndex);
              let deltaBottom = this.getDelta(x, y + 1, rowIndex, itemIndex);

              let appendTop = y === 0 || !(this.cursorSolid && deltaTop <= tempCursorSize ||
                !this.cursorSolid && tempCursorSize - deltaTop <= this.cursorSizeDelta && tempCursorSize - deltaTop >= 0 &&
                !(tempCursorSize === 1 && (rowIndex === y - 1 && itemIndex === x))) ||
                this.selectedGlobalAction.id === 1 && this.selectedGlobalSubAction1.id === 2 && this.dairMap[y - 1][x].groundType === -1;


              let appendRight = x === this.dairSizeX - 1 || !(this.cursorSolid && deltaRight <= tempCursorSize ||
                !this.cursorSolid && tempCursorSize - deltaRight <= this.cursorSizeDelta && tempCursorSize - deltaRight >= 0 &&
                !(tempCursorSize === 1 && (rowIndex === y && itemIndex === x + 1))) ||
                this.selectedGlobalAction.id === 1 && this.selectedGlobalSubAction1.id === 2 && this.dairMap[y][x + 1].groundType === -1;


              let appendLeft = x === 0 || !(this.cursorSolid && deltaLeft <= tempCursorSize ||
                !this.cursorSolid && tempCursorSize - deltaLeft <= this.cursorSizeDelta && tempCursorSize - deltaLeft >= 0 &&
                !(tempCursorSize === 1 && (rowIndex === y && itemIndex === x - 1))) ||
                this.selectedGlobalAction.id === 1 && this.selectedGlobalSubAction1.id === 2 && this.dairMap[y][x - 1].groundType === -1;


              let appendBottom = y === this.dairSizeY - 1 || !(this.cursorSolid && deltaBottom <= tempCursorSize ||
                !this.cursorSolid && tempCursorSize - deltaBottom <= this.cursorSizeDelta && tempCursorSize - deltaBottom >= 0 &&
                !(tempCursorSize === 1 && (rowIndex === y + 1 && itemIndex === x))) ||
                this.selectedGlobalAction.id === 1 && this.selectedGlobalSubAction1.id === 2 && this.dairMap[y + 1][x].groundType === -1;

              item.x = x;
              item.y = y;
              item.border.top = appendTop;
              item.border.right = appendRight;
              item.border.left = appendLeft;
              item.border.bottom = appendBottom;

              preSelectedItems[x + '_' + y] = item;
            }
          } else if (this.cursorForm === 'square') {
            let appendMiddle = (this.cursorSolid ||
              y === rowIndex - tempCursorSize ||
              y === rowIndex + tempCursorSize ||
              x === itemIndex - tempCursorSize ||
              x === itemIndex + tempCursorSize);

            if (appendMiddle) {
              let appendTop = y === 0 || (y === (rowIndex - tempCursorSize) ||
                (!this.cursorSolid && y === rowIndex + tempCursorSize) && x !== (itemIndex + tempCursorSize) && x !== (itemIndex - tempCursorSize) ||
                this.selectedGlobalAction.id === 1 && this.selectedGlobalSubAction1.id === 2 && this.dairMap[y - 1][x].groundType === -1);

              let appendBottom = y === this.dairSizeY - 1 || (y === (rowIndex + tempCursorSize) ||
                (!this.cursorSolid && y === rowIndex - tempCursorSize) && x !== (itemIndex + tempCursorSize) && x !== (itemIndex - tempCursorSize) ||
                this.selectedGlobalAction.id === 1 && this.selectedGlobalSubAction1.id === 2 && this.dairMap[y + 1][x].groundType === -1);

              let appendRight = x === this.dairSizeX - 1 || (x === (itemIndex + tempCursorSize) ||
                (!this.cursorSolid && x === itemIndex - tempCursorSize) && y !== (rowIndex + tempCursorSize) && y !== (rowIndex - tempCursorSize) ||
                this.selectedGlobalAction.id === 1 && this.selectedGlobalSubAction1.id === 2 && this.dairMap[y][x + 1].groundType === -1);

              let appendLeft = x === 0 || (x === (itemIndex - tempCursorSize) ||
                (!this.cursorSolid && x === itemIndex + tempCursorSize) && y !== (rowIndex + tempCursorSize) && y !== (rowIndex - tempCursorSize) ||
                this.selectedGlobalAction.id === 1 && this.selectedGlobalSubAction1.id === 2 && this.dairMap[y][x - 1].groundType === -1);

              item.x = x;
              item.y = y;
              item.border.top = appendTop;
              item.border.right = appendRight;
              item.border.left = appendLeft;
              item.border.bottom = appendBottom;

              preSelectedItems[x + '_' + y] = item;
            }
          }
        }
      }

      for (let y = rowIndex - tempCursorSize; y <= rowIndex + tempCursorSize; y++) {
        for (let x = itemIndex - tempCursorSize; x <= itemIndex + tempCursorSize; x++) {
          if (!this.isEmpty(preSelectedItems[x + '_' + y]) &&
            !this.isEmpty(preSelectedItems[(x - 1) + '_' + y]) &&
            !this.isEmpty(preSelectedItems[x + '_' + (y - 1)]) &&
            this.isEmpty(preSelectedItems[(x - 1) + '_' + (y - 1)])) {
            preSelectedItems[x + '_' + y].border.topLeft = true;
          }
          if (!this.isEmpty(preSelectedItems[x + '_' + y]) &&
            !this.isEmpty(preSelectedItems[(x + 1) + '_' + y]) &&
            !this.isEmpty(preSelectedItems[x + '_' + (y - 1)]) &&
            this.isEmpty(preSelectedItems[(x + 1) + '_' + (y - 1)])) {
            preSelectedItems[x + '_' + y].border.topRight = true;
          }
          if (!this.isEmpty(preSelectedItems[x + '_' + y]) &&
            !this.isEmpty(preSelectedItems[(x - 1) + '_' + y]) &&
            !this.isEmpty(preSelectedItems[x + '_' + (y + 1)]) &&
            this.isEmpty(preSelectedItems[(x - 1) + '_' + (y + 1)])) {
            preSelectedItems[x + '_' + y].border.bottomLeft = true;
          }
          if (!this.isEmpty(preSelectedItems[x + '_' + y]) &&
            !this.isEmpty(preSelectedItems[(x + 1) + '_' + y]) &&
            !this.isEmpty(preSelectedItems[x + '_' + (y + 1)]) &&
            this.isEmpty(preSelectedItems[(x + 1) + '_' + (y + 1)])) {
            preSelectedItems[x + '_' + y].border.bottomRight = true;
          }
        }
      }

      this.selectedItems = Object.values(preSelectedItems);

      if (this.isDrawing) {
        this.tryDo();
      }
      this.draw();
    },
    clear() {
      this.cursorPositionY = -1;
      this.cursorPositionX = -1;
      this.oldSelectedItems = this.selectedItems;
      this.selectedItems = [];
      this.draw();
    },
    draw() {
      for (let i of this.oldSelectedItems) {
        this.context.clearRect(i.x * this.dairZoom,
          i.y * this.dairZoom,
          this.dairZoom - this.spaceSize,
          this.dairZoom - this.spaceSize);
        this.drawItem(this.getImage(i.x, i.y), i.x, i.y);
      }
      for (let i of this.selectedItems) {
        this.context.clearRect(i.x * this.dairZoom,
          i.y * this.dairZoom,
          this.dairZoom - this.spaceSize,
          this.dairZoom - this.spaceSize);
        this.drawItem(this.getSelectedImages(i.x, i.y), i.x, i.y);
      }
    },
    onDrawEnd(event) {
      if (this.isDrawing) {
        this.isDrawing = false;
        this.drawCanvas(false);
        this.draw();
        this.saveAll();
      }
    },
    tryDo() {
      this.isDrawing = this.selectedItems.length !== 0;
      for (let i of this.selectedItems) {
        if (this.selectedGlobalAction.id === 1) {
          if (this.selectedGlobalSubAction1.id === 1) {
            this.dairMap[i.y][i.x].groundType = this.cursorPlace;
          }
          if (this.selectedGlobalSubAction1.id === 2) {
            this.dairMap[i.y][i.x].owner = this.cursorDair;
          }
        } else if (this.hasAccess(this.selectedItems[0].x, this.selectedItems[0].y)) {
          this.selectedItem = i;
          this.itemMenuSelected = true;
          if (this.monsterGo) {
            this.tryMonsterGo();
          } else if (this.scoutGo) {
            this.tryScoutGo();
          } else if (this.warriorGo) {
            this.tryWarriorGo();
          } else if (this.knightGo) {
            this.tryKnightGo();
          }
          this.monsterGo = this.selectedGlobalAction.id === 4 && this.selectedGlobalSubAction4.id === 0 && this.dairMap[this.selectedItem.y][this.selectedItem.x].monster.type !== -1;
          this.scoutGo = this.selectedGlobalAction.id === 4 && this.selectedGlobalSubAction4.id !== 0 && this.dairMap[this.selectedItem.y][this.selectedItem.x].units.scouts[this.selectedGlobalSubAction4.id].is;
          this.warriorGo = this.selectedGlobalAction.id === 4 && this.selectedGlobalSubAction4.id !== 0 && this.dairMap[this.selectedItem.y][this.selectedItem.x].units.warrior.is && !this.scoutGo && !this.knightGo &&
            this.selectedGlobalSubAction4.id === this.dairMap[this.selectedItem.y][this.selectedItem.x].units.warrior.owner;
          this.knightGo = this.selectedGlobalAction.id === 4 && this.selectedGlobalSubAction4.id !== 0 && this.dairMap[this.selectedItem.y][this.selectedItem.x].units.knight.is && !this.scoutGo &&
            this.selectedGlobalSubAction4.id === this.dairMap[this.selectedItem.y][this.selectedItem.x].units.knight.owner;
          this.reloadSelection();
          this.selectedItemForMenu = this.selectedItem;
          if (this.selectedGlobalAction.id === 4) {
            this.drawCanvas(this.monsterGo || this.scoutGo || this.warriorGo || this.knightGo);
          } else {
            this.draw();
          }
        }
      }
    },
    tryMonsterGo() {
      let scouts = this.getCurrentScoutAccess();
      let dairScouts = this.dairMap[this.selectedItem.y][this.selectedItem.x].units.scouts;
      let monster = this.dairMap[this.selectedItem.y][this.selectedItem.x].monster;
      let knight = this.dairMap[this.selectedItem.y][this.selectedItem.x].units.knight;
      let warrior = this.dairMap[this.selectedItem.y][this.selectedItem.x].units.warrior;
      let monsterSelected = this.itemMenu.monster;

      if (knight.is || warrior.is || scouts.length > 0) {
        this.warAttack.unit = monsterSelected;
        this.warAttack.name = 'Монстр';
        this.warAttack.power = monsterSelected.hp;
        this.warAttack.type = 4;
        this.warAttack.x = this.selectedItemForMenu.x;
        this.warAttack.y = this.selectedItemForMenu.y;
        this.warDefend.x = this.selectedItem.x;
        this.warDefend.y = this.selectedItem.y;
      }

      if (knight.is) {
        this.warDefend.unit = knight;
        this.warDefend.name = 'Князь';
        this.warDefend.owner = knight.owner;
        this.warDefend.power = knight.peoples;
        this.warDefend.type = 3;
        this.warPanelOpen();
      } else if (warrior.is) {
        this.warDefend.unit = warrior;
        this.warDefend.name = 'Воин';
        this.warDefend.owner = warrior.owner;
        this.warDefend.power = warrior.peoples;
        this.warDefend.type = 2;
        this.warPanelOpen();
      } else if (scouts.length > 0) {
        let id = Math.floor(Math.random() * scouts.length);
        this.warDefend.unit = dairScouts[scouts[id]];
        this.warDefend.name = 'Разведчик';
        this.warDefend.owner = scouts[id];
        this.warDefend.type = 1;
        this.warPanelOpen();
      } else {
        monster.type = monsterSelected.type;
        monster.power = monsterSelected.power;
        monster.hp = monsterSelected.hp;
        monster.storedStepsCount = monsterSelected.storedStepsCount;
        monster.stepsCount = monsterSelected.stepsCount - 1;
        monster.visionCount = monsterSelected.visionCount;
        monster.destroyBuildings = monsterSelected.destroyBuildings;
        monster.goWater = monsterSelected.goWater;

        if (monsterSelected.destroyBuildings) {
          this.dairMap[this.selectedItem.y][this.selectedItem.x].building = -1;
        }

        monsterSelected.type = -1;
        monsterSelected.power = 0;
        monsterSelected.hp = 0;
        monsterSelected.storedStepsCount = 0;
        monsterSelected.stepsCount = 0;
        monsterSelected.visionCount = 0;
        monsterSelected.destroyBuildings = false;
        monsterSelected.goWater = false;
        this.saveAll();
      }
    },
    tryScoutGo() {
      let scout = this.dairMap[this.selectedItem.y][this.selectedItem.x].units.scouts[this.selectedGlobalSubAction4.id];
      let monster = this.dairMap[this.selectedItem.y][this.selectedItem.x].monster;
      let scoutSelected = this.itemMenu.units.scouts[this.selectedGlobalSubAction4.id];

      if (monster.type !== -1) {
        this.warAttack.unit = scout;
        this.warAttack.name = 'Разведчик';
        this.warAttack.owner = this.selectedGlobalSubAction4.id;
        this.warAttack.type = 1;
        this.warAttack.x = this.selectedItemForMenu.x;
        this.warAttack.y = this.selectedItemForMenu.y;
        this.warDefend.unit = monster;
        this.warDefend.name = 'Монстр';
        this.warDefend.power = monster.hp;
        this.warDefend.type = 4;
        this.warDefend.x = this.selectedItem.x;
        this.warDefend.y = this.selectedItem.y;
        this.warPanelOpen();
      } else {
        scout.is = true;
        scout.stepsCount = scoutSelected.stepsCount - 1;
        if (this.dairMap[this.selectedItem.y][this.selectedItem.x].owner !== this.selectedGlobalSubAction4.id) {
          this.dairMap[this.selectedItem.y][this.selectedItem.x].hasAccess.add(this.selectedGlobalSubAction4.id);
        }

        scoutSelected.is = false;
        scoutSelected.stepsCount = 0;
        this.saveAll();
      }
    },
    tryWarriorGo() {
      let knight = this.dairMap[this.selectedItem.y][this.selectedItem.x].units.knight;
      let warrior = this.dairMap[this.selectedItem.y][this.selectedItem.x].units.warrior;
      let monster = this.dairMap[this.selectedItem.y][this.selectedItem.x].monster;
      let warriorSelected = this.itemMenu.units.warrior;
      let buildingId = this.dairMap[this.selectedItem.y][this.selectedItem.x].building;

      if (knight.is || warrior.is || monster.type !== -1) {
        this.warAttack.unit = warriorSelected;
        this.warAttack.name = 'Воин';
        this.warAttack.owner = warriorSelected.owner;
        this.warAttack.power = warriorSelected.peoples;
        this.warAttack.type = 2;
        this.warAttack.x = this.selectedItemForMenu.x;
        this.warAttack.y = this.selectedItemForMenu.y;
        this.warDefend.x = this.selectedItem.x;
        this.warDefend.y = this.selectedItem.y;
      }

      if (knight.is) {
        this.warDefend.unit = knight;
        this.warDefend.name = 'Князь';
        this.warDefend.owner = knight.owner;
        this.warDefend.power = knight.peoples;
        this.warDefend.type = 3;
        this.warPanelOpen();
      } else if (warrior.is) {
        this.warDefend.unit = warrior;
        this.warDefend.name = 'Воин';
        this.warDefend.owner = warrior.owner;
        this.warDefend.power = warrior.peoples;
        this.warDefend.type = 2;
        this.warPanelOpen();
      } else if (monster.type !== -1) {
        this.warDefend.unit = monster;
        this.warDefend.name = 'Монстр';
        this.warDefend.power = monster.hp;
        this.warDefend.type = 4;
        this.warPanelOpen();
      } else {
        warrior.is = true;
        warrior.stepsCount = warriorSelected.stepsCount - 1;
        warrior.peoples = warriorSelected.peoples;
        warrior.owner = warriorSelected.owner;

        this.dairMap[this.selectedItem.y][this.selectedItem.x].hasAccess.add(this.dairMap[this.selectedItem.y][this.selectedItem.x].owner);
        if (this.dairMap[this.selectedItem.y][this.selectedItem.x].specialType !== 5 && this.dairMap[this.selectedItem.y][this.selectedItem.x].specialType !== 4 && (this.dairMap[this.selectedItem.y][this.selectedItem.x].owner === -1 || !this.business[this.dairMap[this.selectedItem.y][this.selectedItem.x].owner][this.selectedGlobalSubAction4.id].piece)) {
          this.dairMap[this.selectedItem.y][this.selectedItem.x].owner = this.selectedGlobalSubAction4.id;
        } else {
          this.dairMap[this.selectedItem.y][this.selectedItem.x].hasAccess.add(this.selectedGlobalSubAction4.id);
        }

        if (buildingId !== -1 && this.buildings[buildingId].type === 2 && !this.dairMap[this.selectedItem.y][this.selectedItem.x].loadedBuilding) {
          this.dairMap[this.selectedItem.y][this.selectedItem.x].peoples[this.selectedGlobalSubAction4.id] += this.buildings[buildingId].size;
          this.dairMap[this.selectedItem.y][this.selectedItem.x].loadedBuilding = true;
        }

        if (this.dairMap[this.selectedItemForMenu.y][this.selectedItemForMenu.x].building === this.drakkarBuildingId) {
          if (this.isWater(this.selectedItem.x, this.selectedItem.y) && this.isWater(this.selectedItemForMenu.x, this.selectedItemForMenu.y)) {
            this.dairMap[this.selectedItem.y][this.selectedItem.x].building = this.drakkarBuildingId;
            this.dairMap[this.selectedItemForMenu.y][this.selectedItemForMenu.x].building = -1;
          }
        } else if (this.dairMap[this.selectedItem.y][this.selectedItem.x].building === this.drakkarBuildingId) {
          if (!this.isWater(this.selectedItemForMenu.x, this.selectedItemForMenu.y) && warrior.peoples > this.buildings[this.drakkarBuildingId].armyCount) {
            this.dairMap[this.selectedItemForMenu.y][this.selectedItemForMenu.x].peoples[this.selectedGlobalSubAction4.id] += warrior.peoples - this.buildings[this.drakkarBuildingId].armyCount;
            warrior.peoples = this.buildings[this.drakkarBuildingId].armyCount;
          }
        }

        warriorSelected.is = false;
        warriorSelected.stepsCount = 0;
        warriorSelected.peoples = 0;
        warriorSelected.owner = -1;
        this.saveAll();
      }
    },
    tryKnightGo() {
      let knight = this.dairMap[this.selectedItem.y][this.selectedItem.x].units.knight;
      let warrior = this.dairMap[this.selectedItem.y][this.selectedItem.x].units.warrior;
      let monster = this.dairMap[this.selectedItem.y][this.selectedItem.x].monster;
      let knightSelected = this.itemMenu.units.knight;
      let buildingId = this.dairMap[this.selectedItem.y][this.selectedItem.x].building;

      if (knight.is || warrior.is || monster.type !== -1) {
        this.warAttack.unit = knightSelected;
        this.warAttack.name = 'Князь';
        this.warAttack.owner = knightSelected.owner;
        this.warAttack.power = knightSelected.peoples;
        this.warAttack.type = 3;
        this.warAttack.x = this.selectedItemForMenu.x;
        this.warAttack.y = this.selectedItemForMenu.y;
        this.warDefend.x = this.selectedItem.x;
        this.warDefend.y = this.selectedItem.y;
      }

      if (knight.is) {
        this.warDefend.unit = knight;
        this.warDefend.name = 'Князь';
        this.warDefend.owner = knight.owner;
        this.warDefend.power = knight.peoples;
        this.warDefend.type = 3;
        this.warPanelOpen();
      } else if (warrior.is) {
        this.warDefend.unit = warrior;
        this.warDefend.name = 'Воин';
        this.warDefend.owner = warrior.owner;
        this.warDefend.power = warrior.peoples;
        this.warDefend.type = 2;
        this.warPanelOpen();
      } else if (monster.type !== -1) {
        this.warDefend.unit = monster;
        this.warDefend.name = 'Монстр';
        this.warDefend.power = monster.hp;
        this.warDefend.type = 4;
        this.warPanelOpen();
      } else {
        knight.is = true;
        knight.stepsCount = knightSelected.stepsCount - 1;
        knight.peoples = knightSelected.peoples;
        knight.owner = knightSelected.owner;

        this.dairMap[this.selectedItem.y][this.selectedItem.x].hasAccess.add(this.dairMap[this.selectedItem.y][this.selectedItem.x].owner);

        if (this.dairMap[this.selectedItem.y][this.selectedItem.x].specialType !== 5 && this.dairMap[this.selectedItem.y][this.selectedItem.x].specialType !== 4 && (this.dairMap[this.selectedItem.y][this.selectedItem.x].owner === -1 || !this.business[this.dairMap[this.selectedItem.y][this.selectedItem.x].owner][this.selectedGlobalSubAction4.id].piece)) {
          this.dairMap[this.selectedItem.y][this.selectedItem.x].owner = this.selectedGlobalSubAction4.id;
        } else {
          this.dairMap[this.selectedItem.y][this.selectedItem.x].hasAccess.add(this.selectedGlobalSubAction4.id);
        }

        if (buildingId !== -1 && this.buildings[buildingId].type === 2 && !this.dairMap[this.selectedItem.y][this.selectedItem.x].loadedBuilding) {
          this.dairMap[this.selectedItem.y][this.selectedItem.x].peoples[this.selectedGlobalSubAction4.id] += this.buildings[buildingId].size;
          this.dairMap[this.selectedItem.y][this.selectedItem.x].loadedBuilding = true;
        }

        if (this.dairMap[this.selectedItemForMenu.y][this.selectedItemForMenu.x].building === this.drakkarBuildingId) {
          if (this.isWater(this.selectedItem.x, this.selectedItem.y) && this.isWater(this.selectedItemForMenu.x, this.selectedItemForMenu.y)) {
            this.dairMap[this.selectedItem.y][this.selectedItem.x].building = this.drakkarBuildingId;
            this.dairMap[this.selectedItemForMenu.y][this.selectedItemForMenu.x].building = -1;
          }
        } else if (this.dairMap[this.selectedItem.y][this.selectedItem.x].building === this.drakkarBuildingId) {
          if (!this.isWater(this.selectedItemForMenu.x, this.selectedItemForMenu.y) && knight.peoples > this.buildings[this.drakkarBuildingId].armyCount) {
            this.dairMap[this.selectedItemForMenu.y][this.selectedItemForMenu.x].peoples[this.selectedGlobalSubAction4.id] += knight.peoples - this.buildings[this.drakkarBuildingId].armyCount;
            knight.peoples = this.buildings[this.drakkarBuildingId].armyCount;
          }
        }

        knightSelected.is = false;
        knightSelected.stepsCount = 0;
        knightSelected.peoples = 0;
        knightSelected.owner = -1;
        this.saveAll();
      }
    },
    getItemPosition(e) {
      let x;
      let y;
      if (e.pageX !== undefined && e.pageY !== undefined) {
        x = e.pageX;
        y = e.pageY;
      } else {
        x = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
        y = e.clientY + document.body.scrollTop + document.documentElement.scrollTop;
      }

      x -= this.canvas.getBoundingClientRect().left;
      y -= this.canvas.getBoundingClientRect().top;

      return { x, y };
    },
    getDairSizeX() {
      return this.dairSizeX * this.dairZoom;
    },
    getDairSizeY() {
      return this.dairSizeY * this.dairZoom;
    },
    drawCanvas(isClear) {
      if (isClear) {
        this.oldSelectedItems = [];
        this.selectedItems = [];
      }
      this.context.clearRect(0, 0, this.canvas.width, this.canvas.height);
      this.canvas.width = this.getDairSizeX();
      this.canvas.height = this.getDairSizeY();
      for (let y = 0; y < this.dairSizeY; y++) {
        for (let x = 0; x < this.dairSizeX; x++) {
          this.drawItem(this.getImage(x, y), x, y);
        }
      }
    },
    getSelectedMonsterImage() {
      if (this.selectedGlobalAction.id === 4 && !this.isEmpty(this.itemMenu.monster) && this.itemMenu.monster.type !== -1) {
        return this.images.at(this.imagesSrc.indexOf(this.monsterTypes[this.itemMenu.monster.type].shortUrl));
      }
      return undefined;
    },
    getSelectedScoutImage() {
      if (this.selectedGlobalAction.id === 4 && !this.isEmpty(this.itemMenu.units) && this.itemMenu.units.scouts[this.selectedGlobalSubAction4.id].is) {
        return this.images.at(this.imagesSrc.indexOf(this.scoutIcon));
      }
      return undefined;
    },
    getSelectedWarriorImage() {
      if (this.selectedGlobalAction.id === 4 && !this.isEmpty(this.itemMenu.units) && this.itemMenu.units.warrior.is) {
        return this.images.at(this.imagesSrc.indexOf(this.warriorIcon));
      }
      return undefined;
    },
    getSelectedKnightImage() {
      if (this.selectedGlobalAction.id === 4 && !this.isEmpty(this.itemMenu.units) && this.itemMenu.units.knight.is) {
        return this.images.at(this.imagesSrc.indexOf(this.knightIcon));
      }
      return undefined;
    },
    getSelectedImages(x, y) {
      if (this.selectedGlobalAction.id === 1 && this.selectedGlobalSubAction1.id === 1) {
        return [this.images.at(this.imagesSrc.indexOf(this.groundTypes[this.cursorPlace].url))];
      }
      if (this.selectedGlobalAction.id === 1 && this.selectedGlobalSubAction1.id === 2) {
        if (this.dairMap[y][x].groundType === -1) {
          return [this.getHiddenImage()];
        }
        return [this.images.at(this.imagesSrc.indexOf(this.groundTypes[this.dairMap[y][x].groundType].url))];
      }
      if (this.selectedGlobalAction.id === 2) {
        if (this.dairMap[y][x].groundType === -1) {
          return [this.getHiddenImage()];
        }
      }
      return [this.images.at(this.imagesSrc.indexOf(this.selectionSrc))];
    },
    getHiddenImage() {
      return this.images.at(this.imagesSrc.indexOf(this.hiddenSrc));
    },
    getImage(x, y) {
      let dairMap = this.dairMap[y][x];
      let itemImages = [];
      if (dairMap.groundType === -1) {
        itemImages.push(this.images.at(this.imagesSrc.indexOf(this.hiddenSrc)));
      } else {
        itemImages.push(this.images.at(this.imagesSrc.indexOf(this.groundTypes[dairMap.groundType].url)));
      }
      if (this.selectedGlobalAction.id === 4 && this.selectedGlobalSubAction4.id === 0) {
        if (dairMap.specialType !== 1) {
          itemImages.push(this.images.at(this.imagesSrc.indexOf(this.specialTypes[dairMap.specialType].url)));
        } else if (dairMap.building !== -1) {
          itemImages.push(this.images.at(this.imagesSrc.indexOf(this.buildings[dairMap.building].url)));
        }
        if (dairMap.units.warrior.is) {
          itemImages.push(this.images.at(this.imagesSrc.indexOf(this.warriorIconGo)));
        }
        if (dairMap.units.knight.is) {
          itemImages.push(this.images.at(this.imagesSrc.indexOf(this.knightIconGo)));
        }
        if (this.hasScout(dairMap)) {
          itemImages.push(this.images.at(this.imagesSrc.indexOf(this.scoutIconGo)));
        }
        if (dairMap.monster.type !== -1 && (!this.monsterGo || !(x === this.selectedItem.x && y === this.selectedItem.y))) {
          if (dairMap.monster.stepsCount !== 0) {
            itemImages.push(this.images.at(this.imagesSrc.indexOf(this.monsterIconGo)));
          } else {
            itemImages.push(this.images.at(this.imagesSrc.indexOf(this.monsterIconStop)));
          }
        }
        if (this.monsterGo && !this.monsterGoAccess(x, y)) {
          itemImages.push(this.images.at(this.imagesSrc.indexOf(this.getMonsterGoImage(this.itemMenu.monster.stepsCount))));
        }
      } else if (this.selectedGlobalAction.id !== 1) {
        if ((this.selectedGlobalSubAction2.id === 1 || this.selectedGlobalSubAction2.id === 4) && dairMap.specialType === 2 && this.selectedGlobalAction.id !== 4) {
            itemImages.push(this.images.at(this.imagesSrc.indexOf(this.specialTypes[dairMap.specialType].url)));
        }
        if (this.selectedGlobalAction.id === 4) {
          if (this.showMap) {
            if (dairMap.specialType === 2) {
              itemImages.push(this.images.at(this.imagesSrc.indexOf(this.specialTypes[dairMap.specialType].url)));
            }
            if (dairMap.specialType > 2) {
              itemImages.push(this.images.at(this.imagesSrc.indexOf(this.specialTypes[dairMap.specialType].url)));
            } else if (dairMap.building !== -1) {
              itemImages.push(this.images.at(this.imagesSrc.indexOf(this.buildings[dairMap.building].url)));
            } else if (dairMap.resourcesType !== -1) {
              itemImages.push(this.images.at(this.imagesSrc.indexOf(this.resourcesTypes[dairMap.resourcesType].url)));
            }
          }
          if (dairMap.owner !== this.selectedGlobalSubAction4.id && !dairMap.hasAccess.has(this.selectedGlobalSubAction4.id) && dairMap.specialType !== 4 && dairMap.specialType !== 5 && !this.hasBusinessAccess(x, y)) {
            itemImages.push(this.images.at(this.imagesSrc.indexOf(this.hiddenSrc)));
          }
          if (dairMap.monster.type !== -1) {
            if (dairMap.monster.stepsCount !== 0) {
              itemImages.push(this.images.at(this.imagesSrc.indexOf(this.monsterIconGo)));
            } else {
              itemImages.push(this.images.at(this.imagesSrc.indexOf(this.monsterIconStop)));
            }
          }
          if (dairMap.units.warrior.is && (!this.warriorGo || !(x === this.selectedItem.x && y === this.selectedItem.y))) {
            if (dairMap.units.warrior.stepsCount !== 0) {
              itemImages.push(this.images.at(this.imagesSrc.indexOf(this.warriorIconGo)));
            } else {
              itemImages.push(this.images.at(this.imagesSrc.indexOf(this.warriorIconStop)));
            }
          }
          if (dairMap.units.knight.is && (!this.knightGo || !(x === this.selectedItem.x && y === this.selectedItem.y))) {
            if (dairMap.units.knight.stepsCount !== 0) {
              itemImages.push(this.images.at(this.imagesSrc.indexOf(this.knightIconGo)));
            } else {
              itemImages.push(this.images.at(this.imagesSrc.indexOf(this.knightIconStop)));
            }
          }
          if (dairMap.units.scouts[this.selectedGlobalSubAction4.id].is && (!this.scoutGo || !(x === this.selectedItem.x && y === this.selectedItem.y))) {
            if (dairMap.units.scouts[this.selectedGlobalSubAction4.id].stepsCount !== 0) {
              itemImages.push(this.images.at(this.imagesSrc.indexOf(this.scoutIconGo)));
            } else {
              itemImages.push(this.images.at(this.imagesSrc.indexOf(this.scoutIconStop)));
            }
          }
          if (this.scoutGo && !this.scoutGoAccess(x, y)) {
            itemImages.push(this.images.at(this.imagesSrc.indexOf(this.getUnitGoImage(this.itemMenu.units.scouts[this.selectedGlobalSubAction4.id].stepsCount))));
          }
          if (this.warriorGo && !this.warriorGoAccess(x, y)) {
            itemImages.push(this.images.at(this.imagesSrc.indexOf(this.getUnitGoImage(this.itemMenu.units.warrior.stepsCount))));
          }
          if (this.knightGo && !this.knightGoAccess(x, y)) {
            itemImages.push(this.images.at(this.imagesSrc.indexOf(this.getUnitGoImage(this.itemMenu.units.knight.stepsCount))));
          }
        } else if ((this.selectedGlobalSubAction2.id === 1 || this.selectedGlobalSubAction2.id === 4) && dairMap.specialType > 2) {
            itemImages.push(this.images.at(this.imagesSrc.indexOf(this.specialTypes[dairMap.specialType].url)));
        } else if ((this.selectedGlobalSubAction2.id === 1 || this.selectedGlobalSubAction2.id === 3) && dairMap.building !== -1) {
            itemImages.push(this.images.at(this.imagesSrc.indexOf(this.buildings[dairMap.building].url)));
        } else if (this.selectedGlobalSubAction2.id !== 4 && this.selectedGlobalSubAction2.id !== 5 && dairMap.resourcesType !== -1) {
            itemImages.push(this.images.at(this.imagesSrc.indexOf(this.resourcesTypes[dairMap.resourcesType].url)));
        } else if (this.selectedGlobalSubAction2.id === 5) {
          if (dairMap.units.warrior.is) {
            if (dairMap.units.warrior.stepsCount !== 0) {
              itemImages.push(this.images.at(this.imagesSrc.indexOf(this.warriorIconGo)));
            } else {
              itemImages.push(this.images.at(this.imagesSrc.indexOf(this.warriorIconStop)));
            }
          }
          if (dairMap.units.knight.is) {
            if (dairMap.units.knight.stepsCount !== 0) {
              itemImages.push(this.images.at(this.imagesSrc.indexOf(this.knightIconGo)));
            } else {
              itemImages.push(this.images.at(this.imagesSrc.indexOf(this.knightIconStop)));
            }
          }
          if (this.hasScout(dairMap)) {
            itemImages.push(this.images.at(this.imagesSrc.indexOf(this.scoutIconGo)));
          }
          if (dairMap.monster.type !== -1) {
            if (dairMap.monster.stepsCount !== 0) {
              itemImages.push(this.images.at(this.imagesSrc.indexOf(this.monsterIconGo)));
            } else {
              itemImages.push(this.images.at(this.imagesSrc.indexOf(this.monsterIconStop)));
            }
          }
        }
      }
      return itemImages;
    },
    reloadSelection() {
      if (!this.isEmpty(this.selectedItemForMenu)) {
        this.context.clearRect(this.selectedItemForMenu.x * this.dairZoom,
          this.selectedItemForMenu.y * this.dairZoom,
          this.dairZoom - this.spaceSize,
          this.dairZoom - this.spaceSize);
        this.drawItem(this.getImage(this.selectedItemForMenu.x, this.selectedItemForMenu.y), this.selectedItemForMenu.x, this.selectedItemForMenu.y);
      }
    },
    hasAccess(x, y) {
      this.hasBusinessAccess(x, y);
      return this.selectedGlobalAction.id === 1
        || this.selectedGlobalAction.id === 2 && this.dairMap[y][x].groundType !== -1
        || this.selectedGlobalAction.id === 3 && this.selectedGlobalSubAction3.id === this.dairMap[y][x].owner
        || this.selectedGlobalAction.id === 4 && this.selectedGlobalSubAction4.id !== 0 &&
            (this.selectedGlobalSubAction4.id === this.dairMap[y][x].owner ||
              this.hasBusinessAccess(x, y) ||
              this.dairMap[y][x].hasAccess.has(this.selectedGlobalSubAction4.id) ||
              this.dairMap[y][x].specialType === 4 ||
              this.dairMap[y][x].specialType === 5 ||
              (this.scoutGo && !this.scoutGoAccess(x, y)) ||
              (this.knightGo && !this.knightGoAccess(x, y)))
        || this.selectedGlobalAction.id === 4 && this.selectedGlobalSubAction4.id === 0 && this.dairMap[y][x].groundType !== -1 &&
            (!this.monsterGo && (this.dairMap[y][x].monster.type !== -1 || this.dairMap[y][x].specialType === 3 || this.nearHole(x, y)) || this.monsterVision(x, y));
    },
    hasBusinessAccess(x, y) {
      return this.selectedGlobalSubAction4.id !== 0 &&
        (this.dairMap[y][x].owner !== -1 && this.business[this.dairMap[y][x].owner][this.selectedGlobalSubAction4.id].territory ||
        this.business[1][this.selectedGlobalSubAction4.id].territory && this.dairMap[y][x].hasAccess.has(1) ||
        this.business[2][this.selectedGlobalSubAction4.id].territory && this.dairMap[y][x].hasAccess.has(2) ||
        this.business[3][this.selectedGlobalSubAction4.id].territory && this.dairMap[y][x].hasAccess.has(3) ||
        this.business[4][this.selectedGlobalSubAction4.id].territory && this.dairMap[y][x].hasAccess.has(4) ||
        this.business[5][this.selectedGlobalSubAction4.id].territory && this.dairMap[y][x].hasAccess.has(5));
    },
    monsterVision(x, y) {
      if (this.monsterGo) {
        let monster = this.itemMenu.monster;
        return y >= this.selectedItem.y - monster.visionCount &&
        y <= this.selectedItem.y + monster.visionCount &&
        x >= this.selectedItem.x - monster.visionCount &&
        x <= this.selectedItem.x + monster.visionCount;

        // let delta = this.getDelta(x, y, this.selectedItem.y, this.selectedItem.x);
        //
        // return delta <= monster.visionCount;
      }
      return false;
    },
    monsterGoAccess(x, y) {
      if (this.monsterGo) {
        let monster = this.dairMap[y][x].monster;
        return this.itemMenu.monster.stepsCount <= 0 ||
          (x === this.selectedItem.x && y === this.selectedItem.y) ||
          this.dairMap[y][x].specialType === 3 ||
          this.dairMap[y][x].specialType === 4 ||
          this.dairMap[y][x].specialType === 5 ||
          this.isWater(x, y) && !this.itemMenu.monster.goWater ||
          monster.type !== -1 ||
          y < this.selectedItem.y - 1 ||
          y > this.selectedItem.y + 1 ||
          x < this.selectedItem.x - 1 ||
          x > this.selectedItem.x + 1;
      }
      return false;
    },
    scoutGoAccess(x, y) {
      if (this.scoutGo) {
        let scout = this.itemMenu.units.scouts[this.selectedGlobalSubAction4.id];
        return scout.stepsCount <= 0 ||
          this.dairMap[y][x].units.scouts[this.selectedGlobalSubAction4.id].is ||
          (x === this.selectedItem.x && y === this.selectedItem.y) ||
          this.dairMap[y][x].specialType === 3 ||
          y < this.selectedItem.y - 1 ||
          y > this.selectedItem.y + 1 ||
          x < this.selectedItem.x - 1 ||
          x > this.selectedItem.x + 1;
      }
      return false;
    },
    warriorGoAccess(x, y) {
      if (this.warriorGo) {
        let warrior = this.itemMenu.units.warrior;
        return warrior.stepsCount <= 0 ||
          this.dairMap[y][x].units.warrior.is && this.dairMap[y][x].owner === this.selectedGlobalSubAction4.id ||
          this.dairMap[y][x].units.knight.is && this.dairMap[y][x].owner === this.selectedGlobalSubAction4.id ||
          this.isWater(x, y) && this.dairMap[y][x].building !== this.drakkarBuildingId && this.dairMap[this.selectedItem.y][this.selectedItem.x].building !== this.drakkarBuildingId ||
          this.dairMap[y][x].specialType === 3 ||
          (x === this.selectedItem.x && y === this.selectedItem.y) ||
          y < this.selectedItem.y - 1 ||
          y > this.selectedItem.y + 1 ||
          x < this.selectedItem.x - 1 ||
          x > this.selectedItem.x + 1;
      }
      return false;
    },
    knightGoAccess(x, y) {
      if (this.knightGo) {
        let knight = this.itemMenu.units.knight;
        return knight.stepsCount <= 0 ||
          this.dairMap[y][x].units.warrior.is && this.dairMap[y][x].owner === this.selectedGlobalSubAction4.id ||
          this.dairMap[y][x].units.knight.is && this.dairMap[y][x].owner === this.selectedGlobalSubAction4.id ||
          this.isWater(x, y) && this.dairMap[y][x].building !== this.drakkarBuildingId && this.dairMap[this.selectedItem.y][this.selectedItem.x].building !== this.drakkarBuildingId ||
          this.dairMap[y][x].specialType === 3 ||
          (x === this.selectedItem.x && y === this.selectedItem.y) ||
          y < this.selectedItem.y - 1 ||
          y > this.selectedItem.y + 1 ||
          x < this.selectedItem.x - 1 ||
          x > this.selectedItem.x + 1;
      }
      return false;
    },
    hasScout(dairMap) {
      return dairMap.units.scouts[1].is ||
        dairMap.units.scouts[2].is ||
        dairMap.units.scouts[3].is ||
        dairMap.units.scouts[4].is ||
        dairMap.units.scouts[5].is;
    },
    nearHole(x, y) {
      let xM = x - 1;
      let xP = x + 1;
      let yM = y - 1;
      let yP = y + 1;
      return this.exists(x, y) &&
        (this.isHole(xM, yM) ||
        this.isHole(x, yM) ||
        this.isHole(xP, yM) ||
        this.isHole(xM, y) ||
        this.isHole(xP, y) ||
        this.isHole(xM, yP) ||
        this.isHole(x, yP) ||
        this.isHole(xP, yP));
    },
    nearPort(x, y) {
      let xM = x - 1;
      let xP = x + 1;
      let yM = y - 1;
      let yP = y + 1;
      return this.exists(x, y) &&
        (this.isPort(xM, yM) ||
        this.isPort(x, yM) ||
        this.isPort(xP, yM) ||
        this.isPort(xM, y) ||
        this.isPort(xP, y) ||
        this.isPort(xM, yP) ||
        this.isPort(x, yP) ||
        this.isPort(xP, yP));
    },
    nearWater(x, y) {
      let xM = x - 1;
      let xP = x + 1;
      let yM = y - 1;
      let yP = y + 1;
      return this.exists(x, y) &&
        (this.isWater(xM, yM) ||
        this.isWater(x, yM) ||
        this.isWater(xP, yM) ||
        this.isWater(xM, y) ||
        this.isWater(xP, y) ||
        this.isWater(xM, yP) ||
        this.isWater(x, yP) ||
        this.isWater(xP, yP));
    },
    getMonsterGoImage(count) {
      if (count > 3) {
        return this.goAccessIcon;
      }
      if (count === 3 || count === 2) {
        return this.goWarnAccessIcon;
      }
      return this.goStopAccessIcon;
    },
    getUnitGoImage(count) {
      if (count > 3) {
        return this.goAccessIcon;
      }
      if (count <= 3 && count !== 1) {
        return this.goWarnAccessIcon;
      }
      return this.goStopAccessIcon;
    },
    exists(x, y) {
      if (x < 0 || x >= this.dairSizeX) {
        return false;
      }
      if (y < 0 || y >= this.dairSizeY) {
        return false;
      }
      return true;
    },
    isHole(x, y) {
      return this.exists(x, y) && this.dairMap[y][x].specialType === 3;
    },
    isPort(x, y) {
      return this.exists(x, y) && this.dairMap[y][x].building === this.portBuildingId;
    },
    isWater(x, y) {
      return this.exists(x, y) && this.dairMap[y][x].groundType === 4;
    },
    drawItem(images, x, y) {
      if (!this.hasAccess(x, y)) {
        this.context.drawImage(this.getHiddenImage(),
          x * this.dairZoom,
          y * this.dairZoom,
          this.dairZoom - this.spaceSize,
          this.dairZoom - this.spaceSize);
        return;
      }
      for (let i = 0; i < images.length; i++) {
        this.context.drawImage(images[i],
          x * this.dairZoom,
          y * this.dairZoom,
          this.dairZoom - this.spaceSize,
          this.dairZoom - this.spaceSize);
      }
      this.drawOwner(x, y);
      this.drawPeoples(x, y);
      if (this.monsterGo) {
        this.drawMonster();
      } else if (this.scoutGo) {
        this.drawScout();
      } else if (this.warriorGo) {
        this.drawWarrior();
      } else if (this.knightGo) {
        this.drawKnight();
      } else {
        this.drawSelection();
        this.drawHole();
      }
    },
    initLines(color) {
      let delta = 8 * (this.dairZoom / this.maxDairZoom);
      delta = delta < 2 ? 2 : delta;
      this.context.strokeStyle = color;
      this.context.lineWidth = delta;
      return delta;
    },
    drawTop(x, y, color) {
      let delta = this.initLines(color);
      let startX = x * this.dairZoom;
      let startY = y * this.dairZoom + delta / 2;
      let size = this.dairZoom - this.spaceSize;

      this.context.beginPath();
      this.context.moveTo(startX, startY);
      this.context.lineTo(startX + size, startY);
      this.context.stroke();
    },
    drawLeft(x, y, color) {
      let delta = this.initLines(color);
      let startX = x * this.dairZoom + delta / 2;
      let startY = y * this.dairZoom;
      let size = this.dairZoom - this.spaceSize;

      this.context.beginPath();
      this.context.moveTo(startX, startY);
      this.context.lineTo(startX, startY + size);
      this.context.stroke();
    },
    drawRight(x, y, color) {
      let delta = this.initLines(color);
      let startX = x * this.dairZoom - delta / 2;
      let startY = y * this.dairZoom;
      let size = this.dairZoom - this.spaceSize;

      this.context.beginPath();
      this.context.moveTo(startX + size, startY);
      this.context.lineTo(startX + size, startY + size);
      this.context.stroke();
    },
    drawBottom(x, y, color) {
      let delta = this.initLines(color);
      let startX = x * this.dairZoom;
      let startY = y * this.dairZoom - delta / 2;
      let size = this.dairZoom - this.spaceSize;

      this.context.beginPath();
      this.context.moveTo(startX, startY + size);
      this.context.lineTo(startX + size, startY + size);
      this.context.stroke();
    },
    drawTopLeft(x, y, color) {
      let delta = this.initLines(color);
      let startX = x * this.dairZoom;
      let startY = y * this.dairZoom + delta / 2;

      this.context.beginPath();
      this.context.moveTo(startX, startY);
      this.context.lineTo(startX + delta, startY);
      this.context.stroke();
    },
    drawBottomLeft(x, y, color) {
      let delta = this.initLines(color);
      let startX = x * this.dairZoom;
      let startY = y * this.dairZoom - delta / 2;
      let size = this.dairZoom - this.spaceSize;

      this.context.beginPath();
      this.context.moveTo(startX, startY + size);
      this.context.lineTo(startX + delta, startY + size);
      this.context.stroke();
    },
    drawTopRight(x, y, color) {
      let delta = this.initLines(color);
      let startX = x * this.dairZoom;
      let startY = y * this.dairZoom + delta / 2;
      let size = this.dairZoom - this.spaceSize;

      this.context.beginPath();
      this.context.moveTo(startX + size, startY);
      this.context.lineTo(startX + size - delta, startY);
      this.context.stroke();
    },
    drawBottomRight(x, y, color) {
      let delta = this.initLines(color);
      let startX = x * this.dairZoom;
      let startY = y * this.dairZoom - delta / 2;
      let size = this.dairZoom - this.spaceSize;

      this.context.beginPath();
      this.context.moveTo(startX + size, startY + size);
      this.context.lineTo(startX + size - delta, startY + size);
      this.context.stroke();
    },
    drawMonster() {
      let image = this.getSelectedMonsterImage();
      if (image !== undefined) {
        let x = this.selectedItem.x;
        let y = this.selectedItem.y;
        let w = 290 / 2 * this.dairZoom / this.maxDairZoom;
        let h = 200 / 2 * this.dairZoom / this.maxDairZoom;
        this.context.drawImage(image,
          x * this.dairZoom + this.dairZoom / 2 - w / 2,
          y * this.dairZoom + this.dairZoom / 2 - h / 2,
          w, h);
      }
    },
    drawScout() {
      let image = this.getSelectedScoutImage();
      if (image !== undefined) {
        let x = this.selectedItem.x;
        let y = this.selectedItem.y;
        let w = 84 / 2 * this.dairZoom / this.maxDairZoom;
        let h = 200 / 2 * this.dairZoom / this.maxDairZoom;
        this.context.drawImage(image,
          x * this.dairZoom + this.dairZoom / 2 - w / 2,
          y * this.dairZoom + this.dairZoom / 2 - h / 2,
          w, h);
      }
    },
    drawWarrior() {
      let image = this.getSelectedWarriorImage();
      if (image !== undefined) {
        let x = this.selectedItem.x;
        let y = this.selectedItem.y;
        let w = 131 / 2 * this.dairZoom / this.maxDairZoom;
        let h = 200 / 2 * this.dairZoom / this.maxDairZoom;
        this.context.drawImage(image,
          x * this.dairZoom + this.dairZoom / 2 - w / 2,
          y * this.dairZoom + this.dairZoom / 2 - h / 2,
          w, h);
      }
    },
    drawKnight() {
      let image = this.getSelectedKnightImage();
      if (image !== undefined) {
        let x = this.selectedItem.x;
        let y = this.selectedItem.y;
        let w = 92 / 2 * this.dairZoom / this.maxDairZoom;
        let h = 200 / 2 * this.dairZoom / this.maxDairZoom;
        this.context.drawImage(image,
          x * this.dairZoom + this.dairZoom / 2 - w / 2,
          y * this.dairZoom + this.dairZoom / 2 - h / 2,
          w, h);
      }
    },
    getPeoplesBusiness() {
      if (this.selectedGlobalAction.id !== 4 || this.selectedGlobalSubAction4.id === 0) {
        return [];
      }
      let peoples = [this.selectedGlobalSubAction4.id];
      if (this.business[1][this.selectedGlobalSubAction4.id].army) {
        peoples.push(1);
      }
      if (this.business[2][this.selectedGlobalSubAction4.id].army) {
        peoples.push(2);
      }
      if (this.business[3][this.selectedGlobalSubAction4.id].army) {
        peoples.push(3);
      }
      if (this.business[4][this.selectedGlobalSubAction4.id].army) {
        peoples.push(4);
      }
      if (this.business[5][this.selectedGlobalSubAction4.id].army) {
        peoples.push(5);
      }
      return peoples.slice(0, 3);
    },
    drawPeoples(x, y) {
      if (this.selectedGlobalAction.id !== 4 || this.selectedGlobalSubAction4.id === 0) {
        return;
      }
      let peoples = this.getPeoplesBusiness();
      let count = 0;
      for (let i of peoples) {
        if (this.dairMap[y][x].peoples[i] !== 0) {
          let len = this.dairMap[y][x].peoples[i].toString().length; // = 1, 2, 3
          this.context.font = (this.dairZoom / 3) + 'px serif';
          this.context.fillStyle = 'black';
          this.context.fillRect((x + 1 - len / 6) * this.dairZoom, (y + count / 3) * this.dairZoom, (this.dairZoom / 6 * len), (this.dairZoom / 3));
          this.context.fillStyle = this.dairs[i].color;
          this.context.fillText(this.dairMap[y][x].peoples[i], (x + 1 - len / 6) * this.dairZoom, (y + count / 3 + 1 / 3 - 0.08) * this.dairZoom);
          count += 1;
        }
      }
    },
    drawOwner(x, y) {
      if (this.dairMap[y][x].owner !== -1 && !(this.selectedGlobalAction.id === 4 && this.selectedGlobalSubAction4.id === 0)) {
        let ownerId = this.dairMap[y][x].owner;
        let owner = this.dairs[ownerId];

        // top
        if (y === 0 || (this.dairMap[y - 1][x].owner === -1 || this.dairMap[y - 1][x].owner !== ownerId)) {
          this.drawTop(x, y, owner.color);
        }

        // bottom
        if (y === this.dairSizeY - 1 || (this.dairMap[y + 1][x].owner === -1 || this.dairMap[y + 1][x].owner !== ownerId)) {
          this.drawBottom(x, y, owner.color);
        }

        // left
        if (x === 0 || (this.dairMap[y][x - 1].owner === -1 || this.dairMap[y][x - 1].owner !== ownerId)) {
          this.drawLeft(x, y, owner.color);
        }

        // right
        if (x === this.dairSizeX - 1 || (this.dairMap[y][x + 1].owner === -1 || this.dairMap[y][x + 1].owner !== ownerId)) {
          this.drawRight(x, y, owner.color);
        }


        // top left
        if (y !== 0 && x !== 0 && this.dairMap[y - 1][x].owner === ownerId && this.dairMap[y][x - 1].owner === ownerId && this.dairMap[y - 1][x - 1].owner !== ownerId) {
          this.drawTopLeft(x, y, owner.color);
        }

        // bottom left
        if (y !== this.dairSizeY - 1 && x !== 0 && this.dairMap[y + 1][x].owner === ownerId && this.dairMap[y][x - 1].owner === ownerId && this.dairMap[y + 1][x - 1].owner !== ownerId) {
          this.drawBottomLeft(x, y, owner.color);
        }

        // bottom right
        if (y !== this.dairSizeY - 1 && x !== this.dairSizeX - 1 && this.dairMap[y + 1][x].owner === ownerId && this.dairMap[y][x + 1].owner === ownerId && this.dairMap[y + 1][x + 1].owner !== ownerId) {
          this.drawBottomRight(x, y, owner.color);
        }

        // top right
        if (y !== 0 && x !== this.dairSizeX - 1 && this.dairMap[y - 1][x].owner === ownerId && this.dairMap[y][x + 1].owner === ownerId && this.dairMap[y - 1][x + 1].owner !== ownerId) {
          this.drawTopRight(x, y, owner.color);
        }
      }
    },
    drawHole() {
      let x = this.hole.x;
      let y = this.hole.y;
      if (this.selectedGlobalAction.id === 4 && this.selectedGlobalSubAction4.id === 0 && this.dairMap[y][x].specialType === 3) {
        let xM = x - 1;
        let xP = x + 1;
        let yM = y - 1;
        let yP = y + 1;

        if (this.nearHole(xM, yM) && this.dairMap[yM][xM].groundType !== -1) {
          this.drawTop(xM, yM, this.holeColor);
          this.drawLeft(xM, yM, this.holeColor);
        }
        if (this.nearHole(x, yM) && this.dairMap[yM][x].groundType !== -1) {
          this.drawTop(x, yM, this.holeColor);
        }
        if (this.nearHole(xP, yM) && this.dairMap[yM][xP].groundType !== -1) {
          this.drawTop(xP, yM, this.holeColor);
          this.drawRight(xP, yM, this.holeColor);
        }

        if (this.nearHole(xM, y) && this.dairMap[y][xM].groundType !== -1) {
          this.drawLeft(xM, y, this.holeColor);
        }
        if (this.nearHole(xP, y) && this.dairMap[y][xP].groundType !== -1) {
          this.drawRight(xP, y, this.holeColor);
        }

        if (this.nearHole(xM, yP) && this.dairMap[yP][xM].groundType !== -1) {
          this.drawBottom(xM, yP, this.holeColor);
          this.drawLeft(xM, yP, this.holeColor);
        }
        if (this.nearHole(x, yP) && this.dairMap[yP][x].groundType !== -1) {
          this.drawBottom(x, yP, this.holeColor);
        }
        if (this.nearHole(xP, yP) && this.dairMap[yP][xP].groundType !== -1) {
          this.drawBottom(xP, yP, this.holeColor);
          this.drawRight(xP, yP, this.holeColor);
        }
      }
    },
    drawSelection() {
      if (this.selectedGlobalAction.id === 1) {
        let color = this.selectedGlobalSubAction1.id === 1 ?
          this.selectionColor :
          this.selectedGlobalSubAction1.id === 2 ?
            this.cursorDair === -1 ?
              this.selectionColor :
              this.dairs[this.cursorDair].color :
            '';
        for (let i of this.selectedItems) {
          if (i.border.top) {
            this.drawTop(i.x, i.y, color);
          }
          if (i.border.bottom) {
            this.drawBottom(i.x, i.y, color);
          }
          if (i.border.left) {
            this.drawLeft(i.x, i.y, color);
          }
          if (i.border.right) {
            this.drawRight(i.x, i.y, color);
          }
          if (i.border.topLeft) {
            this.drawTopLeft(i.x, i.y, color);
          }
          if (i.border.topRight) {
            this.drawTopRight(i.x, i.y, color);
          }
          if (i.border.bottomLeft) {
            this.drawBottomLeft(i.x, i.y, color);
          }
          if (i.border.bottomRight) {
            this.drawBottomRight(i.x, i.y, color);
          }
        }
      } else if (!this.isEmpty(this.selectedItem)) {
        this.drawTop(this.selectedItem.x, this.selectedItem.y, this.selectionColor);
        this.drawBottom(this.selectedItem.x, this.selectedItem.y, this.selectionColor);
        this.drawLeft(this.selectedItem.x, this.selectedItem.y, this.selectionColor);
        this.drawRight(this.selectedItem.x, this.selectedItem.y, this.selectionColor);
      }
    },
    getGroundType() {
      if (!this.itemMenuSelected) {
        return {};
      }
      let groundType = this.dairMap[this.selectedItem.y][this.selectedItem.x].groundType;
      return groundType === -1 ? {} : this.groundTypes[groundType];
    },
    getSpecialType() {
      if (!this.itemMenuSelected) {
        return {};
      }
      let specialType = this.dairMap[this.selectedItem.y][this.selectedItem.x].specialType;
      return specialType === -1 ? {} : this.specialTypes[specialType];
    },
    getResourcesType() {
      if (!this.itemMenuSelected) {
        return {};
      }
      let resourcesType = this.dairMap[this.selectedItem.y][this.selectedItem.x].resourcesType;
      return resourcesType === -1 ? {} : this.resourcesTypes[resourcesType];
    },
    getResourcesCount() {
      if (!this.itemMenuSelected) {
        return {};
      }
      return this.dairMap[this.selectedItem.y][this.selectedItem.x].resourcesCount;
    },
    getBuilding() {
      if (!this.itemMenuSelected) {
        return {};
      }
      let building = this.dairMap[this.selectedItem.y][this.selectedItem.x].building;
      return building === -1 ? {} : this.buildings[building];
    },
    getBuildingManageString(building) {
      let buildingString = building.name;
      if (building.type === 1) {
        buildingString += ' (+' + building.performance + ',  ' + this.resourcesTypes[building.resource].name + ')';
      } else if (building.type === 2) {
        buildingString += ' (' + building.size + ' чел.)';
      } else if (building.type === 4) {
        buildingString += ' (' + (building.resourcesCount === 0 ? '' : building.resourcesCount + ' ед. трюм') + (building.armyCount === 0 ? '' : building.armyCount + ' мест') + ')';
      } else if (building.type === 6) {
        buildingString += ' (' + building.hp + ' hp)';
      }
      return buildingString;
    },
    getOwner() {
      if (!this.itemMenuSelected) {
        return {};
      }
      let owner = this.dairMap[this.selectedItem.y][this.selectedItem.x].owner;
      return owner === -1 ? {} : this.dairs[owner];
    },
    getDairItem() {
      if (!this.itemMenuSelected) {
        return {};
      }
      return this.dairMap[this.selectedItemForMenu.y][this.selectedItemForMenu.x];
    },
    getPeoples() {
      if (!this.itemMenuSelected) {
        return {};
      }
      return this.dairMap[this.selectedItem.y][this.selectedItem.x].peoples[this.selectedGlobalSubAction4.id];
    },
    getPeoplesById(id) {
      if (!this.itemMenuSelected) {
        return {};
      }
      return this.dairMap[this.selectedItem.y][this.selectedItem.x].peoples[id];
    },
    isEmpty(object) {
      return object === undefined || Object.keys(object).length === 0;
    },
    manageSpecial(id) {
      if (id === 3) {
        if (this.hole.x !== -1 && this.hole.y !== -1) {
          this.dairMap[this.hole.y][this.hole.x].specialType = 1;
        }
        this.hole.x = this.selectedItem.x;
        this.hole.y = this.selectedItem.y;
      } else if (this.hole.y === this.selectedItem.y && this.hole.x === this.selectedItem.x) {
        this.hole.x = -1;
        this.hole.y = -1;
      }
      this.itemMenu.dairMap.specialType = id;
      this.drawCanvas(false);
      this.saveAll();
    },
    changeShowMenu() {
      this.showMenu = !this.showMenu;
    },
    downloadMap() {
      let link = document.createElement('a');
      link.download = this.getMapName();
      link.href = this.canvas.toDataURL();
      link.click();
    },
    getMapName() {
      let string = '';
      for (let s of this.selectedGlobalAction.name.split(' ')) {
        // string += s.charAt(0).toUpperCase() + s.slice(1);
        string += s.toLowerCase() + '_';
      }

      let subName = '';
      let id = this.selectedGlobalAction.id;
      if (id === 1) {
        subName = this.selectedGlobalSubAction1.name;
      } else if (id === 2) {
        subName = this.selectedGlobalSubAction2.name;
      } else if (id === 3) {
        subName = this.dairs[this.selectedGlobalSubAction3.id].name;
      } else if (id === 4) {
        if (this.selectedGlobalSubAction4.id === 0) {
          subName = this.selectedGlobalSubAction4.name;
        } else {
          subName = this.dairs[this.selectedGlobalSubAction4.id].name;
        }
      }

      for (let s of subName.split(' ')) {
        // string += s.charAt(0).toUpperCase() + s.slice(1);
        string += s.toLowerCase() + '_';
      }

      return string.slice(0, -1) + '.png';
    },
    showMapChange() {
      this.showMap = !this.showMap;
      this.drawCanvas(false);
    },
    startWarriorPeoples() {
      this.peoplesCount = this.itemMenu.units.warrior.peoples;
    },
    setWarriorPeoples(id) {
      this.itemMenu.dairMap.peoples[id] = this.itemMenu.dairMap.peoples[id] - this.itemMenu.units.warrior.peoples + this.peoplesCount;
      this.peoplesCount = 0;
      this.drawCanvas(false);
      this.saveAll();
    },
    startKnightPeoples() {
      this.peoplesCount = this.itemMenu.units.knight.peoples;
    },
    setKnightPeoples(id) {
      this.itemMenu.dairMap.peoples[id] = this.itemMenu.dairMap.peoples[id] - this.itemMenu.units.knight.peoples + this.peoplesCount;
      this.peoplesCount = 0;
      this.drawCanvas(false);
      this.saveAll();
    },
    clearNextResources() {
      for (let i of this.dairs) {
        if (i.id !== 1) {
          for (let j of [1, 2, 3, 4, 5, 6]) {
            i.nextResources[j] = 0;
          }
          i.isStorage = false;
        }
      }
    },
    nextPeriodPanelOpen() {
      this.periodOpen = true;
      for (let y = 0; y < this.dairSizeY; y++) {
        for (let x = 0; x < this.dairSizeX; x++) {
          let dair = this.dairMap[y][x];
          if (dair.owner !== -1) {
            if (!this.dairs[dair.owner].isStorage) {
              this.dairs[dair.owner].isStorage = (dair.building === 6);
            }
            let nextResources = this.dairs[dair.owner].nextResources;
            // ++
            if (dair.resourcesType === 3 && dair.building !== 3 && dair.resourcesCount > 0) {
              nextResources[3] += 1;
            }
            if (dair.resourcesType === 1 && dair.building !== 1 && dair.resourcesCount > 0) {
              nextResources[1] += 1;
            }
            if (dair.resourcesType === 5 && dair.resourcesCount > 0) {
              nextResources[5] += 1;
            }
            if (dair.building === 5) {
              nextResources[6] += this.buildings[dair.building].performance;
            }
            if (dair.building !== -1 && this.buildings[dair.building].resource === dair.resourcesType) {
              nextResources[dair.resourcesType] += dair.building === 3 || dair.building === 1 ?
                this.buildings[dair.building].performance :
                Math.min(this.buildings[dair.building].performance, dair.resourcesCount);
            }

            // --
            if (dair.building === 2 || dair.building === 4 || dair.building === 5) {
              nextResources[3] -= 3;
            }
            if (dair.building === 8) {
              nextResources[5] -= 20;
              nextResources[6] -= 5;
            }
            if (dair.building === 13) {
              nextResources[1] -= 5;
              nextResources[5] -= 10;
            }
            if (dair.building === 15) {
              nextResources[1] -= 5;
            }
            if (dair.building === 12) {
              nextResources[5] -= 5;
              nextResources[2] -= 3;
              nextResources[6] -= 3;
            }
            if (dair.building === 11) {
              nextResources[5] -= 5;
              nextResources[4] -= 3;
              nextResources[6] -= 3;
            }
            if (dair.building === 7) {
              nextResources[6] -= 2;
            }
            if (dair.building === 9) {
              nextResources[3] -= 2;
              nextResources[5] -= 3;
            }
            if (dair.building === 10) {
              if (dair.units.knight.is) {
                nextResources = this.dairs[dair.units.knight.owner].nextResources;
              } else if (dair.units.warrior.is) {
                nextResources = this.dairs[dair.units.warrior.owner].nextResources;
              }
              nextResources[3] -= 2;
              nextResources[5] -= 5;
            }
          }
        }
      }
    },
    nextPeriodPanelClose() {
      this.periodOpen = false;
      this.clearNextResources();
    },
    marketPanelOpen() {
      this.marketOpen = true;
    },
    marketPanelClose() {
      this.marketOpen = false;
      this.market1 = -1;
      this.resetMarketResources(1, true);
      this.market2 = -1;
      this.resetMarketResources(2, true);
    },
    businessPanelOpen() {
      this.businessOpen = true;
    },
    businessPanelClose() {
      this.businessOpen = false;
      this.market1 = -1;
      this.market2 = -1;
    },
    loadResourcesPanelOpen() {
      this.loadResourcesOpen = true;
    },
    loadResourcesPanelClose() {
      this.loadResourcesOpen = false;
      this.marketPanelClose();
    },
    loadResources() {
      if (!this.notMarket1Selected()) {
        let i = 0;
        let interval = setInterval(() => {
          i++;
          if (i === 7) {
            let id = this.market1;
            this.market1 = -1;
            this.setMarketResources(id);
            this.saveAll();
            clearInterval(interval);
          } else if (this.dairs[this.market1].resources[i] !== this.marketResource1[i]) {
            this.history.push({
              dair: this.market1,
              resource: i,
              count: this.marketResource1[i] - this.dairs[this.market1].resources[i],
              date: new Date(),
              period: this.period,
            });
            this.dairs[this.market1].resources[i] = this.marketResource1[i];
          }
        }, 20);
      }
    },
    getHistory() {
      let dairHistory = [];
      for (let i of this.history) {
        if (this.notMarket1Selected() || i.dair === this.market1) {
          dairHistory.push(i);
        }
      }
      return dairHistory;
    },
    warPanelOpen() {
      this.warOpen = true;
    },
    warPanelClose() {
      this.warOpen = false;
      this.warAttack.unit = {};
      this.warAttack.name = '';
      this.warAttack.type = -1;
      this.warAttack.power = 0;
      this.warAttack.owner = -1;
      this.warAttack.x = -1;
      this.warAttack.y = -1;
      this.warDefend.unit = {};
      this.warDefend.name = '';
      this.warDefend.type = -1;
      this.warDefend.power = 0;
      this.warDefend.owner = -1;
      this.warDefend.x = -1;
      this.warDefend.y = -1;
      this.unselectMenuAction();
    },
    getMarketResources(id) {
      if (id === 1) {
        return this.notMarket1Selected() ? this.dairs[0].resources : this.dairs[this.market1].resources;
      }
      return this.notMarket2Selected() ? this.dairs[0].resources : this.dairs[this.market2].resources;
    },
    isAttackMonster() {
      return this.warAttack.owner === -1;
    },
    isDefendMonster() {
      return this.warDefend.owner === -1;
    },
    winAttack() {
      this.clearAllUnits(this.dairMap[this.warDefend.y][this.warDefend.x]);
      if (this.warAttack.type === 2 || this.warAttack.type === 3) {
        this.warAttack.unit.peoples = this.warAttack.power;
      } else if (this.warAttack.type === 4) {
        this.warAttack.unit.hp = this.warAttack.power;
      }
      this.warPanelClose();
      this.saveAll();
      this.drawCanvas(true);
    },
    winDefend() {
      this.clearAllUnits(this.dairMap[this.warAttack.y][this.warAttack.x]);
      if (this.warDefend.type === 2 || this.warDefend.type === 3) {
        this.warDefend.unit.peoples = this.warDefend.power;
      } else if (this.warDefend.type === 4) {
        this.warDefend.unit.hp = this.warDefend.power;
      }
      this.warPanelClose();
      this.saveAll();
      this.drawCanvas(true);
    },
    notMarket1Selected() {
      return this.market1 === -1;
    },
    notMarket2Selected() {
      return this.market2 === -1;
    },
    getBusinessPiece(id1, id2) {
      return this.business[id1][id2].piece;
    },
    getBusinessTerritory(id1, id2) {
      return this.business[id1][id2].territory;
    },
    getBusinessArmy(id1, id2) {
      return this.business[id1][id2].army;
    },
    setBusinessPiece(id1, id2) {
      if (this.notMarket1Selected() || this.notMarket2Selected()) {
        return;
      }
      this.business[id1][id2].piece = !this.business[id1][id2].piece;
      this.unselectMenuAction();
      this.drawCanvas(false);
      this.saveAll();
    },
    setBusinessTerritory(id1, id2) {
      if (this.notMarket1Selected() || this.notMarket2Selected()) {
        return;
      }
      this.business[id1][id2].territory = !this.business[id1][id2].territory;
      this.unselectMenuAction();
      this.drawCanvas(false);
      this.saveAll();
    },
    setBusinessArmy(id1, id2) {
      if (this.notMarket1Selected() || this.notMarket2Selected()) {
        return;
      }
      this.business[id1][id2].army = !this.business[id1][id2].army;
      this.unselectMenuAction();
      this.drawCanvas(false);
      this.saveAll();
    },
    setMarket1(id) {
      if (id === this.market1) {
        this.resetMarketResources(1, false);
        setTimeout(() => {
          this.market1 = -1;
          this.marketMaxResource1[1] = 0;
          this.marketMaxResource1[2] = 0;
          this.marketMaxResource1[3] = 0;
          this.marketMaxResource1[4] = 0;
          this.marketMaxResource1[5] = 0;
          this.marketMaxResource1[6] = 0;
        }, 10);
      } else if (id !== this.market2) {
        this.resetMarketResources(1, false);
        setTimeout(() => {
          this.market1 = id;
          this.marketMaxResource1[1] = this.dairs[this.market1].resources[1];
          this.marketMaxResource1[2] = this.dairs[this.market1].resources[2];
          this.marketMaxResource1[3] = this.dairs[this.market1].resources[3];
          this.marketMaxResource1[4] = this.dairs[this.market1].resources[4];
          this.marketMaxResource1[5] = this.dairs[this.market1].resources[5];
          this.marketMaxResource1[6] = this.dairs[this.market1].resources[6];
        }, 10);
      }
    },
    setMarketResources(id) {
      if (id === this.market1) {
        this.resetMarketResources(1, false);
        setTimeout(() => {
          this.market1 = -1;
          this.marketMaxResource1[1] = 0;
          this.marketMaxResource1[2] = 0;
          this.marketMaxResource1[3] = 0;
          this.marketMaxResource1[4] = 0;
          this.marketMaxResource1[5] = 0;
          this.marketMaxResource1[6] = 0;
        }, 10);
      } else {
        this.resetMarketResources(1, false);
        setTimeout(() => {
          this.market1 = id;
          this.marketResource1[1] = this.dairs[this.market1].resources[1];
          this.marketResource1[2] = this.dairs[this.market1].resources[2];
          this.marketResource1[3] = this.dairs[this.market1].resources[3];
          this.marketResource1[4] = this.dairs[this.market1].resources[4];
          this.marketResource1[5] = this.dairs[this.market1].resources[5];
          this.marketResource1[6] = this.dairs[this.market1].resources[6];

          this.marketMaxResource1[1] = this.dairs[this.market1].resources[1] + 100;
          this.marketMaxResource1[2] = this.dairs[this.market1].resources[2] + 100;
          this.marketMaxResource1[3] = this.dairs[this.market1].resources[3] + 100;
          this.marketMaxResource1[4] = this.dairs[this.market1].resources[4] + 100;
          this.marketMaxResource1[5] = this.dairs[this.market1].resources[5] + 100;
          this.marketMaxResource1[6] = this.dairs[this.market1].resources[6] + 100;
        }, 10);
      }
    },
    setMarket2(id) {
      if (id === this.market2) {
        this.resetMarketResources(2, false);
        setTimeout(() => {
          this.market2 = -1;
          this.marketMaxResource2[1] = 0;
          this.marketMaxResource2[2] = 0;
          this.marketMaxResource2[3] = 0;
          this.marketMaxResource2[4] = 0;
          this.marketMaxResource2[5] = 0;
          this.marketMaxResource2[6] = 0;
        }, 0);
      } else if (id !== this.market1) {
        this.resetMarketResources(2, false);
        setTimeout(() => {
          this.market2 = id;
          this.marketMaxResource2[1] = this.dairs[this.market2].resources[1];
          this.marketMaxResource2[2] = this.dairs[this.market2].resources[2];
          this.marketMaxResource2[3] = this.dairs[this.market2].resources[3];
          this.marketMaxResource2[4] = this.dairs[this.market2].resources[4];
          this.marketMaxResource2[5] = this.dairs[this.market2].resources[5];
          this.marketMaxResource2[6] = this.dairs[this.market2].resources[6];
        }, 0);
      }
    },
    resetMarketResources(marketId, isFull) {
      if (marketId === 1) {
        this.marketResource1[1] = 0;
        this.marketResource1[2] = 0;
        this.marketResource1[3] = 0;
        this.marketResource1[4] = 0;
        this.marketResource1[5] = 0;
        this.marketResource1[6] = 0;
        if (isFull) {
          this.marketMaxResource1[1] = 0;
          this.marketMaxResource1[2] = 0;
          this.marketMaxResource1[3] = 0;
          this.marketMaxResource1[4] = 0;
          this.marketMaxResource1[5] = 0;
          this.marketMaxResource1[6] = 0;
        }
      } else {
        this.marketResource2[1] = 0;
        this.marketResource2[2] = 0;
        this.marketResource2[3] = 0;
        this.marketResource2[4] = 0;
        this.marketResource2[5] = 0;
        this.marketResource2[6] = 0;
        if (isFull) {
          this.marketMaxResource2[1] = 0;
          this.marketMaxResource2[2] = 0;
          this.marketMaxResource2[3] = 0;
          this.marketMaxResource2[4] = 0;
          this.marketMaxResource2[5] = 0;
          this.marketMaxResource2[6] = 0;
        }
      }
    },
    trade() {
      if (!this.notMarket1Selected() && !this.notMarket2Selected()) {
        let savedMarket1 = this.market1;
        let savedMarket2 = this.market2;

        this.dairs[this.market1].resources[1] += this.marketResource2[1];
        this.dairs[this.market1].resources[1] -= this.marketResource1[1];
        this.dairs[this.market2].resources[1] += this.marketResource1[1];
        this.dairs[this.market2].resources[1] -= this.marketResource2[1];

        this.dairs[this.market1].resources[2] += this.marketResource2[2];
        this.dairs[this.market1].resources[2] -= this.marketResource1[2];
        this.dairs[this.market2].resources[2] += this.marketResource1[2];
        this.dairs[this.market2].resources[2] -= this.marketResource2[2];

        this.dairs[this.market1].resources[3] += this.marketResource2[3];
        this.dairs[this.market1].resources[3] -= this.marketResource1[3];
        this.dairs[this.market2].resources[3] += this.marketResource1[3];
        this.dairs[this.market2].resources[3] -= this.marketResource2[3];

        this.dairs[this.market1].resources[4] += this.marketResource2[4];
        this.dairs[this.market1].resources[4] -= this.marketResource1[4];
        this.dairs[this.market2].resources[4] += this.marketResource1[4];
        this.dairs[this.market2].resources[4] -= this.marketResource2[4];

        this.dairs[this.market1].resources[5] += this.marketResource2[5];
        this.dairs[this.market1].resources[5] -= this.marketResource1[5];
        this.dairs[this.market2].resources[5] += this.marketResource1[5];
        this.dairs[this.market2].resources[5] -= this.marketResource2[5];

        this.dairs[this.market1].resources[6] += this.marketResource2[6];
        this.dairs[this.market1].resources[6] -= this.marketResource1[6];
        this.dairs[this.market2].resources[6] += this.marketResource1[6];
        this.dairs[this.market2].resources[6] -= this.marketResource2[6];

        this.marketPanelClose();
        this.marketPanelOpen();
        this.setMarket1(savedMarket1);
        this.setMarket2(savedMarket2);
        this.saveAll();
      }
    },
    nextPeriod() {
      for (let y = 0; y < this.dairSizeY; y++) {
        for (let x = 0; x < this.dairSizeX; x++) {
          let dair = this.dairMap[y][x];
          if (dair.owner !== -1) {
            if (dair.resourcesType === 3 && dair.building !== 3 && dair.resourcesCount > 0) {
              dair.resourcesCount--;
            }
            if (dair.resourcesType === 1 && dair.building !== 1 && dair.resourcesCount > 0) {
              dair.resourcesCount--;
            }
            if (dair.resourcesType === 5 && dair.resourcesCount > 0) {
              dair.resourcesCount--;
            }
            if (dair.building !== -1 && this.buildings[dair.building].resource === dair.resourcesType) {
              dair.resourcesCount -= dair.building === 3 || dair.building === 1 ?
                0 :
                Math.min(this.buildings[dair.building].performance, dair.resourcesCount);
            }
          }
          if (dair.monster.type !== -1) {
            dair.monster.stepsCount = dair.monster.storedStepsCount;
          }
          if (dair.units.knight.is) {
            dair.units.knight.stepsCount = this.knightStepsCount;
          }
          if (dair.units.warrior.is) {
            dair.units.warrior.stepsCount = this.warriorStepsCount;
          }
          for (let i = 1; i < 6; i++) {
            if (dair.units.scouts[i].is) {
              dair.units.scouts[i].stepsCount = this.scoutStepsCount;
            }
          }
        }
      }
      for (let dair = 1; dair < this.dairs.length; dair++) {
        for (let j = 1; j < 7; j++) {
          this.dairs[dair].resources[j] = this.getNextPeriodResource(dair, j);
        }
      }
      this.period += 1;
      this.nextPeriodPanelClose();
    },
    getAdditionalNextPeriodResource(dairId, resourceId) {
      return this.getNextPeriodResource(dairId, resourceId) - this.dairs[dairId].resources[resourceId];
    },
    getNextPeriodResource(dairId, resourceId) {
      let dair = this.dairs[dairId];
      if (this.period % 2 === 0) {
        if (dair.isStorage) {
          return (dair.resources[resourceId] + dair.nextResources[resourceId] < 0) ?
          0 :
          Math.min(dair.resources[resourceId] + dair.nextResources[resourceId], this.buildings[6].resourcesCount);
        }
        return 0;
      }
      return (dair.resources[resourceId] + dair.nextResources[resourceId] < 0) ?
        0 :
        (dair.resources[resourceId] + dair.nextResources[resourceId]);
    },
    getBuildings() {
      if (this.isEmpty(this.selectedItem) || this.dairMap[this.selectedItem.y][this.selectedItem.x].specialType > 2) {
        return [];
      }
      let buildings = [];
      if (this.isWater(this.selectedItem.x, this.selectedItem.y)) {
        buildings.push(9, 10);
      } else {
        buildings.push(1, 2, 3, 4, 5, 6, 8, 12, 13, 15);
        if (this.nearWater(this.selectedItem.x, this.selectedItem.y)) {
          buildings.push(7);
        }
        if (this.dairMap[this.selectedItem.y][this.selectedItem.x].specialType === 2) {
          buildings.push(11);
        }
        if (this.selectedGlobalAction.id !== 2) {
          buildings.push(14);
        }
      }
      return buildings;
    },
    getBuildingCost(building) {
      return Object.values(this.buildings[building].cost);
    },
    hasResources(cost, type) {
      return this.selectedDair.resources[type] >= cost;
    },
    canBuild(buildingId) {
      let needed = this.buildings[buildingId].cost;
      return !this.hasBuildingsManageAccess ||
        this.selectedDair.resources[1] >= needed[1] &&
        this.selectedDair.resources[2] >= needed[2] &&
        this.selectedDair.resources[3] >= needed[3] &&
        this.selectedDair.resources[4] >= needed[4] &&
        this.selectedDair.resources[5] >= needed[5] &&
        this.selectedDair.resources[6] >= needed[6];
    },
    manageResources(id) {
      this.itemMenu.dairMap.resourcesType = id;
      if (id === -1) {
        this.itemMenu.dairMap.resourcesCount = 0;
      } else {
        this.itemMenu.dairMap.resourcesCount = this.resourcesCount;
      }
      this.reloadSelection();
      this.draw();
      this.saveAll();
    },
    createMonster() {
      let dair = this.dairMap[this.selectedItem.y][this.selectedItem.x];
      dair.monster.type = this.selectedMonsterType;
      dair.monster.power = this.monsterPower;
      dair.monster.hp = this.monsterHP;
      dair.monster.storedStepsCount = this.stepsCount;
      dair.monster.stepsCount = this.stepsCount;
      dair.monster.visionCount = this.visionCount;
      dair.monster.destroyBuildings = this.destroyBuildings;
      dair.monster.goWater = this.goWater;
      this.unselectMenuAction();
      this.draw();
      this.saveAll();
    },
    createScout() {
      let dair = this.dairMap[this.selectedItem.y][this.selectedItem.x];
      dair.units.scouts[dair.owner].is = true;
      dair.units.scouts[dair.owner].stepsCount = this.scoutStepsCount;
      this.unselectMenuAction();
      this.draw();
      this.saveAll();
    },
    createWarrior() {
      let dair = this.dairMap[this.selectedItem.y][this.selectedItem.x];
      dair.units.warrior.is = true;
      dair.units.warrior.stepsCount = this.warriorStepsCount;
      dair.units.warrior.owner = dair.owner;
      this.unselectMenuAction();
      this.draw();
      this.saveAll();
    },
    createKnight() {
      let dair = this.dairMap[this.selectedItem.y][this.selectedItem.x];
      dair.units.knight.is = true;
      dair.units.knight.stepsCount = this.knightStepsCount;
      dair.units.knight.owner = dair.owner;
      this.unselectMenuAction();
      this.draw();
      this.saveAll();
    },
    clearUnits() {
      this.clearAllUnits(this.dairMap[this.selectedItem.y][this.selectedItem.x]);
    },
    clearAllUnits(dairMap) {
      let monster = dairMap.monster;
      let warrior = dairMap.units.warrior;
      let knight = dairMap.units.knight;
      let scouts = dairMap.units.scouts;

      for (let i of [1, 2, 3, 4, 5]) {
        scouts[i].is = false;
        scouts[i].stepsCount = 0;
      }

      monster.type = -1;
      monster.power = 0;
      monster.hp = 0;
      monster.storedStepsCount = 0;
      monster.stepsCount = 0;
      monster.visionCount = 0;
      monster.destroyBuildings = false;
      monster.goWater = false;

      knight.is = false;
      knight.stepsCount = 0;
      knight.peoples = 0;
      knight.owner = -1;

      warrior.is = false;
      warrior.stepsCount = 0;
      warrior.peoples = 0;
      warrior.owner = -1;

      this.unselectMenuAction();
      this.draw();
      this.saveAll();
    },
    manageMonster(monsterId) {
      this.selectedMonsterType = monsterId;
    },
    manageBuilding(buildingId) {
      if (buildingId === -1) {
        this.itemMenu.dairMap.building = -1;
      } else if (this.canBuild(buildingId)) {
        if (buildingId === this.magicGroundId) {
          this.itemMenu.dairMap.specialType = 2;
        } else {
          this.itemMenu.dairMap.building = buildingId;
        }
        if (this.hasBuildingsManageAccess) {
          let building = this.buildings[buildingId];
          this.selectedDair.resources[1] -= building.cost[1];
          this.selectedDair.resources[2] -= building.cost[2];
          this.selectedDair.resources[3] -= building.cost[3];
          this.selectedDair.resources[4] -= building.cost[4];
          this.selectedDair.resources[5] -= building.cost[5];
          this.selectedDair.resources[6] -= building.cost[6];
        }
        if (this.buildings[buildingId].type === 2 && this.itemMenu.dairMap.owner !== -1) {
          this.itemMenu.dairMap.peoples[this.itemMenu.dairMap.owner] += this.buildings[buildingId].size;
          this.itemMenu.dairMap.loadedBuilding = true;
        }
      }
      this.reloadSelection();
      this.draw();
      this.saveAll();
    },
    selectSubAction(action) {
      if (this.isEmpty(this.selectedSubAction) || this.selectedSubAction !== action) {
        this.selectedSubAction = action;
      } else {
        this.selectedSubAction = {};
      }
      this.resourcesCount = this.initialResourcesCount;
    },
    unselectSubAction() {
      this.selectedSubAction = {};
      this.resourcesCount = this.initialResourcesCount;
    },
    selectDair(id) {
      this.selectedDair = this.dairs[id];
      this.unselectSubAction();
      this.drawCanvas(true);
    },
    selectGlobalAction() {
      this.selectedGlobalAction = this.preSelectedGlobalAction;
      this.selectedGlobalSubAction1 = this.globalSubActions1[1];
      this.selectedGlobalSubAction2 = this.globalSubActions2[1];
      this.selectedGlobalSubAction3 = this.globalSubActions3[1];
      this.selectedGlobalSubAction4 = this.globalSubActions4[1];
      if (this.selectedGlobalAction.id === 3) {
        this.selectDair(this.selectedGlobalSubAction3.id);
      }

      if (this.selectedGlobalAction.id !== 1) {
        this.cursorSize = 1;
      } else {
        this.cursorSize = this.savedCursorSize;
        this.cursorForm = this.savedCursorForm;
        this.cursorSolid = this.savedCursorSolid;
        this.cursorPlace = this.savedCursorPlace;
        this.cursorDair = this.savedCursorDair;
      }
      this.unselectMenuAction();
      this.drawCanvas(true);
    },
    selectGlobalSubAction1() {
      this.selectedGlobalSubAction1 = this.preSelectedGlobalSubAction1;
    },
    selectGlobalSubAction2() {
      this.selectedGlobalSubAction2 = this.preSelectedGlobalSubAction2;
      this.drawCanvas(false);
    },
    selectGlobalSubAction3() {
      this.selectedGlobalSubAction3 = this.preSelectedGlobalSubAction3;
      this.selectDair(this.selectedGlobalSubAction3.id);
      this.unselectMenuAction();
    },
    selectGlobalSubAction4() {
      this.selectedGlobalSubAction4 = this.preSelectedGlobalSubAction4;
      this.unselectMenuAction();
      this.drawCanvas(false);
    },
    globalClick(event) {
      this.onDrawEnd(event);
      // this.unselectMenuAction();
    },
    unselectMenuAction() {
      this.selectedItem = {};
      this.itemMenuSelected = false;
      this.collapsedMenu = false;
      if (this.monsterGo) {
        this.selectedItem = {};
        this.monsterGo = false;
        this.drawCanvas(false);
      } else if (this.scoutGo) {
        this.selectedItem = {};
        this.scoutGo = false;
        this.drawCanvas(false);
      } else if (this.warriorGo) {
        this.selectedItem = {};
        this.warriorGo = false;
        this.drawCanvas(false);
      } else if (this.knightGo) {
        this.selectedItem = {};
        this.knightGo = false;
        this.drawCanvas(false);
      } else {
        this.reloadSelection();
        this.selectedItem = {};
        this.unselectSubAction();
      }
    },
    collapseMenu() {
      this.collapsedMenu = !this.collapsedMenu;
    },
    changeCursorParameters(data) {
      this.cursorSolid = data['cursorSolid'];
      this.cursorForm = data['cursorForm'];
      this.cursorSize = data['cursorSize'];
      this.cursorPlace = data['cursorPlace'];
      this.cursorDair = data['cursorDair'];
    },
    saveAll() {
      let data = {
        map: this.dairMap,
        dair1: this.dairs[1],
        dair2: this.dairs[2],
        dair3: this.dairs[3],
        dair4: this.dairs[4],
        dair5: this.dairs[5],
        meisters: this.dairs[0],
        business: this.business,
        history: this.history,
        period: this.period,
      };
      axios.post(this.pathSave, data);
    },
    loadDair() {
      axios.get(this.pathGet)
        .then((res) => {
          this.loadedBusiness = res.data.data.business;
          this.loadedHistory = res.data.data.history;
          this.loadedPeriod = res.data.data.period;
          this.loadedDairMap = res.data.data.map;
          this.loadedDairs[0] = res.data.data.meisters;
          this.loadedDairs[1] = res.data.data.dair1;
          this.loadedDairs[2] = res.data.data.dair2;
          this.loadedDairs[3] = res.data.data.dair3;
          this.loadedDairs[4] = res.data.data.dair4;
          this.loadedDairs[5] = res.data.data.dair5;
          this.getDair();
        });
    },
    getCurrentScoutAccess() {
      let counts = [];
      if (this.dairMap[this.selectedItem.y][this.selectedItem.x].units.scouts[1].is) {
        counts.push(1);
      }
      if (this.dairMap[this.selectedItem.y][this.selectedItem.x].units.scouts[2].is) {
        counts.push(2);
      }
      if (this.dairMap[this.selectedItem.y][this.selectedItem.x].units.scouts[3].is) {
        counts.push(3);
      }
      if (this.dairMap[this.selectedItem.y][this.selectedItem.x].units.scouts[4].is) {
        counts.push(4);
      }
      if (this.dairMap[this.selectedItem.y][this.selectedItem.x].units.scouts[5].is) {
        counts.push(5);
      }

      counts = Array.from(new Set(counts));
      return counts;
    },
  },
  computed: {
    itemMenu() {
      return {
        visible: this.itemMenuSelected,
        text: this.dairLetterPositions[this.selectedItem.y] + ':' + (this.selectedItem.x + 1),
        groundType: this.getGroundType(),
        specialType: this.getSpecialType(),
        resourcesType: this.getResourcesType(),
        resourcesCount: this.getResourcesCount(),
        building: this.getBuilding(),
        owner: this.getOwner(),
        dairMap: this.getDairItem(),
        peoples: this.getPeoples(),
        monster: this.getDairItem()['monster'],
        units: this.getDairItem()['units'],
      };
    },
    itemMenuHeight() {
      if (this.collapsedMenu) {
        return '31px';
      }
      if (this.selectedGlobalAction.id === 2) {
        let id = this.selectedGlobalSubAction2.id;
          if (id === 1) {
            return '280px';
          } else if (id === 2) {
            return '553px';
          } else if (id === 3) {
            if (this.selectedSubAction === this.menuBuild[1]) {
              return '100%';
            } else if (this.selectedSubAction === this.menuBuild[3] || this.selectedSubAction === this.menuBuild[2] || this.selectedSubAction === this.menuBuild[6]) {
              return '620px';
            } else if (this.selectedSubAction === this.menuBuild[4]) {
              return '670px';
            } else if (this.selectedSubAction === this.menuBuild[5]) {
              return '650px';
            }
            return '580px';
          } else if (id === 4) {
            return '465px';
          }
      } else if (this.selectedGlobalAction.id === 3) {
        if (this.selectedSubAction === this.menuBuild[1]) {
          return '100%';
        } else if (this.selectedSubAction === this.menuBuild[3] || this.selectedSubAction === this.menuBuild[2] || this.selectedSubAction === this.menuBuild[6]) {
          return '600px';
        } else if (this.selectedSubAction === this.menuBuild[4]) {
          return '665px';
        } else if (this.selectedSubAction === this.menuBuild[5]) {
          return '692px';
        }
        return '550px';
      } else if (this.selectedGlobalAction.id === 4) {
        let id = this.selectedGlobalSubAction4.id;
        if (id === 0) {
          if (this.hasMonsterAccess) {
            return '655px';
          }
          return '100%';
        }
        if (this.hasScoutAccess || this.hasMonsterAccess || this.hasWarriorAccess || this.hasKnightAccess) {
          return '100%';
        }
        if (this.itemMenu.dairMap.specialType > 2 || this.itemMenu.dairMap.groundType === 4) {
          return '380px';
        }
        if (this.itemMenu.dairMap.owner === this.selectedGlobalSubAction4.id) {
          return '520px';
        }
        return '380px';
      }
      return '445px';
    },
    hasManageAccess() {
      return this.selectedGlobalAction.id === 2 && this.selectedGlobalSubAction2.id === 2;
    },
    hasGoAccess() {
      return this.selectedGlobalAction.id === 4 && this.selectedGlobalSubAction4.id !== 0 &&
        this.itemMenu.dairMap.owner === this.selectedGlobalSubAction4.id &&
        (this.isEmpty(this.itemMenu.monster) || this.itemMenu.monster.type === -1) &&
        (this.isEmpty(this.itemMenu.dairMap.units) ||
          !this.itemMenu.dairMap.units.scouts[this.selectedGlobalSubAction4.id].is &&
          !this.itemMenu.dairMap.units.warrior.is &&
          !this.itemMenu.dairMap.units.knight.is &&
          this.itemMenu.dairMap.groundType !== 4 &&
          this.itemMenu.dairMap.specialType <= 2);
    },
    hasBuildingsAccess() {
      return this.selectedGlobalAction.id === 2 && this.selectedGlobalSubAction2.id === 3 ||
        this.selectedGlobalAction.id === 3;
    },
    hasBuildingsManageAccess() {
      return !(this.selectedGlobalAction.id === 2 && this.selectedGlobalSubAction2.id === 3);
    },
    hasSpecialAccess() {
      return this.selectedGlobalAction.id === 2 && this.selectedGlobalSubAction2.id === 4;
    },
    hasMonsterCreateAccess() {
      return this.selectedGlobalAction.id === 4 && this.selectedGlobalSubAction4.id === 0 &&
        !this.isEmpty(this.selectedItem) && this.nearHole(this.selectedItem.x, this.selectedItem.y) && !this.isEmpty(this.itemMenu.monster) && this.itemMenu.monster.type === -1;
    },
    getUnitsAccess() {
      return this.selectedGlobalSubAction2.id === 5 &&
        (this.hasMonsterAccess || this.hasScoutAccess || this.hasWarriorManageAccess || this.hasKnightManageAccess);
    },
    hasMonsterAccess() {
      return (this.selectedGlobalAction.id === 4 || this.selectedGlobalAction.id === 2 && this.selectedGlobalSubAction2.id === 5) &&
        !this.isEmpty(this.itemMenu.monster) && this.itemMenu.monster.type !== -1;
    },
    hasScoutAccess() {
      let action4 = this.selectedGlobalAction.id === 4 && this.selectedGlobalSubAction4.id !== 0;
      let action5 = this.selectedGlobalAction.id === 2 && this.selectedGlobalSubAction2.id === 5;
      return (action4 || action5) && !this.isEmpty(this.itemMenu.dairMap) &&
        (action4 && this.itemMenu.dairMap.units.scouts[this.selectedGlobalSubAction4.id].is ||
          action5 && this.hasScout(this.itemMenu.dairMap));
    },
    getScoutAccess() {
      if (this.isEmpty(this.itemMenu.dairMap)) {
        return [];
      }
      let action4 = this.selectedGlobalAction.id === 4 && this.selectedGlobalSubAction4.id !== 0;
      let counts = [];
      if (action4) {
        counts.push(this.selectedGlobalSubAction4.id);
      } else {
        if (this.itemMenu.dairMap.units.scouts[1].is) {
          counts.push(1);
        }
        if (this.itemMenu.dairMap.units.scouts[2].is) {
          counts.push(2);
        }
        if (this.itemMenu.dairMap.units.scouts[3].is) {
          counts.push(3);
        }
        if (this.itemMenu.dairMap.units.scouts[4].is) {
          counts.push(4);
        }
        if (this.itemMenu.dairMap.units.scouts[5].is) {
          counts.push(5);
        }
      }
      counts = Array.from(new Set(counts));
      return counts;
    },
    hasWarriorAccess() {
      let action4 = this.selectedGlobalAction.id === 4 && this.selectedGlobalSubAction4.id !== 0;
      let action5 = this.selectedGlobalAction.id === 2 && this.selectedGlobalSubAction2.id === 5;
      return (action4 || action5) && !this.isEmpty(this.itemMenu.dairMap) &&
        this.itemMenu.dairMap.units.warrior.is;
    },
    hasWarriorManageAccess() {
      let action4 = this.selectedGlobalAction.id === 4 && this.selectedGlobalSubAction4.id !== 0;
      let action5 = this.selectedGlobalAction.id === 2 && this.selectedGlobalSubAction2.id === 5;
      return (action4 || action5) && !this.isEmpty(this.itemMenu.dairMap) &&
        this.itemMenu.dairMap.units.warrior.is && (action4 && this.itemMenu.units.warrior.owner === this.selectedGlobalSubAction4.id || action5);
    },
    hasKnightAccess() {
      let action4 = this.selectedGlobalAction.id === 4 && this.selectedGlobalSubAction4.id !== 0;
      let action5 = this.selectedGlobalAction.id === 2 && this.selectedGlobalSubAction2.id === 5;
      return (action4 || action5) && !this.isEmpty(this.itemMenu.dairMap) &&
        this.itemMenu.dairMap.units.knight.is;
    },
    hasKnightManageAccess() {
      let action4 = this.selectedGlobalAction.id === 4 && this.selectedGlobalSubAction4.id !== 0;
      let action5 = this.selectedGlobalAction.id === 2 && this.selectedGlobalSubAction2.id === 5;
      return (action4 || action5) && !this.isEmpty(this.itemMenu.dairMap) &&
        this.itemMenu.dairMap.units.knight.is && (action4 && this.itemMenu.dairMap.units.knight.owner === this.selectedGlobalSubAction4.id || action5);
    },
  },
  created() {
    document.title = this.documentTitle;
  },
  mounted() {
    // window.onbeforeunload = () => true;
    this.loadDair();
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
  min-width: 100%;
  height: 100%;
  flex-direction: column;
  justify-content: center;
  align-items: center;
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
.place {
  background-image: url('../assets/images/global/place.png');
  background-size: contain !important;
  background-repeat: no-repeat;
  background-position: center;
  width: 100%;
  height: 80px;
  position: relative;
  top: -20px;
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
  height: 90px;
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
  width: 21% !important;
}
.top-panel-item-actions-selected {
  width: 30% !important;
}
.top-panel-item-actions-pre-selected {
  width: 23% !important;
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
