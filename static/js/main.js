$( document ).ready(function() {
    const circle = $('#circle').get(0);
    const context =  circle.getContext("2d");
    var mouseX = 0;
    var mouseY = 0;

    circle.addEventListener("mousemove", setMousePosition, false);
    window.addEventListener('resize', resizeCircle, false);
    resizeCircle();


    // $('#dot').css({"left":$(document).outerWidth() / 2, "top":$(document).outerHeight() / 2});
    function resizeCircle(){
        circle.width = window.innerWidth;
        circle.height = window.innerHeight;
        draw();
    }
    
    function draw() {
        context.beginPath();
        context.arc(window.innerWidth/2, 
            window.innerHeight/2, 
            Math.min(window.innerWidth, window.innerHeight)/3, 
            0, 
            2 * Math.PI, 
            true);
        context.stroke();
    }  
    
    function setMousePosition(e) {
        mouseX = e.clientX;
        mouseY = e.clientY;
        $("#dot").text("x:" + mouseX + " y:" + mouseY);
        $("#dot").css({"left":mouseX, "top":mouseY});

    }
});




function test2(){
    var gravity = 0.1, 
        friction = 0.9;

    var points = [];
    for(let i = 0; i < 100; i++){
        let x = Math.random() * width | 0;
        let y = Math.random() * height | 0;
        let kx = 5 + Math.random() * 5 * (Math.random() > 0.5 ? 1 : -1);    
        let ky = 5 + Math.random() * 5 * (Math.random() > 0.5 ? 1 : -1);    

        points.push({
            x: x, 
            y: y,
            oldx: x - kx,
            oldy: y - ky
        });
    }


    update();

    function update() {
        updatePoints();
        renderPoints();
        requestAnimationFrame(update);
    }

    function updatePoints(){
        for (let i = 0; i < points.length; i++){
            let p = points[i], 
                vy = p.y - p.oldy,    
                vx = p.x - p.oldx;
                if(vy == 0){
                    vx *= friction;
                } 

            p.oldx = p.x;
            p.oldy = p.y;
            p.x += vx;
            p.y += vy + gravity;

            if(p.x > width){
                p.x = width;
                p.oldx = p.x + vx;
            } else if(p.x < 0){
                p.x = 0;
                p.oldx = vx;
            }

            if(p.y > height){
                p.y = height;
                p.oldy = p.y + vy;
            } else if(p.y < 0){
                p.y = 0;
                p.oldy = vy;
            }
        }
    }   

    function renderPoints(){
        context.clearRect(0, 0, width, height);
        for (let i = 0; i < points.length; i++){
            let p = points[i];
            context.beginPath();
            context.arc(p.x, p.y, 1, 0, Math.PI * 2);
            context.stroke();
        }
    }
}