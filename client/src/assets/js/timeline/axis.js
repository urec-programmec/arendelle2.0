import * as d3 from 'd3';

function format(date) {
    if (d3.timeDay(date) < date) {
        return d3.timeFormat('%I:%M')(date);
    }

    if (d3.timeMonth(date) < date) {
        return d3.timeFormat('%b %d')(date);
    }

    if (d3.timeYear(date) < date) {
        return d3.timeFormat('%B')(date);
    }

    return d3.timeFormat('%Y')(date);
}

export default config => (selection) => {
    let {
        timeScale,
        height,
    } = config;

    let axe = selection.selectAll('.axe').data(d => d);

    let ay = d3.axisTop()
            .scale(timeScale)
            .tickSize(height)
            .tickFormat(d => format(d));

    axe.enter()
        .append('g')
        .attr('transform', `translate(0, ${height + 5})`)
        .classed('axe', true)
        .call(ay)
        .call(g => g.selectAll('.tick line')
          .attr('stroke-opacity', 0.5)
          .attr('stroke-dasharray', '2,2'))
        .call(g => g.selectAll('.tick text')
          .attr('dy', height + 20));

    axe.call(ay)
      .call(g => g.selectAll('.tick line')
        .attr('stroke-opacity', 0.5)
        .attr('stroke-dasharray', '2,2'))
      .call(g => g.selectAll('.tick text')
        .attr('dy', height + 20));
};
