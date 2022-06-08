import * as d3 from 'd3';

export default (config) => {
    let {
        timeScale,
        view,
        draw,
        width,
        onEventClick,
        height,
        showCursor,
    } = config;

    // console.log('zoom', timeScale(Date.now()));

    return d3.zoom()
      .scaleExtent([0.1, 1800])
      .translateExtent([[-5 * width, 0], [6 * width, 0]])
      .on('zoom', () => {
          let { k, x, y } = d3.event.transform;
          let scale = d3.zoomIdentity
                          .translate(x, y)
                          .scale(k)
                          .rescaleX(timeScale);

          view.call(draw(scale, onEventClick, height, showCursor));
      });
};
