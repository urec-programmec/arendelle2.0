<template>
  <main>
    <div class="background"/>
    <canvas id="canvas"></canvas>
  </main>
</template>

<script>
class Bounds {
  constructor(canvas, countPoints, minR, maxR, startVelocity, reflectionCoeff, mainVelocityCoeff, radiusCoeff, animationStep, animationDelay) {
    this.canvas = canvas;
    this.canvas.width = window.innerWidth;
    this.canvas.height = window.innerHeight;
    this.context = canvas.getContext('2d');
    this.countPoints = countPoints;
    this.minR = minR;
    this.maxR = maxR;
    this.startVelocity = startVelocity;
    this.reflectionCoeff = reflectionCoeff;
    this.mainVelocityCoeff = mainVelocityCoeff;
    this.radiusCoeff = radiusCoeff;
    this.animationStep = animationStep;
    this.animationDelay = animationDelay;
    this.loadData();
    window.addEventListener('resize', this.resize, false);
  }

  loadData() {
    this.points = [];
    for (let i = 0; i < this.countPoints; i++) {
      let y = this.getSin(i) * (Math.random() + 0.5);
      let x = this.getCos(i) * (Math.random() + 0.5);
      let v = (Math.random() * 2 - 1) * this.startVelocity;
      let velocityCoeff = this.mainVelocityCoeff + (Math.random() - 0.5) * this.mainVelocityCoeff / 2;

      this.points.push({
        startX: x,
        startY: y,
        x,
        y,
        v,
        velocityCoeff,
        radius: Math.random() * (this.maxR - this.minR) + this.minR,
        firstColor: `hsla(${Math.random() * 180 + 150}, 50%, 50%, 1)`,
        secondColor: `hsla(${Math.random() * 180 + 150}, 50%, 50%, 0)`,
      });
    }
  }

  getCos(angle) {
    return Math.cos(angle * 360 / this.countPoints * (Math.PI / 180));
  }

  getSin(angle) {
    return Math.sin(angle * 360 / this.countPoints * (Math.PI / 180));
  }

  updatePoints() {
    for (let i = 0; i < this.countPoints; i++) {
      let point = this.points[i];

      point.x += point.v * this.getCos(i) * this.animationStep;
      point.y += point.v * this.getSin(i) * this.animationStep;

      let distSX = Math.sqrt((point.y - point.startY) ** 2 + (point.x - point.startX) ** 2);
      let distCX = Math.sqrt((point.y) ** 2 + (point.x) ** 2);
      let distCS = Math.sqrt((point.startY) ** 2 + (point.startX) ** 2);

      point.v += (distSX * point.velocityCoeff) * (Math.max(distCX, distSX, distCS) === distCX ? -1 : 1);
      point.v *= this.reflectionCoeff;
    }
  }

  renderPoints() {
    this.context.clearRect(0, 0, window.innerWidth, window.innerHeight);
    let radius = Math.max(window.innerWidth, window.innerHeight) * this.radiusCoeff;

    for (let i = 0; i < this.countPoints; i++) {
      let point = this.points[i];
      let x = (window.innerWidth / 2) + point.x * radius;
      let y = (window.innerHeight / 2) + point.y * radius;

      this.context.beginPath();

      // градиент
      this.context.arc(x, y, point.radius, 0, Math.PI * 2);
      let gradient = this.context.createRadialGradient(x, y, 0, x, y, point.radius);
      gradient.addColorStop(0, point.firstColor);
      gradient.addColorStop(1, point.secondColor);
      this.context.globalCompositeOperation = 'overlay';
      this.context.fillStyle = gradient;

      // точки
      // this.context.arc(x, y, 5, 0, Math.PI * 2);
      // this.context.fillStyle = point.firstColor;

      // линии
      // let p0 = this.points[(i + 1) % this.countPoints];
      // let p2 = this.points[(i + 2) % this.countPoints];
      // this.context.lineWidth = 2;
      // this.context.moveTo(point.startX, point.startY);
      // this.context.bezierCurveTo(point.startX, point.startY, p2.x, p2.y, p0.x, p0.y);
      // this.context.quadraticCurveTo(p0.x, p0.y, p2.x, p2.y);
      // this.context.arc(p0.x, p0.y, 10, 0, Math.PI*2);
      // this.context.stroke();

      this.context.fill();
    }
  }

  play() {
    this.updatePoints();
    this.renderPoints();
    setTimeout(() => {
      window.requestAnimationFrame(this.play.bind(this));
    }, this.animationDelay);
  }

  resize() {
    this.canvas.width = window.innerWidth;
    this.canvas.height = window.innerHeight;
  }
}

export default {
  name: 'Background',
  data() {
    return {
      documentTitle: 'карты',
      bounds: null,
      canvas: null,
      countPoints: 100,
      minR: 50,
      maxR: 100,
      startVelocity: 0.5,
      reflectionCoeff: 1,
      mainVelocityCoeff: 0.04,
      radiusCoeff: 0.33,
      animationStep: 0.1,
      animationDelay: 50,
    };
  },
  methods: {
    init() {
      this.canvas = document.getElementById('canvas');
      this.bounds = new Bounds(
        this.canvas,
        this.countPoints,
        this.minR,
        this.maxR,
        this.startVelocity,
        this.reflectionCoeff,
        this.mainVelocityCoeff,
        this.radiusCoeff,
        this.animationStep,
        this.animationDelay,
      );
      if (this.animated) {
        this.bounds.play();
      }
    },
  },
  props: {
    animated: {
      type: Boolean,
      default: false,
    },
  },
  created() {
    document.title = this.documentTitle;
  },
  mounted() {
    this.init();
  },
};
</script>

<style scoped>
.background {
  position: fixed;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: hidden;
  z-index: -1;
  /*background: rgba(17, 16, 29, 0.85);*/
  /*background: url('../assets/images/special/background.jpg');*/
}
.background:before {
  content: '';
  background-image: url('../assets/images/special/background.jpg');
  position: absolute;
  margin: 0;
  padding: 0;
  width: 130%;
  height: 130%;
  left: -15%;
  top: -15%;
  -webkit-filter: blur(30px);
  filter: blur(10px) brightness(0.5);
}
main {
  width: 100%;
  height: 100%;
}
main canvas {
  filter: blur(60px);
}
</style>
