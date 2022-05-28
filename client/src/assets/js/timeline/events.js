import * as d3 from 'd3';

export default config => (selection) => {
    let {
        timeScale,
        onEventClick,
        height,
    } = config;

    let events = selection.selectAll('g.event').data(selection.data()[0][0]);
    let h = 20;
    // let h = ((window.innerHeight - 60) / selection.data()[0][0].length) > 22 ? 20 : ((window.innerHeight - 60) / selection.data()[0][0].length - 2);
    let months = {
      '0': 'января',
      '1': 'февраля',
      '2': 'марта',
      '3': 'апреля',
      '4': 'мая',
      '5': 'июня',
      '6': 'июля',
      '7': 'августа',
      '8': 'сентября',
      '9': 'октября',
      '10': 'ноября',
      '11': 'декабря',
    };

    let g = events
        .enter()
        .append('g')
        .classed('event', true)
        .attr('transform', d => `translate(${timeScale(d.start)} ${height - d.position * (h + 2)})`)
        .on('click', onEventClick)
        .on('mouseover', function (d, i) {
          d3.select(this).transition()
            .duration('50')
            .attr('opacity', '.85');

          d3.select(this).append('text')
            .attr('dy', -4)
            .attr('id', 't' + d.id + '-' + i)
            .attr('z-index', 1000)
            .style('pointer-events', 'none')
            .style('font-size', h * 0.6)
            .text(t => (t.end < new Date() ? 'Прошел, ' : t.start > new Date() ? '' : 'Идет, ') +
              (t.start.getDate() + ' ' + months[t.start.getMonth()] + ', ' + t.start.getHours() + ':' + (t.start.getMinutes() < 10 ? '0' : '') + t.start.getMinutes() + ' — '
              + t.end.getDate() + ' ' + months[t.end.getMonth()] + ', ' + t.end.getHours() + ':' + (t.end.getMinutes() < 10 ? '0' : '') + t.end.getMinutes()).replace(/-/g, '.'));

          // d3.select(this).append('circle')
          //   .attr('cx', -10)
          //   .attr('cy', 10)
          //   .attr('r', 8)
          //   .attr('id', 't' + d.id + '-delete-' + i)
          //   .attr('z-index', 1000)
          //   .style('pointer-events', 'none')
          //   .style('fill', 'rgba(241,243,244,0.30)')
          //   .style('stroke-width', 2);

          //   d3.select(this).append('line')
          //   .attr('x1', -15)
          //   .attr('x2', -5)
          //   .attr('y1', 5)
          //   .attr('y2', 15)
          //   .attr('id', 't' + d.id + '-delete-1-' + i)
          //   .attr('z-index', 1000)
          //   .style('pointer-events', 'none')
          //   .style('stroke', 'red')
          //   .style('stroke-width', 2);
          //
          // d3.select(this).append('line')
          //   .attr('x1', -15)
          //   .attr('x2', -5)
          //   .attr('y1', 15)
          //   .attr('y2', 5)
          //   .attr('id', 't' + d.id + '-delete-2-' + i)
          //   .attr('z-index', 1000)
          //   .style('pointer-events', 'none')
          //   .style('stroke', 'red')
          //   .style('stroke-width', 2);
        })
        .on('mouseout', function (d, i) {
          d3.select(this).transition()
            .duration('50')
            .attr('opacity', '1');

          d3.select('#t' + d.id + '-' + i).remove();
        });

    g.append('rect')
        .attr('width', d => (d.end ? (timeScale(d.end) - timeScale(d.start) + h) : 10))
        .attr('height', h)
        .attr('fill', d => (d.end < new Date() ? 'rgba(241,243,244,0.3)' : d.color))
        .attr('ry', 6);

    g.append('text')
        // .attr('dy', -4)
        // .attr('dx', d => d.name.length * h * -0.18 + h / 2 )
        .attr('dy', h * 0.8)
        .attr('dx', d => (d.name < 10 ? 5 : 1))
        .style('pointer-events', 'none')
        .style('font-size', h * 0.8)
        .text(d => d.name);

    events
        .attr('transform', d => `translate(${timeScale(d.start)} ${height - d.position * (h + 2)})`)
        .selectAll('rect')
        .attr('width', d => (d.end ? (timeScale(d.end) - timeScale(d.start) + h) : 10));

    // events
    //     .exit()
    //     .on('click', null)
    //     .remove()
};

