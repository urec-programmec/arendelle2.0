import * as d3 from 'd3';

export default config => (selection) => {
    let {
        timeScale,
        onEventClick,
        height,
    } = config;

    let events = selection.selectAll('g.event').data(selection.data()[0][0]);
    let h = 20;
    // let h = ((wh - 60) / selection.data()[0][0].length) > 22 ? 20 : ((wh - 60) / selection.data()[0][0].length - 2);

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
            .attr('id', 't' + d.name + '-' + i)
            .attr('z-index', 1000)
            .style('pointer-events', 'none')
            .style('font-size', h * 0.8)
            .text(t => t.text);
        })
        .on('mouseout', function (d, i) {
          d3.select(this).transition()
            .duration('50')
            .attr('opacity', '1');

          d3.select('#t' + d.name + '-' + i).remove();
        });

    g.append('rect')
        .attr('width', d => (d.end ? (timeScale(d.end) - timeScale(d.start) + h) : 10))
        .attr('height', h)
        .attr('fill', d => d.color)
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

