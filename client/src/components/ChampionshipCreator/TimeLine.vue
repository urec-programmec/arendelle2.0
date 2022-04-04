<template>
  <div id="chart">
    <apexchart type="rangeBar" :height="svgHeight" :options="chartOptions" :series="series"></apexchart>
  </div>
</template>

<script>
import Vue from 'vue';
import moment from 'moment';
import VueApexCharts from 'vue-apexcharts';

Vue.use(VueApexCharts);

export default {
  name: 'TimeLine',
  components: {
    apexchart: VueApexCharts,
  },
  data() {
    return {
      series: [
        {
          name: 'Чемпионат имени Сталина',
          data: [
            {
              x: 'Отборочный тур',
              y: [
                new Date(2022, 0, 3, 2, 3, 4, 567).getTime(),
                new Date(2022, 0, 3, 4, 3, 4, 567).getTime(),
              ],
            },
          ],
        },
        {
          name: 'Чемпионат имени Брежнева',
          data: [
            {
              x: 'Отборочный тур',
              y: [
                new Date(2022, 0, 4, 2, 3, 4, 567).getTime(),
                new Date(2022, 0, 4, 4, 3, 4, 567).getTime(),
              ],
            },
          ],
        },
      ],
      chartOptions: {
        chart: {
          locales: [{
            name: 'en',
            options: {
              months: ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'],
              shortMonths: ['янв', 'фев', 'мар', 'апр', 'мая', 'июня', 'июля', 'авг', 'сен', 'окт', 'ноя', 'дек'],
              days: ['Воскресенье', 'Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота'],
              shortDays: ['вс.', 'пн.', 'вт.', 'ср.', 'чт.', 'пт.', 'сб.'],
              toolbar: {
                selection: 'Selection',
                selectionZoom: 'Selection Zoom',
                zoomIn: 'Zoom In',
                zoomOut: 'Zoom Out',
                pan: 'Panning',
                reset: 'Reset Zoom',
              },
            },
          }],
        },
        colors: [Math.random() < 0.9 ? `hsla(${Math.random() * 100 + 170}, 50%, 50%, 1)` : `hsla(${Math.random() + 30}, 50%, 50%, 1)`],
        plotOptions: {
          bar: {
            horizontal: true,
            barHeight: '90%',
            distributed: true,
          },
        },
        dataLabels: {
          enabled: true,
          formatter: (val) => {
            var a = moment(val[0]);
            var b = moment(val[1]);
            var diff = b.diff(a, 'hour');
            let hours = (diff % 10 === 1) ? ' час' : (diff % 10 >= 2 && diff % 10 <= 4) ? ' часа' : ' часов';
            return diff + hours;
          },
        },
        xaxis: {
          type: 'datetime',
          labels: {
            style: {
              colors: ['#F5F5F5'],
              fontFamily: 'GothamPro, sans-serif',
            },
          },
        },
        yaxis: {
          show: false,
          title: {
            text: 'Отборочный тур',
            rotate: -90,
            offsetX: -10,
            style: {
              color: '#F5F5F5',
              fontSize: '1.2em',
              fontFamily: 'GothamPro, sans-serif',
            },
          },
        },
        legend: {
          // show: false,
          position: 'right',
          // floating: true,
          labels: {
            colors: ['#F5F5F5'],
          },
        },
        grid: {
          borderColor: 'rgba(241,243,244,0.14)',
          xaxis: {
            lines: {
              show: true,
            },
          },
          yaxis: {
            lines: {
              show: true,
            },
          },
        },
        tooltip: {
          onDatasetHover: {
            highlightDataSeries: true,
          },
          x: {
            format: 'dd.MM HH:mm',
          },
        },
        bar: {
          dataLabels: {
            hideOverflowingLabels: false,
          },
        },
      },
    };
  },
  computed: {
    svgHeight() {
      return window.innerHeight / 3 * 2;
    },
  },
};
</script>

<style scoped>
#chart {
  border-radius: 0.25rem;
  padding: 10px;
}
</style>
