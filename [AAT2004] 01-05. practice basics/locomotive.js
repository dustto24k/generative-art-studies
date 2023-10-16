// https://editor.p5js.org/dus24k/sketches/-omvL_72x

function setup()
{
  createCanvas(600, 400);
}

function draw()
{
  rodDeg = radians(-180 + frameCount * 6);
  
  background("skyblue");
  fill('black');
  text(mouseX + "," + mouseY, 5, 10);
  
  strokeWeight(2);
  fill('chocolate');
  rect(0, 350, 600, 50);
  
  // body
  fill('red');
  rect(40, 120, 135, 125);
  fill('black')
  rect(175, 145, 350, 100);
  rect(440, 80, 40, 100);
  circle(505, 195, 100);
  fill('yellow');
  rect(420, 145, 12, 100);
  rect(440, 145, 6, 100);
  rect(551, 190.5, 8, 15);
  fill('grey');
  rect(70, 245, 200, 70);
  rect(270, 245, 180, 40);
  rect(400, 285, 130, 30);
  
  fill('green');
  rect(422, 285, 10, 30);
  rect(452, 285, 10, 30);
  rect(482, 285, 10, 30);
  rect(512, 285, 10, 30);
  rect(400, 310, 130, 10);
  
  // parts
  wheel(100, 300);
  wheel(250, 300);
  rod1(50 * cos(rodDeg) + 100, 50 * sin(rodDeg) + 300);
  rod2(50 * cos(rodDeg) + 250, 50 * sin(rodDeg) + 300, 350 + 50 * cos(rodDeg), 280);
  rod3(350 + 50 * cos(rodDeg), 280);
  wheeel(400, 315);
  gear(100, 300);
  gear(250, 300);
  
  fill('green');
  circle(350 + 50 * cos(rodDeg), 280, 20);
  
  // pistontank
  fill('grey');
  rect(450, 245, 100, 55);

  wheeel(530, 315);
  
  // window
  fill('skyblue');
  rect(55, 140, 40, 60);
}

function wheel(x, y)
{
  push();
    translate(x, y);
    rotate(rodDeg);
  
  strokeWeight(5);
  fill(0, 0, 0, 0);
  circle(0, 0, 100);
  
  fill('black');
  circle(0, 0, 10);
  line(0,0,0,50);
  line(0,0,50,0);
  line(0,0,-50,0);
  line(0,0,0,-50);
  line(0,0,25*2**0.5,25*2**0.5);
  line(0,0,-25*2**0.5,25*2**0.5);
  line(0,0,-25*2**0.5,-25*2**0.5);
  line(0,0,25*2**0.5,-25*2**0.5);
  pop();
}

function wheeel(x, y)
{
  push();
    translate(x, y);
    rotate(rodDeg * (10/7));
  strokeWeight(4);
  fill(0, 0, 0, 0);
  circle(0, 0, 70);
  
  fill('black');
  circle(0, 0, 10);
  line(0,0,0,35);
  line(0,0,35,0);
  line(0,0,-35,0);
  line(0,0,0,-35);
  line(0,0,17.5*2**0.5,17.5*2**0.5);
  line(0,0,-17.5*2**0.5,17.5*2**0.5);
  line(0,0,-17.5*2**0.5,-17.5*2**0.5);
  line(0,0,17.5*2**0.5,-17.5*2**0.5);
  pop();
}

function gear(x, y)
{
  push();
    translate(x, y);
    rotate(rodDeg);
  
  strokeWeight(2);  
  fill('green');
  circle(50, 0, 20);
  pop();
}

function rod1(x, y)
{
  push();
  strokeWeight(2);
  fill('green');
  rect(x, y-5, 150, 10);
  pop();
}

function rod2(x1, y1, x2, y2)
{
  push();
  fill('green');
  strokeWeight(2);
  beginShape();
  vertex(x1, y1+5);
  vertex(x1, y1-5);
  vertex(x2, y2-5);
  vertex(x2, y2+5);
  vertex(x1, y1+5);
  endShape();
  pop();
}

function rod3(x, y)
{
  push();
  strokeWeight(2);
  fill('green');
  rect(x, y-5, 150, 10);
  pop();
}