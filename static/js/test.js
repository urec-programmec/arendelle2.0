$( document ).ready(function() {
    var canvas = $('#canvas').get(0),
        context =  canvas.getContext("2d"), 
        countPoints = 30, 
        width, 
        height, 
        radius, 
        minR = 200, 
        maxR = 400,
        centerX, 
        centerY, 
        points = [], 
        reflection = 1, 
        k = 0.04, 
        step = 0.1, 
        vcoeff = 0.4;

    window.addEventListener('resize', restart, false);

    restart();
    animate()

    function restart(){
        resetParameters();
        resetPoints();
        renderPoints();
    }

    function animate(){
        updatePoints();
        renderPoints();
        requestAnimationFrame(animate);
    }

    function resetParameters(){
        width = canvas.width = window.innerWidth;
        height = canvas.height = window.innerHeight;
        radius = Math.min(window.innerWidth, window.innerHeight)/3;
        centerX = width/2;
        centerY = height/2;
    }

    function resetPoints(){
        points = [];
        for(let i = 0; i < countPoints; i++){
            let y = centerY + ((getSin(i)) * (radius + radius * (i % 2 == 0 ? (Math.random() - 0.5) : 0)));
            let x = centerX + ((getCos(i)) * (radius + radius * (i % 2 == 0 ? (Math.random() - 0.5) : 0))); // + (i % 2 == 0 ? (Math.random() - 1) / 2 : 0)
            let v = (Math.random() * 2 - 1) * radius * vcoeff;

            points.push({
                x: x, 
                y: y,
                v : v,
                radius: Math.random() * (maxR - minR) + minR, 
                firstColor : `hsla(${Math.random() * 360}, 50%, 50%, 1)`,
                secondColor : `hsla(${Math.random() * 360}, 50%, 50%, 0)`
            });
        }
    }

    function renderPoints(){
        context.clearRect(0, 0, width, height);

        for (let i = 0; i < countPoints; i+=2){
            let p = points[i];
            
            context.beginPath();
            context.arc(p.x, p.y, p.radius, 0, Math.PI * 2);

            let gradient = context.createRadialGradient(p.x, p.y, 0, p.x, p.y, p.radius);
            gradient.addColorStop(0, p.firstColor);
            gradient.addColorStop(1, p.secondColor);
            
            context.globalCompositeOperation = `overlay`;
            context.fillStyle = gradient;
            // context.fillStyle = p.firstColor;

            
            context.fill();

            // let p0 = points[(i + 1) % countPoints];
            // let p2 = points[(i + 2) % countPoints];
            // context.lineWidth = 5;
            // context.moveTo(p1.x, p1.y); 

            // context.bezierCurveTo(p1.x, p1.y, p2.x, p2.y, p0.x, p0.y);
            
            // context.quadraticCurveTo(p0.x, p0.y, p2.x, p2.y);

            // let gradient = context.createLinearGradient(p0.x, p0.y, p2.x, p2.y);
            // gradient.addColorStop(0,   '#f00'); // red
            // gradient.addColorStop(0.5, '#ff0'); // yellow
            // gradient.addColorStop(1,   '#00f'); // blue

            // context.strokeStyle = gradient;


            // context.arc(p0.x, p0.y, 10, 0, Math.PI*2);
            

            // context.stroke();
        }
    }

    function updatePoints(){
        for (let i = 0; i < countPoints; i+=2){
            let p = points[i],
                p1 = points[(i + 1) % countPoints];

            p.x += p.v * calculateDeltaX(p.x, p.y) * step;
            p.y += p.v * calculateDeltaY(p.x, p.y) * step;

            let dist = Math.sqrt((p.y - p1.y) ** 2 + (p.x - p1.x) ** 2);
            p.v += (dist * k) * (p.y < p1.y && p1.y > centerY && Math.abs(p1.x - centerX) <= radius * Math.sqrt(2) / 2 || 
                                p.y > p1.y && p1.y < centerY && Math.abs(p1.x - centerX) <= radius * Math.sqrt(2) / 2 ||
                                p.x < p1.x && p1.x > centerX && Math.abs(p1.y - centerY) <= radius * Math.sqrt(2) / 2 ||
                                p.x > p1.x && p1.x < centerX && Math.abs(p1.y - centerY) <= radius * Math.sqrt(2) / 2 ? 1 : -1);
            p.v *= reflection;
        }
    }

    function getCos(i){
        return Math.cos(i * 360 / countPoints * (Math.PI / 180)) * (width / height);
    }

    function getSin(i){
        return Math.sin(i * 360 / countPoints * (Math.PI / 180)) * (height / width);
    }

    function calculateDeltaX(x, y) {
        xx = x - centerX;
        return Math.abs(xx) / Math.sqrt((x - centerX) ** 2 + (y - centerY) ** 2) * xx == 0 ? 1 : (xx / Math.abs(xx));
    }

    function calculateDeltaY(x, y) {
        yy = y - centerY;
        return Math.abs(yy) / Math.sqrt((x - centerX) ** 2 + (y - centerY) ** 2) * yy == 0 ? 1 : (yy / Math.abs(yy));
    }

    function getColor() {

        r = Math.random() * 255;
        g = Math.random() * 255;
        b = Math.random() * 255;
    
        return "rgb(" + (r|0) + "," + (g|0) + "," + (b|0) + ")";
    }
});

