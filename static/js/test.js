$( document ).ready(function() {
    var canvas = $('#canvas').get(0),
        context =  canvas.getContext("2d"), 
        countPoints = 100, 
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
        vcoeff = 0.5;

    window.addEventListener('resize', resize, false);

    resetParameters();
    setPoints();
    renderPoints();
    animate();

    function resize(){
        resetPoints();
        resetParameters();
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
        for(let i = 0; i < countPoints; i++){
            points[i].x *= (window.innerWidth / width);
            points[i].startX *= (window.innerWidth / width);
            points[i].y *= (window.innerHeight / height);
            points[i].startY *= (window.innerHeight / height);
        }
    }

    function setPoints(){
        points = [];
        for(let i = 0; i < countPoints; i++){
            let y = centerY + ((getSin(i)) * (radius + radius * (i % 2 == 0 ? (Math.random() - 0.5) : 0)));
            let x = centerX + ((getCos(i)) * (radius + radius * (i % 2 == 0 ? (Math.random() - 0.5) : 0))); // + (i % 2 == 0 ? (Math.random() - 1) / 2 : 0)
            let v = (Math.random() * 2 - 1) * radius * vcoeff;

            points.push({
                startX: x,
                startY: y,
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

        for (let i = 0; i < countPoints; i+=1){
            let p = points[i];
            
            context.beginPath();
            context.arc(p.x, p.y, 5, 0, Math.PI * 2);
            // context.arc(p.x, p.y, 5, 0, Math.PI * 2);

            // let gradient = context.createRadialGradient(p.x, p.y, 0, p.x, p.y, p.radius);
            // gradient.addColorStop(0, p.firstColor);
            // gradient.addColorStop(1, p.secondColor);
            
            // context.globalCompositeOperation = `overlay`;
            // context.fillStyle = gradient;
            context.fillStyle = p.firstColor;

            context.fill();

            // let p0 = points[(i + 1) % countPoints];
            // let p2 = points[(i + 2) % countPoints];
            // context.lineWidth = 5;
            // context.moveTo(p.startX, p.startY); 

            // context.bezierCurveTo(p.startX, p.startY, p2.x, p2.y, p0.x, p0.y);
            
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
        for (let i = 0; i < countPoints; i++){
            let p = points[i];

            p.x += p.v * getCos(i) * step;
            p.y += p.v * getSin(i) * step;

            let distSX = Math.sqrt((p.y - p.startY) ** 2 + (p.x - p.startX) ** 2);
            let distCX = Math.sqrt((p.y - centerY) ** 2 + (p.x - centerX) ** 2);
            let distCS = Math.sqrt((centerY - p.startY) ** 2 + (centerX - p.startX) ** 2);
            
            p.v += (distSX * k) * (Math.max(distCX, distSX, distCS) == distCX ? -1 : 1);
            
            // (p.y < p.startY && p.startY > centerY && Math.abs(p.startX - centerX) <= radius * Math.sqrt(3) / 2 || 
            //                     p.y > p.startY && p.startY < centerY && Math.abs(p.startX - centerX) <= radius * Math.sqrt(3) / 2 ||
            //                     p.x < p.startX && p.startX > centerX && Math.abs(p.startY - centerY) <= radius * Math.sqrt(3) / 2 ||
            //                     p.x > p.startX && p.startX < centerX && Math.abs(p.startY - centerY) <= radius * Math.sqrt(3) / 2 ? 1 : -1);
            p.v *= reflection;
        }
    }

    function getCos(i){
        return Math.cos(i * 360 / countPoints * (Math.PI / 180))// * (width / height);
    }

    function getSin(i){
        return Math.sin(i * 360 / countPoints * (Math.PI / 180))// * (height / width);
    }
});

