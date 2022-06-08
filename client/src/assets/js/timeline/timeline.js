import * as d3 from 'd3';

import events from './events';
import axis from './axis';
import zoom from './zoom';
import cursor from './cursor';
import layout from './layout';

export default (config) => {
  function draw(timeScale, onEventClick, height, showCursor) {
    return (selection) => {
      selection
        .data(selection.data())
        .call(events({
          timeScale,
          onEventClick,
          height,
        }))
        .call(axis({
          timeScale,
          height,
        }))
        .call(cursor({
          showCursor,
          timeScale,
          height,
        }));
    };
  }

  function init(selection) {
    // console.log('init', selection);
    selection.selectAll('svg').remove();

    let data = selection.data();

    let newEvents = data[0];
    layout.generate(newEvents);
    // console.table(newEvents)

    let {
      viewWidth = 800,
      viewHeight = config.viewHeight,
      widthResizable = true,
      margin,
      onEventClick,
      showCursor = true,
    } = config;

    if (widthResizable) {
      viewWidth = selection.node().clientWidth;
    }

    let width = viewWidth - margin.right - margin.left;
    let height = viewHeight - margin.top - margin.bottom;


    let svg = selection
      .append('svg')
      .datum(data)
      .attr('width', width + margin.right + margin.left)
      .attr('height', height + margin.top + margin.bottom);

    let timeScale = d3.scaleTime()
      .domain([
        d3.min(newEvents.map((e) => {
          let start = new Date(e.start);
          start.setHours(start.getHours() - 1);
          return start;
        })),
        d3.max(newEvents.map((e) => {
          let end = new Date(e.end);
          end.setHours(end.getHours() + 1);
          return end;
        })),
      ])
      .range([0, width]);

    // console.log('timeline', timeScale(Date.now()));

    if (isNaN(timeScale(Date.now())) || data === undefined) {
      return;
    }

    let graph = svg
      .append('g')
      .classed('graph', true)
      .attr('transform', `translate(${margin.left},${margin.top})`);

    let view = graph.append('g')
      .classed('view', true);

    svg.call(zoom({
      timeScale,
      view,
      draw,
      width,
      onEventClick,
      height,
      showCursor,
    }));

    view.call(draw(timeScale, onEventClick, height, showCursor));
  }


  function chart(selection) {
      chart._init = () => init(selection);
      chart._init();

      if (config.widthResizable) {
          global.removeEventListener('resize', chart._init);
          global.addEventListener('resize', chart._init, true);
      }
  }

  return chart;
};
