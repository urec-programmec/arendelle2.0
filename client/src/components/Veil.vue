<template>
  <main id="dairMap-main" @click="unselectMenuAction">
    <div class="background" :style="{ '--background-before-url': selectedDair.url}"></div>
    <span class="footer top-panel">
      <div style="height: 100%; width: 25%; display: flex; flex-direction: row; align-items: center; justify-content: center;">
        <div :style="{'background-image': dairs[0].url,
                      '--first-color': '2px solid ' + dairs[0].color,
                      '--second-color': '0 0 0 5px ' + dairs[0].colorSecond,
                      'width': '90%'}"
             :class="['top-panel-item', dairs[0].id === selectedDair.id ? 'dairMap-first-selected' : dairs[0].id === preSelectedDair.id ? 'dairMap-first-pre-selected' : '' ]"
             @mouseover="preSelectedDair = dairs[0]" @mouseleave="preSelectedDair = selectedDair" @click="selectDair">
          <p>{{ dairs[0].name }}</p>
        </div>
      </div>
      <i class='bx bx-minus bx-rotate-90' style="margin: 0 5px 0 5px !important; font-size: 1.8em"/>
      <div class="top-panel-container">
        <div v-for="(dairMap, index) in dairs" v-if="dairMap.id !== 1"
             :style="{'background-image': dairMap.url,
                      '--first-color': '2px solid ' + dairMap.color,
                      '--second-color': '0 0 0 5px ' + dairMap.colorSecond}"
             :key="index" :class="['top-panel-item', dairMap.id === selectedDair.id ? 'dairMap-selected' : dairMap.id === preSelectedDair.id ? 'dairMap-pre-selected' : '' ]"
             @mouseover="preSelectedDair = dairMap" @mouseleave="preSelectedDair = selectedDair" @click="selectDair">
          <p>{{ dairMap.name }}</p>
        </div>
      </div>
    </span>
    <div class="dairMap-container">
      <div :style="{ minWidth: getDairSizeX() + 'px',
                     maxWidth: getDairSizeX() + 'px',
                     minHeight: getDairSizeY() + 'px',
                     maxHeight: getDairSizeY() + 'px'}">
        <canvas id="dairCanvas"
                :style="{width: getDairSizeX() + 'px',
                         height: getDairSizeY() + 'px'}"
                @mousemove="move"
                @mouseleave="clear"
                @click="openMenuItem"/>
      </div>
    </div>
    <span class="footer">
      <div v-if="selectedDair.id !== 1" class= "footerResources">
        <div v-for="(resource, index) in selectedDair.resources" :key="index" style="margin-left: 25px">
           <div :style="{ 'display': 'flex', 'align-items': 'center' }">
            <i :class="['bx', resourcesTypes[index].i]" style="font-size: 1.2em"/>
            <div style="font-size: 0.85em; margin-right: 0.5em">{{resourcesTypes[index].name + ':'}}</div>
            <div :style="{ 'font-size': '0.9em', 'color' : selectedDair.resources[index] === 0 ? '#ff4242' : '' }">{{selectedDair.resources[index]}}</div>
          </div>
        </div>
      </div>
      <div v-if="selectedDair.id === 1" class= "footerResources">
         <div class="footerResourcesSettings" @click="nextPeriodPanelOpen">
          <i :class="['bx', 'bx-download', 'bx-rotate-270']" style="font-size: 1.2em; margin-left: 0; color: inherit"/>
          <div style="color: inherit">Следующий период</div>
        </div>
        <div class="footerResourcesSettings" @click="marketPanelOpen">
          <i :class="['bx', 'bx-transfer']" style="font-size: 1.2em; margin-left: 0; color: inherit"/>
          <div style="color: inherit">Торговля</div>
        </div>
      </div>
      <vue-slider v-model="dairZoom"
                  :tooltip-formatter="val => (Math.round((val / minDairZoom) * 10) / 10) + 'x'"
                  :min="minDairZoom"
                  :max="maxDairZoom"
                  :style="{margin: '0',
                           width: '320px'}"
                  @drag-start="() => isResizing = true"
                  @drag-end="() => {isResizing = false; drawCanvas();}"
                  @change="() => {if(!isResizing) drawCanvas()}">
        <template #dot="{ value, focus }" style="display: flex; justify-content: center;">
          <div :class="['custom-dot', { 'custom-dot-focus': focus }]">{{ Math.round((value / minDairZoom) * 10) / 10 }}</div>
        </template>
      </vue-slider>
      <div :style="{ display: 'flex',
                     flexDirection: 'column',
                     'margin-left': '15px'}">
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
        <p style="font-size: 1em">{{ (cursorPositionX === -1 && cursorPositionY === -1) ? '—' : dairLetterPositions[cursorPositionX] + ':' + (cursorPositionY + 1) }}</p>
      </div>
    </span>
    <div id="itemMenu" :style="{ 'opacity' : itemMenu.visible ? '1' : '0', 'right' : itemMenu.visible ? '30px' : '-300px',
                      'height': itemMenuHeight,
                      '--first-color': isEmpty(itemMenu.owner) ? '2px solid rgba(0, 0, 0, 0)' : '2px solid ' + itemMenu.owner.color,
                      '--second-color': isEmpty(itemMenu.owner) ? '' : '0 0 0 5px ' + itemMenu.owner.colorSecond }" @click="stopPropagation">
      <i @click="unselectMenuAction" class='bx bx-x close' style="margin: 0 5px 0 5px !important; font-size: 1.4em; position: absolute; right: 0;"/>
      <p style="margin-bottom: 1.5em;">ячейка {{ itemMenu.visible ? itemMenu.text : '' }}</p>
      <div class="itemMenuInfo">
        <div class="itemMenuContainer">
          <i :class="['bx', menuInformation[1].i]"/>
          <div class="itemMenuText">{{ menuInformation[1].text }}</div>
          <div class="itemMenuValue">{{ isEmpty(itemMenu.groundType) ? '—' : itemMenu.groundType.name }}</div>
        </div>
        <div class="itemMenuContainer">
          <i :class="['bx', menuInformation[2].i]"/>
          <div class="itemMenuText">{{ menuInformation[2].text }}</div>
          <div class="itemMenuValue">{{ isEmpty(itemMenu.specialType) ? '—' : itemMenu.specialType.name }}</div>
        </div>
        <div class="itemMenuContainer">
          <i :class="['bx', menuInformation[3].i]"/>
          <div class="itemMenuText">{{ menuInformation[3].text }}</div>
          <div class="itemMenuValue">{{ isEmpty(itemMenu.resourcesType) ? '—' : (itemMenu.resourcesType.name + ': ' + itemMenu.resourcesCount) }}</div>
        </div>
        <div class="itemMenuContainer" style="height: 38px">
          <i :class="['bx', menuInformation[4].i]"/>
          <div class="itemMenuText">{{ menuInformation[4].text }}</div>
          <div class="itemMenuValue" style="font-size: 0.9em">{{ isEmpty(itemMenu.building) ? '—' : getBuildingString(itemMenu.building) }}</div>
        </div>
        <div class="itemMenuContainer">
          <i :class="['bx', menuInformation[5].i]"/>
          <div class="itemMenuText">{{ menuInformation[5].text }}</div>
          <div class="itemMenuValue">{{ isEmpty(itemMenu.owner) ? '—' : itemMenu.owner.name }}</div>
        </div>
      </div>
      <div class="itemMenuActions">
        <div v-if="dairs[0].id === selectedDair.id && !isEmpty(itemMenu.building)" class="itemMenuContainerActions">
          <div class="itemMenuTextAction">{{ menuActions[1].text }}</div>
          <i :class="[ 'actions', 'bx', menuActions[1].i, selectedAction === menuActions[1] ? 'itemMenuActionsSelected' : '' ]" @click="destroyOpen"></i>
        </div>
        <div v-if="dairs[0].id === selectedDair.id" class="itemMenuContainerActions">
          <div class="itemMenuTextAction">{{ menuActions[2].text }}</div>
          <i :class="[ 'actions', 'bx', menuActions[2].i, selectedAction === menuActions[2] ? 'itemMenuActionsSelected' : '' ]" @click="manageOpen"></i>
        </div>
        <div v-if="dairs[0].id !== selectedDair.id && isEmpty(itemMenu.building)" class="itemMenuContainerActions">
          <div class="itemMenuTextAction">{{ menuActions[3].text }}</div>
          <i :class="[ 'actions', 'bx', menuActions[3].i, selectedAction === menuActions[3] ? 'itemMenuActionsSelected' : '' ]" @click="buildOpen"></i>
        </div>
        <div v-if="dairs[0].id !== selectedDair.id" class="itemMenuContainerActions">
          <div class="itemMenuTextAction">{{ menuActions[4].text }}</div>
          <i :class="[ 'actions', 'bx', menuActions[4].i, selectedAction === menuActions[4] ? 'itemMenuActionsSelected' : '' ]" @click="moveUnitOpen"></i>
        </div>
      </div>
      <div class="itemMenuSubActions">
        <div class="actions" id="destroy" v-show="selectedAction === menuActions[1]"
             :style="{ 'opacity': selectedAction === menuActions[1] ? 1 : 0 }">
          <p>Разрушить постройку</p>
          <p>{{'[' + itemMenu.building.name + '] ?'}}</p>
          <div style="display: flex; justify-content: space-evenly; width: 100%">
            <p class="submit submitYes" @click="destroy">да</p>
            <p class="submit submitNo" @click="unselectAction">нет</p>
          </div>
        </div>
        <div class="actions" v-show="selectedAction === menuActions[2]"
             :style="{ 'opacity': selectedAction === menuActions[2] ? 1 : 0, 'height': '125px' }">
          <div class="itemMenuManageActions" style="margin-bottom: 5px">
            <div style="width: 30%">
              <div class="actions">
                <div class="itemMenuTextAction">{{ menuInformation[1].shortText }}</div>
                <i :class="[ 'actions', 'bx', menuInformation[1].i, selectedSubAction === menuInformation[1] ? 'itemMenuActionsSelected' : '']" @click="manageGroundTypeOpen"></i>
              </div>
            </div>
            <div style="width: 30%">
              <div class="actions">
                <div class="itemMenuTextAction">{{ menuInformation[2].shortText }}</div>
                <i :class="[ 'actions', 'bx', menuInformation[2].i, selectedSubAction === menuInformation[2] ? 'itemMenuActionsSelected' : '']" @click="manageSpecialTypeOpen"></i>
              </div>
            </div>
          </div>
          <div class="itemMenuManageActions">
            <div style="width: 30%">
              <div class="actions">
                <div class="itemMenuTextAction">{{ menuInformation[3].shortText }}</div>
                <i :class="[ 'actions', 'bx', menuInformation[3].i, selectedSubAction === menuInformation[3] ? 'itemMenuActionsSelected' : '']" @click="manageResourcesOpen"></i>
              </div>
            </div>
            <div style="width: 30%">
              <div class="actions">
                <div class="itemMenuTextAction">{{ menuInformation[5].shortText }}</div>
                <i :class="[ 'actions', 'bx', menuInformation[5].i, selectedSubAction === menuInformation[5] ? 'itemMenuActionsSelected' : '']" @click="manageOwnerOpen"></i>
              </div>
            </div>
          </div>
        </div>
        <div class="actions" v-show="selectedSubAction === menuInformation[1]"
             :style="{ 'opacity': selectedSubAction === menuInformation[1] ? 1 : 0, 'margin-top': '10px' }">
          <div class="itemMenuSubActionsManage" @click="manageGround(1)">{{groundTypes[1].name}}</div>
          <div class="itemMenuSubActionsManage" @click="manageGround(2)">{{groundTypes[2].name}}</div>
          <div class="itemMenuSubActionsManage" @click="manageGround(3)">{{groundTypes[3].name}}</div>
          <div class="itemMenuSubActionsManage" @click="manageGround(4)">{{groundTypes[4].name}}</div>
        </div>
        <div class="actions" v-show="selectedSubAction === menuInformation[2]"
             :style="{ 'opacity': selectedSubAction === menuInformation[2] ? 1 : 0, 'margin-top': '10px' }">
          <div class="itemMenuSubActionsManage" @click="manageSpecial(1)">{{specialTypes[1].name}}</div>
          <div class="itemMenuSubActionsManage" @click="manageSpecial(2)">{{specialTypes[2].name}}</div>
          <div class="itemMenuSubActionsManage" @click="manageSpecial(3)">{{specialTypes[3].name}}</div>
          <div class="itemMenuSubActionsManage" @click="manageSpecial(4)">{{specialTypes[4].name}}</div>
        </div>
        <div class="actions" v-show="selectedSubAction === menuInformation[3]"
             :style="{ 'opacity': selectedSubAction === menuInformation[3] ? 1 : 0, 'margin-top': '10px' }">
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
        <div class="actions" v-show="selectedSubAction === menuInformation[5]"
             :style="{ 'opacity': selectedSubAction === menuInformation[5] ? 1 : 0, 'margin-top': '10px' }">
          <div class="itemMenuSubActionsManageOwner" @click="manageOwner(1)" :style="{ 'border-color': dairs[1].colorSecond, '--first-color' : dairs[1].color }">{{dairs[1].name}}</div>
          <div class="itemMenuSubActionsManageOwner" @click="manageOwner(2)" :style="{ 'border-color': dairs[2].colorSecond, '--first-color' : dairs[2].color }">{{dairs[2].name}}</div>
          <div class="itemMenuSubActionsManageOwner" @click="manageOwner(3)" :style="{ 'border-color': dairs[3].colorSecond, '--first-color' : dairs[3].color }">{{dairs[3].name}}</div>
          <div class="itemMenuSubActionsManageOwner" @click="manageOwner(4)" :style="{ 'border-color': dairs[4].colorSecond, '--first-color' : dairs[4].color }">{{dairs[4].name}}</div>
          <div class="itemMenuSubActionsManageOwner" @click="manageOwner(5)" :style="{ 'border-color': dairs[5].colorSecond, '--first-color' : dairs[5].color }">{{dairs[5].name}}</div>
        </div>

        <div class="actions" id="moveUnit" v-show="selectedAction === menuActions[4]" :style="{ 'opacity': selectedAction === menuActions[4] ? 1 : 0 }"></div>

        <div class="actions" v-show="selectedAction === menuActions[3]"
             :style="{ 'opacity': selectedAction === menuActions[3] ? 1 : 0, 'height': '190px' }">
          <div class="itemMenuManageActions" style="margin-bottom: 5px">
            <div style="width: 30%">
              <div class="actions">
                <div class="itemMenuTextAction">{{ buildingsTypes[menuBuild[1].type].shortName }}</div>
                <i :class="[ 'actions', 'bx', menuBuild[1].i, selectedSubAction === menuBuild[1] ? 'itemMenuActionsSelected' : '']" @click="buildProductionOpen"></i>
              </div>
            </div>
            <div style="width: 30%">
              <div class="actions">
                <div class="itemMenuTextAction">{{ buildingsTypes[menuBuild[2].type].shortName }}</div>
                <i :class="[ 'actions', 'bx', menuBuild[2].i, selectedSubAction === menuBuild[2] ? 'itemMenuActionsSelected' : '']" @click="buildBarrackOpen"></i>
              </div>
            </div>
          </div>
          <div class="itemMenuManageActions" style="margin-bottom: 5px">
            <div style="width: 30%">
              <div class="actions">
                <div class="itemMenuTextAction">{{ buildingsTypes[menuBuild[3].type].shortName }}</div>
                <i :class="[ 'actions', 'bx', menuBuild[3].i, selectedSubAction === menuBuild[3] ? 'itemMenuActionsSelected' : '']" @click="buildPortOpen"></i>
              </div>
            </div>
            <div style="width: 30%">
              <div class="actions">
                <div class="itemMenuTextAction">{{ buildingsTypes[menuBuild[4].type].shortName }}</div>
                <i :class="[ 'actions', 'bx', menuBuild[4].i, selectedSubAction === menuBuild[4] ? 'itemMenuActionsSelected' : '']" @click="buildShipOpen"></i>
              </div>
            </div>
          </div>
          <div class="itemMenuManageActions">
            <div style="width: 30%">
              <div class="actions">
                <div class="itemMenuTextAction">{{ buildingsTypes[menuBuild[5].type].shortName }}</div>
                <i :class="[ 'actions', 'bx', menuBuild[5].i, selectedSubAction === menuBuild[5] ? 'itemMenuActionsSelected' : '']" @click="buildMagicOpen"></i>
              </div>
            </div>
            <div style="width: 30%">
              <div class="actions">
                <div class="itemMenuTextAction">{{ buildingsTypes[menuBuild[6].type].shortName }}</div>
                <i :class="[ 'actions', 'bx', menuBuild[6].i, selectedSubAction === menuBuild[6] ? 'itemMenuActionsSelected' : '']" @click="buildDefOpen"></i>
              </div>
            </div>
          </div>
        </div>
        <div v-for="(manageBuildings, indexB) in menuBuild" class="actions" v-show="selectedSubAction === manageBuildings" :key="indexB"
             :style="{ 'opacity': selectedSubAction === manageBuildings ? 1 : 0, 'margin': '10px 0 5px 0' }">
          <div v-for="(building, index) in getBuildings()" :class="['itemMenuSubActionsManage', !canBuild(building) ? 'cannotBuild' : '']" @click="manageBuilding(building)" :key="index" :style="{ 'margin': '3px 0 20px 0' }">
            <div style="color: inherit">{{getBuildingManageString(buildings[building])}}</div>
            <div class="itemMenuSubActionsResourcesContainer">
              <div v-for="(cost, i) in getBuildingCost(building)" :key="i">
                <div :style="{ 'display': 'flex', 'align-items': 'center', 'color': !hasResources(cost, i + 1) ? 'red' : '#F5F5F5' }">
                  <i :class="['bx', resourcesTypes[i + 1].i]" style="color: inherit"/>
                  <div style="margin-left: 2px; color: inherit">{{cost}}</div>
                </div>
              </div>
            </div>
          </div>
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
                <div :style="{ 'font-size': '0.9em', 'color' : (dairs[id].resources[indexResource] + getAdditionalResourcesCountForDair(id, indexResource, false)) === 0 ? '#ff4242' : '' }">
                  {{ (dairs[id].resources[indexResource] + getAdditionalResourcesCountForDair(id, indexResource, false)) + ' (+' + getAdditionalResourcesCountForDair(id, indexResource) + ')' }}
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
  </main>
</template>

<script>
import 'vue-slider-component/theme/antd.css';
import VueSlider from 'vue-slider-component';
import '../assets/css/custom-dot.css';

export default {
  name: 'Dair',
  components: { 'vue-slider': VueSlider },
  data() {
    return {
      documentTitle: 'Завеса',

      dairMap: [],

      minDairZoom: 16,
      savedDairZoom: 16,
      dairZoom: 16,
      maxDairZoom: 64,
      dairLetterPositions: ['А', 'Б', 'В', 'Г', 'Д', 'Е', 'Ж', 'З', 'И', 'К', 'Л', 'М', 'Н', 'О', 'П', 'Р', 'С', 'Т', 'У', 'Ф', 'Х', 'Ц', 'Ч', 'Ш', 'Щ', 'Ы', 'Э', 'Ю', 'Я', 'АА', 'АБ', 'АВ', 'АГ', 'АД', 'АЕ', 'АЖ', 'АЗ', 'АИ', 'АК', 'АЛ', 'АМ', 'АН', 'АО', 'АП', 'АР', 'АС', 'АТ', 'АУ', 'АФ', 'АХ', 'АЦ', 'АЧ', 'АШ', 'АЩ', 'АЫ', 'АЭ', 'АЮ', 'АЯ', 'БА', 'ББ', 'БВ', 'БГ', 'БД', 'БЕ', 'БЖ', 'БЗ', 'БИ', 'БК', 'БЛ', 'БМ', 'БН', 'БО', 'БП', 'БР', 'БС', 'БТ', 'БУ', 'БФ', 'БХ', 'БЦ', 'БЧ', 'БШ', 'БЩ', 'БЫ', 'БЭ', 'БЮ', 'БЯ', 'ВА', 'ВБ', 'ВВ', 'ВГ', 'ВД', 'ВЕ', 'ВЖ', 'ВЗ', 'ВИ', 'ВК', 'ВЛ', 'ВМ', 'ВН'],
      canvas: null,
      context: null,
      spaceSize: 1,
      cursorPositionY: -1,
      cursorPositionX: -1,
      hiddenSrc: 'hidden.png',
      selectionSrc: 'selection.jpeg',
      images: [],
      loadedCount: 0,
      imagesSrc: [
        'selection.jpeg',
        'hidden.png',

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
        'grounds/water.gif',

        'resources/food.png',
        'resources/iron.png',
        'resources/oil.png',
        'resources/stone.png',
        'resources/wood.png',

        'special/hole.png',
        'special/market.png',
      ],
      isResizing: false,

      dairSizeY: 40,
      dairSizeX: 70,

      period: 1,
      periodOpen: false,
      marketOpen: false,
      market1: -1,
      market2: -1,
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
      oldSelectedItem: {},
      selectedItem: {},
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

      menuActions: {
        1: {
          i: 'bxs-business',
          text: 'разрушить',
        },
        2: {
          i: 'bx-cog',
          text: 'параметры',
        },
        3: {
          i: 'bxs-business',
          text: 'построить',
        },
        4: {
          i: 'bx-exit',
          text: 'переместить',
        },
      },
      selectedAction: {},
      selectedSubAction: {},

      preSelectedDair: {},

      resourcesCount: 10,
      initialResourcesCount: 10,

      selectedDair: {
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
          url: 'grounds/water.gif',
        },
      },

      specialTypes: {
        1: {
          name: 'Обычная земля',
          url: '',
        },
        2: {
          name: 'Магическая земля',
          url: '',
        },
        3: {
          name: 'Предел',
          url: 'special/hole.png',
        },
        4: {
          name: 'Рынок',
          url: 'special/market.png',
        },
      },

      resourcesTypes: {
        1: {
          name: 'Камень',
          i: 'bxs-cube',
          url: 'resources/stone.png',
        },
        2: {
          name: 'Железо',
          i: 'bxs-layer',
          url: 'resources/iron.png',
        },
        3: {
          name: 'Дерево',
          i: 'bxs-tree-alt',
          url: 'resources/wood.png',
        },
        4: {
          name: 'Нефть',
          i: 'bxs-cylinder',
          url: 'resources/oil.png',
        },
        5: {
          name: 'Пропитание',
          i: 'bxs-bowl-hot',
          url: 'resources/food.png',
        },
        6: {
          name: 'Золото',
          i: 'bxs-coin',
          url: '',
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
          performance: 1,
          resource: 1,
          cost: {
            1: 3,
            2: 0,
            3: 0,
            4: 0,
            5: 0,
          },
          url: 'buildings/stonebuild1.png',
        },
        2: {
          type: 1,
          name: 'Шахта',
          performance: 1,
          resource: 2,
          cost: {
            1: 0,
            2: 3,
            3: 0,
            4: 0,
            5: 0,
          },
          url: 'buildings/ironbuild1.png',
        },
        3: {
          type: 1,
          name: 'Лесопилка',
          performance: 1,
          resource: 3,
          cost: {
            1: 0,
            2: 0,
            3: 3,
            4: 0,
            5: 0,
          },
          url: 'buildings/woodbuild1.png',
        },
        4: {
          type: 1,
          name: 'Нефтяная вышка',
          performance: 1,
          resource: 4,
          cost: {
            1: 0,
            2: 0,
            3: 0,
            4: 3,
            5: 0,
          },
          url: 'buildings/oilbuild1.png',
        },
        5: {
          type: 1,
          name: 'Ферма',
          performance: 1,
          resource: 5,
          cost: {
            1: 0,
            2: 0,
            3: 0,
            4: 0,
            5: 3,
          },
          url: 'buildings/foodbuild1.png',
        },
        6: {
          type: 1,
          name: 'Улучшенная каменоломня',
          performance: 5,
          resource: 1,
          cost: {
            1: 10,
            2: 0,
            3: 3,
            4: 0,
            5: 0,
          },
          url: 'buildings/stonebuild2.png',
        },
        7: {
          type: 1,
          name: 'Улучшенная шахта',
          performance: 5,
          resource: 2,
          cost: {
            1: 3,
            2: 10,
            3: 0,
            4: 0,
            5: 0,
          },
          url: 'buildings/ironbuild2.png',
        },
        8: {
          type: 1,
          name: 'Улучшенная лесопилка',
          performance: 5,
          resource: 3,
          cost: {
            1: 3,
            2: 0,
            3: 10,
            4: 0,
            5: 0,
          },
          url: 'buildings/woodbuild2.png',
        },
        9: {
          type: 1,
          name: 'Нефтяная платформа',
          performance: 5,
          resource: 4,
          cost: {
            1: 3,
            2: 0,
            3: 0,
            4: 10,
            5: 0,
          },
          url: 'buildings/oilbuild2.png',
        },
        10: {
          type: 1,
          name: 'Улучшенная ферма',
          performance: 5,
          resource: 5,
          cost: {
            1: 3,
            2: 0,
            3: 0,
            4: 0,
            5: 10,
          },
          url: 'buildings/foodbuild2.png',
        },
        11: {
          type: 2,
          name: 'Казарма',
          size: 20,
          cost: {
            1: 3,
            2: 3,
            3: 3,
            4: 3,
            5: 3,
          },
          url: 'buildings/peoples1.png',
        },
        12: {
          type: 2,
          name: 'Расширенная казарма',
          size: 50,
          cost: {
            1: 7,
            2: 6,
            3: 8,
            4: 6,
            5: 7,
          },
          url: 'buildings/peoples2.png',
        },
        13: {
          type: 3,
          name: 'Речной порт',
          cost: {
            1: 5,
            2: 5,
            3: 5,
            4: 5,
            5: 5,
          },
          url: 'buildings/shipbuild.png',
        },
        14: {
          type: 4,
          name: 'Грузовой корабль',
          resourcesCount: 20,
          armyCount: 0,
          cost: {
            1: 0,
            2: 0,
            3: 10,
            4: 0,
            5: 0,
          },
          url: 'buildings/ship1.png',
        },
        15: {
          type: 4,
          name: 'Военный корабль',
          resourcesCount: 5,
          armyCount: 30,
          cost: {
            1: 0,
            2: 5,
            3: 5,
            4: 5,
            5: 0,
          },
          url: 'buildings/ship2.png',
        },
        16: {
          type: 5,
          name: 'Магическая башня',
          cost: {
            1: 0,
            2: 5,
            3: 5,
            4: 5,
            5: 0,
          },
          url: 'buildings/tower.png',
        },
        17: {
          type: 6,
          name: 'Стена',
          hp: 20,
          cost: {
            1: 20,
            2: 0,
            3: 20,
            4: 0,
            5: 0,
          },
          url: 'buildings/wall1.png',
        },
        18: {
          type: 6,
          name: 'Укреплённая стена',
          hp: 50,
          cost: {
            1: 40,
            2: 10,
            3: 50,
            4: 0,
            5: 0,
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
      let row = [];
      let randomG = [1, 2, 3, 4]; // 4
      let randomS = [1, 2]; // 2
      let randomRO = [-1, -1, -1, -1, -1, 1, 2, 3, 4, 5]; // 10
      let randomB = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18]; // 34
      for (let y = 0; y < this.dairSizeY; y++) {
        row = [];
        for (let x = 0; x < this.dairSizeX; x++) {
          row.push({
            groundType: randomG[Math.floor(Math.random() * 4)],
            specialType: randomS[Math.floor(Math.random() * 2)],
            resourcesType: randomRO[Math.floor(Math.random() * 10)],
            resourcesCount: Math.floor(Math.random() * 10),
            building: -1,
            owner: -1,
            hasAccess: new Set(),
            src: '',
          });

          // let ownerX = randomRO[Math.floor(Math.random() * 10)];
          // let buildingX = randomB[Math.floor(Math.random() * 34)];
          // row.push({
          //   groundType: randomG[Math.floor(Math.random() * 4)],
          //   specialType: randomS[Math.floor(Math.random() * 2)],
          //   resourcesType: randomRO[Math.floor(Math.random() * 10)],
          //   resourcesCount: Math.floor(Math.random() * 50),
          //   building: buildingX,
          //   owner: ownerX,
          //   hasAccess: new Set([ownerX]),
          //   src: '',
          // });
          // if (buildingX !== -1 && ownerX !== -1) {
          //   this.linkBuild(buildingX, this.dairs[ownerX], x, y, false);
          // }
        }
        this.dairMap.push(row);
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
            this.drawCanvas();
          }
        };
        this.images.push(image);
      }
    },
    move(e) {
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
      this.oldSelectedItem = this.selectedItem;
      this.selectedItem = { x: itemIndex, y: rowIndex };
      this.draw();
    },
    clear() {
      this.cursorPositionY = -1;
      this.cursorPositionX = -1;
      this.oldSelectedItem = this.selectedItem;
      this.selectedItem = {};
      this.draw();
    },
    openMenuItem(e) {
      this.stopPropagation(e);
      if (this.hasAccess(this.selectedItem.x, this.selectedItem.y)) {
        this.itemMenuSelected = true;
        this.reloadSelection();
        this.selectedItemForMenu = this.selectedItem;
        this.draw();
        if (this.selectedAction === this.menuActions[1] && this.dairMap[this.selectedItem.y][this.selectedItem.x].building === -1) {
          this.unselectAction();
        }
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
    drawCanvas() {
      this.oldSelectedItem = {};
      this.selectedItem = {};
      this.context.clearRect(0, 0, this.canvas.width, this.canvas.height);
      this.canvas.width = this.getDairSizeX();
      this.canvas.height = this.getDairSizeY();
      for (let y = 0; y < this.dairSizeY; y++) {
        for (let x = 0; x < this.dairSizeX; x++) {
          this.drawItem(this.getImage(this.dairMap[y][x]), x, y);
        }
      }
    },
    getSelectedImages() {
      return [this.images.at(this.imagesSrc.indexOf(this.selectionSrc))];
    },
    getHiddenImage() {
      return this.images.at(this.imagesSrc.indexOf(this.hiddenSrc));
    },
    getImage(dairMap) {
      let itemImages = [this.images.at(this.imagesSrc.indexOf(this.groundTypes[dairMap.groundType].url))];
      if (dairMap.specialType > 2) {
        itemImages.push(this.images.at(this.imagesSrc.indexOf(this.specialTypes[dairMap.specialType].url)));
      } else if (dairMap.building !== -1) {
        itemImages.push(this.images.at(this.imagesSrc.indexOf(this.buildings[dairMap.building].url)));
      } else if (dairMap.resourcesType !== -1) {
        itemImages.push(this.images.at(this.imagesSrc.indexOf(this.resourcesTypes[dairMap.resourcesType].url)));
      }
      return itemImages;
    },
    draw() {
      if (!this.isEmpty(this.oldSelectedItem)) {
        this.context.clearRect(this.oldSelectedItem.x * this.dairZoom,
          this.oldSelectedItem.y * this.dairZoom,
          this.dairZoom - this.spaceSize,
          this.dairZoom - this.spaceSize);
        this.drawItem(this.getImage(this.dairMap[this.oldSelectedItem.y][this.oldSelectedItem.x]), this.oldSelectedItem.x, this.oldSelectedItem.y);
      }
      this.context.clearRect(this.selectedItem.x * this.dairZoom,
        this.selectedItem.y * this.dairZoom,
        this.dairZoom - this.spaceSize,
        this.dairZoom - this.spaceSize);
      if (!this.isEmpty(this.selectedItem)) {
        this.drawItem(this.getSelectedImages(), this.selectedItem.x, this.selectedItem.y);
      }
      if (!this.isEmpty(this.selectedItemForMenu)) {
        this.drawSelection(this.selectedItemForMenu.x, this.selectedItemForMenu.y);
      }
    },
    reloadOwnerSelection() {
      if (!this.isEmpty(this.selectedItemForMenu)) {
        this.context.clearRect(this.selectedItemForMenu.x * this.dairZoom,
          this.selectedItemForMenu.y * this.dairZoom,
          this.dairZoom - this.spaceSize,
          this.dairZoom - this.spaceSize);
        this.drawItem(this.getImage(this.dairMap[this.selectedItemForMenu.y][this.selectedItemForMenu.x]), this.selectedItemForMenu.x, this.selectedItemForMenu.y);

        if (this.selectedItemForMenu.y !== 0) {
          let x = this.selectedItemForMenu.x;
          let y = this.selectedItemForMenu.y - 1;
          this.drawItem(this.getImage(this.dairMap[y][x]), x, y);
        }
        if (this.selectedItemForMenu.y !== this.dairSizeY - 1) {
          let x = this.selectedItemForMenu.x;
          let y = this.selectedItemForMenu.y + 1;
          this.drawItem(this.getImage(this.dairMap[y][x]), x, y);
        }
        if (this.selectedItemForMenu.x !== 0) {
          let x = this.selectedItemForMenu.x - 1;
          let y = this.selectedItemForMenu.y;
          this.drawItem(this.getImage(this.dairMap[y][x]), x, y);
        }
        if (this.selectedItemForMenu.x !== this.dairSizeX - 1) {
          let x = this.selectedItemForMenu.x + 1;
          let y = this.selectedItemForMenu.y;
          this.drawItem(this.getImage(this.dairMap[y][x]), x, y);
        }
      }
    },
    reloadSelection() {
      if (!this.isEmpty(this.selectedItemForMenu)) {
        this.context.clearRect(this.selectedItemForMenu.x * this.dairZoom,
          this.selectedItemForMenu.y * this.dairZoom,
          this.dairZoom - this.spaceSize,
          this.dairZoom - this.spaceSize);
        this.drawItem(this.getImage(this.dairMap[this.selectedItemForMenu.y][this.selectedItemForMenu.x]), this.selectedItemForMenu.x, this.selectedItemForMenu.y);
      }
    },
    hasAccess(x, y) {
      return this.selectedDair.id === 1 || this.dairMap[y][x].hasAccess.has(this.selectedDair.id - 1);
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
      if (this.dairMap[y][x].owner !== -1) {
        let ownerId = this.dairMap[y][x].owner;
        let owner = this.dairs[ownerId];

        // top
        if (y !== 0 && (this.dairMap[y - 1][x].owner === -1 || this.dairMap[y - 1][x].owner !== ownerId)) {
          this.drawTop(x, y, owner.color);
        }

        // bottom
        if (y !== this.dairSizeY - 1 && (this.dairMap[y + 1][x].owner === -1 || this.dairMap[y + 1][x].owner !== ownerId)) {
          this.drawBottom(x, y, owner.color);
        }

        // left
        if (x !== 0 && (this.dairMap[y][x - 1].owner === -1 || this.dairMap[y][x - 1].owner !== ownerId)) {
          this.drawLeft(x, y, owner.color);
        }

        // right
        if (x !== this.dairSizeX - 1 && (this.dairMap[y][x + 1].owner === -1 || this.dairMap[y][x + 1].owner !== ownerId)) {
          this.drawRight(x, y, owner.color);
        }
      }
    },
    initLines(color) {
      let delta = 4 * (this.dairZoom / this.maxDairZoom);
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
    drawSelection(x, y) {
      let startX = x * this.dairZoom + 1;
      let startY = y * this.dairZoom + 1;
      let size = this.dairZoom - this.spaceSize - 2;

      this.context.strokeStyle = 'black';
      this.context.lineWidth = 2;
      this.context.beginPath();
      this.context.rect(startX, startY, size, size);
      this.context.stroke();
    },
    getGroundType() {
      if (!this.itemMenuSelected) {
        return {};
      }
      let groundType = this.dairMap[this.selectedItemForMenu.y][this.selectedItemForMenu.x].groundType;
      return groundType === -1 ? {} : this.groundTypes[groundType];
    },
    getSpecialType() {
      if (!this.itemMenuSelected) {
        return {};
      }
      let specialType = this.dairMap[this.selectedItemForMenu.y][this.selectedItemForMenu.x].specialType;
      return specialType === -1 ? {} : this.specialTypes[specialType];
    },
    getResourcesType() {
      if (!this.itemMenuSelected) {
        return {};
      }
      let resourcesType = this.dairMap[this.selectedItemForMenu.y][this.selectedItemForMenu.x].resourcesType;
      return resourcesType === -1 ? {} : this.resourcesTypes[resourcesType];
    },
    getResourcesCount() {
      if (!this.itemMenuSelected) {
        return {};
      }
      return this.dairMap[this.selectedItemForMenu.y][this.selectedItemForMenu.x].resourcesCount;
    },
    getBuilding() {
      if (!this.itemMenuSelected) {
        return {};
      }
      let building = this.dairMap[this.selectedItemForMenu.y][this.selectedItemForMenu.x].building;
      return building === -1 ? {} : this.buildings[building];
    },
    getBuildingString(building) {
      let buildingString = building.name;
      if (building.type === 1) {
        buildingString += ' (+' + building.performance + ' ед.)';
      } else if (building.type === 2) {
        buildingString += ' (' + building.size + ' мест)';
      } else if (building.type === 4) {
        buildingString += ' (' + building.resourcesCount + ' ед. трюм' + (building.armyCount === 0 ? '' : ' и ' + building.armyCount + ' мест') + ')';
      } else if (building.type === 6) {
        buildingString += ' (' + building.hp + ' hp)';
      }
      return buildingString;
    },
    getBuildingManageString(building) {
      let buildingString = building.name;
      if (building.type === 1) {
        buildingString += ' (+' + building.performance + ',  ' + this.resourcesTypes[building.resource].name + ')';
      } else if (building.type === 2) {
        buildingString += ' (' + building.size + ' мест)';
      } else if (building.type === 4) {
        buildingString += ' (' + building.resourcesCount + ' ед. трюм' + (building.armyCount === 0 ? '' : ' и ' + building.armyCount + ' мест') + ')';
      } else if (building.type === 6) {
        buildingString += ' (' + building.hp + ' hp)';
      }
      return buildingString;
    },
    getOwner() {
      if (!this.itemMenuSelected) {
        return {};
      }
      let owner = this.dairMap[this.selectedItemForMenu.y][this.selectedItemForMenu.x].owner;
      return owner === -1 ? {} : this.dairs[owner];
    },
    getDairItem() {
      if (!this.itemMenuSelected) {
        return {};
      }
      return this.dairMap[this.selectedItemForMenu.y][this.selectedItemForMenu.x];
    },
    isEmpty(object) {
      return Object.keys(object).length === 0;
    },
    destroyOpen() {
      this.selectAction(this.menuActions[1]);
    },
    destroy() {
      this.itemMenu.dairMap.building = -1;
      this.unlinkBuild(-1, false);
      this.unselectAction();
      this.reloadSelection();
      this.draw();
    },
    unlinkBuild(newOwnerId, isNewOwner) {
      let buildings = this.dairs[this.itemMenu.dairMap.owner].buildings;
      let index = -1;
      for (let i = 0; i < buildings.length; i++) {
        if (buildings[i].x === this.selectedItemForMenu.x && buildings[i].y === this.selectedItemForMenu.y) {
          index = i;
          break;
        }
      }
      if (index !== -1) {
        if (isNewOwner) {
          this.linkBuild(buildings[index].buildingId, this.dairs[newOwnerId], this.selectedItemForMenu.x, this.selectedItemForMenu.y, false);
        }
        buildings.splice(index, 1);
      }
    },
    manageOpen() {
      this.selectAction(this.menuActions[2]);
    },
    manageGroundTypeOpen() {
      this.selectSubAction(this.menuInformation[1]);
    },
    manageSpecialTypeOpen() {
      this.selectSubAction(this.menuInformation[2]);
    },
    manageResourcesOpen() {
      this.selectSubAction(this.menuInformation[3]);
    },
    manageOwnerOpen() {
      this.selectSubAction(this.menuInformation[5]);
    },
    buildProductionOpen() {
      this.selectSubAction(this.menuBuild[1]);
    },
    buildBarrackOpen() {
      this.selectSubAction(this.menuBuild[2]);
    },
    buildPortOpen() {
      this.selectSubAction(this.menuBuild[3]);
    },
    buildShipOpen() {
      this.selectSubAction(this.menuBuild[4]);
    },
    buildMagicOpen() {
      this.selectSubAction(this.menuBuild[5]);
    },
    buildDefOpen() {
      this.selectSubAction(this.menuBuild[6]);
    },
    manageGround(id) {
      this.itemMenu.dairMap.groundType = id;
      this.reloadSelection();
      this.draw();
    },
    manageSpecial(id) {
      this.itemMenu.dairMap.specialType = id;
      this.reloadSelection();
      this.draw();
    },
    manageOwner(id) {
      if (this.itemMenu.dairMap.building !== -1) {
        this.unlinkBuild(id, true);
      }
      this.itemMenu.dairMap.owner = id;
      this.itemMenu.dairMap.hasAccess.add(id);
      this.reloadOwnerSelection();
      this.draw();
    },
    manageBuilding(buildingId) {
      if (this.canBuild(buildingId)) {
        this.itemMenu.dairMap.building = buildingId;
        this.linkBuild(buildingId, this.selectedDair, this.selectedItemForMenu.x, this.selectedItemForMenu.y, true);
        this.unselectSubAction();
        this.unselectAction();
        this.reloadSelection();
        this.draw();
      }
    },
    getAdditionalResourcesCountForDair(dairId, resourceId, isCost) {
      let count = 0;
      for (let i = 0; i < this.dairs[dairId].buildings.length; i++) {
        let building = this.dairs[dairId].buildings[i];
        if (this.buildings[building.buildingId].resource === parseInt(resourceId, 10) &&
          this.dairMap[building.y][building.x].resourcesType === parseInt(resourceId, 10)) {
          let resCount = Math.min(this.buildings[building.buildingId].performance, this.dairMap[building.y][building.x].resourcesCount);
          count += resCount;
          if (isCost) {
            this.dairMap[building.y][building.x].resourcesCount -= resCount;
          }
        }
      }
      return count;
    },
    nextPeriodPanelOpen() {
      this.periodOpen = true;
    },
    nextPeriodPanelClose() {
      this.periodOpen = false;
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
    getMarketResources(id) {
      if (id === 1) {
        return this.notMarket1Selected() ? this.dairs[0].resources : this.dairs[this.market1].resources;
      }
      return this.notMarket2Selected() ? this.dairs[0].resources : this.dairs[this.market2].resources;
    },
    notMarket1Selected() {
      return this.market1 === -1;
    },
    notMarket2Selected() {
      return this.market2 === -1;
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
      }
    },
    nextPeriod() {
      this.period += 1;
      this.periodOpen = false;
      for (let dair = 1; dair < this.dairs.length; dair++) {
        this.dairs[dair].resources[1] += this.getAdditionalResourcesCountForDair(dair, 1, true);
        this.dairs[dair].resources[2] += this.getAdditionalResourcesCountForDair(dair, 2, true);
        this.dairs[dair].resources[3] += this.getAdditionalResourcesCountForDair(dair, 3, true);
        this.dairs[dair].resources[4] += this.getAdditionalResourcesCountForDair(dair, 4, true);
        this.dairs[dair].resources[5] += this.getAdditionalResourcesCountForDair(dair, 5, true);
      }
    },
    linkBuild(buildingId, dair, xPos, yPos, isCost) {
      let building = this.buildings[buildingId];
      if (building.type === 1) {
        dair.buildings.push({
          buildingId,
          x: xPos,
          y: yPos,
        });
      }
      if (isCost) {
        this.selectedDair.resources[1] -= building.cost[1];
        this.selectedDair.resources[2] -= building.cost[2];
        this.selectedDair.resources[3] -= building.cost[3];
        this.selectedDair.resources[4] -= building.cost[4];
        this.selectedDair.resources[5] -= building.cost[5];
      }
    },
    getBuildings() {
      if (this.selectedSubAction === this.menuBuild[1]) {
        return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
      } else if (this.selectedSubAction === this.menuBuild[2]) {
        return [11, 12];
      } else if (this.selectedSubAction === this.menuBuild[3]) {
        return [13];
      } else if (this.selectedSubAction === this.menuBuild[4]) {
        return [14, 15];
      } else if (this.selectedSubAction === this.menuBuild[5]) {
        return [16];
      } else if (this.selectedSubAction === this.menuBuild[6]) {
        return [17, 18];
      }
      return [];
    },
    getBuildingCost(building) {
      return Object.values(this.buildings[building].cost);
    },
    hasResources(cost, type) {
      return this.selectedDair.resources[type] >= cost;
    },
    canBuild(building) {
      let needed = this.buildings[building].cost;
      return this.selectedDair.resources[1] >= needed[1] &&
        this.selectedDair.resources[2] >= needed[2] &&
        this.selectedDair.resources[3] >= needed[3] &&
        this.selectedDair.resources[4] >= needed[4] &&
        this.selectedDair.resources[5] >= needed[5];
    },
    manageResources(id) {
      this.itemMenu.dairMap.resourcesType = id;
      this.itemMenu.dairMap.resourcesCount = this.resourcesCount;
      this.reloadSelection();
      this.draw();
    },
    buildOpen() {
      this.selectAction(this.menuActions[3]);
    },
    moveUnitOpen() {
      // TODO wait for iteration 2
    },
    selectAction(action) {
      this.unselectSubAction();
      if (this.isEmpty(this.selectedAction) || this.selectedAction !== action) {
        this.selectedAction = action;
      } else {
        this.selectedAction = {};
      }
    },
    unselectAction() {
      this.selectedAction = {};
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
    selectDair() {
      this.selectedDair = this.preSelectedDair;
      this.unselectAction();
      this.unselectSubAction();
      this.drawCanvas();
    },
    unselectMenuAction() {
      this.itemMenuSelected = false;
      this.reloadSelection();
      this.selectedItemForMenu = {};
      this.unselectAction();
      this.unselectSubAction();
    },
  },
  computed: {
    itemMenu() {
      return {
        visible: this.itemMenuSelected,
        text: this.dairLetterPositions[this.selectedItemForMenu.x] + ':' + (this.selectedItemForMenu.y + 1),
        groundType: this.getGroundType(),
        specialType: this.getSpecialType(),
        resourcesType: this.getResourcesType(),
        resourcesCount: this.getResourcesCount(),
        building: this.getBuilding(),
        owner: this.getOwner(),
        dairMap: this.getDairItem(),
      };
    },
    itemMenuHeight() {
      if (this.isEmpty(this.selectedAction)) {
        return '365px';
      } else if (this.selectedAction === this.menuActions[1]) {
        return '443px';
      } else if (this.selectedAction === this.menuActions[2]) {
        if (this.selectedSubAction === this.menuInformation[1] || this.selectedSubAction === this.menuInformation[2]) {
          return '610px';
        } else if (this.selectedSubAction === this.menuInformation[3]) {
          return '677px';
        } else if (this.selectedSubAction === this.menuInformation[5]) {
          return '640px';
        }
        return '500px';
      } else if (this.selectedAction === this.menuActions[3]) {
        if (this.selectedSubAction === this.menuBuild[1]) {
          return 'calc(100% - 190px)';
        } else if (this.selectedSubAction === this.menuBuild[2]) {
          return '675px';
        } else if (this.selectedSubAction === this.menuBuild[3] || this.selectedSubAction === this.menuBuild[5]) {
          return '610px';
        } else if (this.selectedSubAction === this.menuBuild[4]) {
          return '693px';
        } else if (this.selectedSubAction === this.menuBuild[6]) {
          return '655px';
        }
        return '550px';
      }
      return '445px';
    },
  },
  created() {
    document.title = this.documentTitle;
  },
  mounted() {
    // window.onbeforeunload = () => true;
    this.getDair();
  },
  props: {
    dairs: {
      type: Array,
      default: () => [
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
          resources: {
            1: 30,
            2: 30,
            3: 30,
            4: 30,
            5: 30,
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
          resources: {
            1: 5,
            2: 5,
            3: 5,
            4: 5,
            5: 5,
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
          resources: {
            1: 5,
            2: 5,
            3: 5,
            4: 5,
            5: 5,
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
          resources: {
            1: 5,
            2: 5,
            3: 5,
            4: 5,
            5: 5,
            6: 0,
          },
          url: `url(${require('../assets/images/dairs/aim.jpg')})`,
        },
        {
          id: 6,
          name: 'Нейрдеир',
          color: '#ff2828',
          colorSecond: 'rgba(255,54,54,0.26)',
          buildings: [],
          resources: {
            1: 5,
            2: 5,
            3: 5,
            4: 5,
            5: 5,
            6: 0,
          },
          url: `url(${require('../assets/images/dairs/neir.jpeg')})`,
        },
      ],
    },
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
  max-height: calc(100% - 190px);
  width: 320px;
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
  overflow: scroll;
}
.close:hover {
  color: #F5F5F5;
}
.itemMenuInfo {
  width: 100%;
  height: 100%;
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
.itemMenuSubActionsManage:hover {
  border-color:  rgba(255, 255, 255, 1);
  color: rgba(255, 255, 255, 1);
  cursor: pointer;
}
.cannotBuild {
  border: 1px solid rgba(255, 0, 0, 0.4) !important;
  color: #ff4242 !important;
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
.itemMenuSubActions .actions {
  transition: all 0.22s ease;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
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
  margin: 10px 0 !important;
  color: inherit;
  line-height: 0.9em;
  text-align: center;
  border: 1px solid rgba(245, 245, 245, 0.2);
  transition: all 0.15s ease;

}
.submitYes:hover {
  border-color: #F5F5F5;
  /*background: linear-gradient(to right, rgba(0, 65, 106, 0.5), rgba(121, 159, 12, 0.5), rgba(255, 224, 0, 0.5));*/
}
.submitNo:hover {
  border-color: #F5F5F5;
  /*background: linear-gradient(to right, rgba(155, 23, 4, 0.5), rgba(255, 115, 0, 0.5));*/
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
.itemMenuActions .actions:hover, .itemMenuActionsSelected, .itemMenuManageActions i:hover, .footerResourcesSettings:hover, .marketActionsTradable:hover {
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
  margin-bottom: 1.3em;;
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
  height: 100px;
  padding: 0 10px 0 10px !important;
}
.top-panel-container {
  height: 100%;
  width: 75%;
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-evenly !important;
}
.top-panel-item {
  transition: all 0.22s ease;
  width: 15%;
  height: 70%;
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
.dairMap-selected {
  width: 30% !important;
  filter: none;
  border: var(--first-color);
  box-shadow: var(--second-color);
}
.dairMap-pre-selected {
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
