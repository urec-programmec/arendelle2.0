<template>
  <div id="app">
    <router-view/>
  </div>
</template>

<script>
export default {
  name: 'App',
};
</script>

<style>
#app {
  width: 100%;
  height: 100%;
}
* {
  font-family: "Courier New", serif !important;
  background-color: hsl(222, 25%, 20%);
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
}

/* Track */
*::-webkit-scrollbar-track {
  -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
  -webkit-border-radius: 10px;
  border-radius: 10px;
  margin: 15px;
}

/* Handle */
*::-webkit-scrollbar-thumb {
  -webkit-border-radius: 10px;
  border-radius: 10px;
  padding: 2px;
  background: hsl(210, 60%, 30%);
  -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5);
}

html, body {
  width: 100%;
  height: 100%;
}
</style>
