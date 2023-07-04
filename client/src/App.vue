<template>
  <div id="app">
    <router-view/>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
#app {
  width: 100%;
  height: 100%;
}
@font-face {
  font-family: 'GothamPro';
  src: url('assets/webfonts/GothamPro.eot') format('eot'),
  url('assets/webfonts/GothamPro.otf')  format('opentype'),
  url('assets/webfonts/GothamPro.woff') format('woff'),
  url('assets/webfonts/GothamPro.ttf')  format('truetype');
}
* {
  font-family: "GothamPro", sans-serif;
  /*font-family: 'OptimusPrinceps', sans-serif !important;*/
  /*font-family: "Courier New", serif !important;*/
  /*font-family: 'Poppins', sans-serif !important;*/
  /*scrollbar-color: hsl(210, 40%, 20%) hsl(222, 25%, 20%);*/
  /*scrollbar-face-color: #367CD2;*/
  /*scrollbar-shadow-color: #FFFFFF;*/
  /*scrollbar-highlight-color: #FFFFFF;*/
  /*scrollbar-3dlight-color: #FFFFFF;*/
  /*scrollbar-darkshadow-color: #FFFFFF;*/
  /*scrollbar-track-color: #FFFFFF;*/
  /*scrollbar-arrow-color: #FFFFFF;*/
  /*transition: all 1s ease;*/
}

/* Let's get this party started */
*::-webkit-scrollbar {
  width: 10px;
  height: 10px;
  display: none;
}

/* Track */
*::-webkit-scrollbar-track {
  -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
  -webkit-border-radius: 10px;
  border-radius: 10px;
  margin: 15px 15px 15px 93px;
}

/* Handle */
*::-webkit-scrollbar-thumb {
  -webkit-border-radius: 10px;
  border-radius: 10px;
  padding: 2px;
  background: hsl(210, 60%, 30%);
  -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5);
}

*::-webkit-scrollbar-thumb:hover {
  background: hsl(210, 48%, 48%);
  -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5);
}

*::-webkit-scrollbar-corner {
  background: none;
}

html, body {
  width: 100%;
  height: 100%;
  margin: 0;
}

.handle-tl {
  top: -5px;
  left: -5px;
  border-radius: 3px;
  transition: all 300ms linear;
  cursor: nw-resize;
}
.handle-tl:hover {
  transform: scale(1.4);
}
</style>
