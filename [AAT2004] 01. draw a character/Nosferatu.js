// https://editor.p5js.org/dus24k/sketches/VJsZSjuLD

function setup() {
    createCanvas(400, 400);
  }
  
  function draw() {
    background(120);  
    noStroke();
    
    fill('red');
    triangle(155, 145, 195, 250, 235, 145);
    
    fill('black');
    triangle(130, 160, 195, 300, 260, 160);
    triangle(100, 380, 195, 360, 195, 380)
    rect(155, 160, 80, 220);
    
    fill('white');
    rect(160, 100, 70, 30);
    triangle(160, 100, 195, 50, 230, 100);
    triangle(150, 120, 195, 170, 240, 120);
    
    fill('black');
    triangle(170, 110, 180, 120, 190, 110);
    triangle(200, 110, 210, 120, 220, 110);
    rect(189, 142, 12, 2)
    
    fill('red');
    rect(188, 143, 2, 10);
    
    fill(120);
    rect(160, 30, 70, 50);
  }