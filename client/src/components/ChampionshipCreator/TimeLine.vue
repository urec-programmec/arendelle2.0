<template>
  <div id='timeline'></div>
</template>

<script>
import * as d3 from 'd3';
import timeline from '../../assets/js/timeline/timeline';

export default {
  name: 'TimeLine',
  methods: {
    init() {
      d3.select('#timeline')
        .datum(this.data)
        .call(timeline({
          widthResizable: true,
          viewHeight: this.config.viewHeight,
          margin: {
            top: 0,
            bottom: 30,
            left: 15,
            right: 15,
          },
          onEventClick: this.config.onEventClick,
        }));
    },
  },
  props: {
    data: {
      type: Array,
    },
    config: {
      type: Object,
      default: () => {},
    },
  },
  mounted() {
    this.$parent.$on('initTimeline', this.init);
  },
  beforeDestroy() {
    global.removeEventListener('resize', timeline._init);
  },
};
</script>
