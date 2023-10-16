// https://editor.p5js.org/dus24k/sketches/nC_b4YcbE

let buttonPressed = false;
let buttonColor = 0, inputColor = 0, outputColor = 0;
let numSegments = 50; let diff = 5;
let direction = 'up';
let xCor = [], yCor = [], aCor = [], bCor = [];
let trueCount = 0, falseCount = 0;

function setup()
{
  createCanvas(400, 400);
  rectMode(CENTER);
  colorMode(HSB);
  textAlign(CENTER, CENTER);
  
  for (let i = 0; i < numSegments; i++) {
    xCor.push(50);  yCor.push(200 + i * diff);
    aCor.push(200); bCor.push(200 + i * diff);
  }
}

function draw()
{
  background(216, 3, 70);
  // text(mouseX + ',' + mouseY, 30, 15);
  
  circuit();
  if (buttonPressed)
    {
      for (let i = 0; i < numSegments - 1; i++) {
        push();
        strokeWeight(5);
        cycleColor(xCor, yCor, inputColor);
        if (inputColor < 0) stroke(0, 50, 100);
        else stroke(120, 50, 100);
        line(xCor[i], yCor[i], xCor[i + 1], yCor[i + 1]);
        
        cycleColor(aCor, bCor, outputColor);
        if (outputColor < 0) stroke(0, 50, 100);
        else stroke(120, 50, 100);
        line(aCor[i], bCor[i], aCor[i + 1], bCor[i + 1]);
        pop();
      }
      cycleMovement(xCor, yCor);
      cycleMovement(aCor, bCor);
      
      push();
      textSize(15); textStyle(BOLD);
      text(trueCount /49, 220, 187.5);
      text(falseCount/49, 220, 212.5);
      pop();
      
      if (frameCount <= 100)
      {
        push();
        stroke(0);
        strokeWeight(5.2);
        line(50, 202, 50, 350);
        
        noStroke();
        fill(216, 3, 70);
        rect(200, 400, 400, 95);
        pop();
      }
      else buttonColor = 0;
    }
  else instruction();
  
  // **TRICK**
  push();
  fill(216, 3, 70);
  noStroke();
  rect(200, 200, 10, 300);
  pop();
  
  conditionBox();
  bridge();  
  button();
}

function mousePressed()
{
  if (!buttonPressed && mouseX >= 140 && mouseX < 180)
    {
      if (mouseY >= 175 && mouseY < 200)
        {
          inputColor++; buttonColor++;
          buttonPressed = true;
        }
      else if (mouseY > 200 && mouseY <= 225)
        {
          inputColor--; buttonColor--;
          buttonPressed = true;
        }
      frameCount = 0;
    }
}

function cycleColor(x, y, c)
{
  if (buttonPressed && x[numSegments - 1] == 125 && y[numSegments - 1] == 50)
    {
      if (c < 0)
        { outputColor =  1; trueCount++; }
      else
        { outputColor = -1; falseCount++; }
    }
  
  if (buttonPressed && x[numSegments - 1] == 275 && y[numSegments - 1] == 350)
    {
      if (c > 0)
        { inputColor =  1; trueCount++; }
      else 
        { inputColor = -1; falseCount++; }
    }
}

function cycleMovement(x, y)
{
  for (let i = 0; i < numSegments - 1; i++)
  {
    x[i] = x[i + 1];
    y[i] = y[i + 1];
  }
  
  switch (direction) {
    case 'right':
      if (xCor[numSegments - 1] >= 200) direction = 'down';
      x[numSegments - 1] = x[numSegments - 2] + diff;
      y[numSegments - 1] = y[numSegments - 2];
      break;
    case 'up':
      if (yCor[numSegments - 1] <= 50)  direction = 'right';
      x[numSegments - 1] = x[numSegments - 2];
      y[numSegments - 1] = y[numSegments - 2] - diff;
      break;
    case 'left':
      if (xCor[numSegments - 1] <= 50)  direction = 'up';
      x[numSegments - 1] = x[numSegments - 2] - diff;
      y[numSegments - 1] = y[numSegments - 2];
      break;
    case 'down':
      if (yCor[numSegments - 1] >= 350) direction = 'left';
      x[numSegments - 1] = x[numSegments - 2];
      y[numSegments - 1] = y[numSegments - 2] + diff;
      break;
  }
}

function circuit()
{
  push();
  noFill();
  strokeWeight(5);
  rect(125, 200, 150, 300);
  rect(275, 200, 150, 300);
  pop();
}

function bridge()
{
  push();
  strokeWeight(3);
  line(54, 200, 120, 200);
  
  stroke(0);
  if (buttonColor > 0) { stroke(120, 50, 100); 
                         line(54, 200, 120, 200); }
  line(120, 187.5, 120,   200);
  line(120, 187.5, 150, 187.5);
  
  stroke(0);
  if (buttonColor < 0) { stroke(  0, 50, 100);
                         line(54, 200, 120, 200); }
  line(120,   200, 120, 212.5);
  line(120, 212.5, 150, 212.5);
  pop();
}

function conditionBox()
{
  push();
  textSize(15);
  textStyle(BOLD);
  strokeWeight(2);
  rect(200,  50, 150,  50);
  text("is it Red?", 200, 50);
  rect(200, 350, 150,  50);
  text("is it Green?", 200, 350);
  pop();
}

function button()
{
  push();
  strokeWeight(2);
  fill(120, 50, 100);
  rect(160, 187.5, 40, 25);
  fill(  0, 50, 100);
  rect(160, 212.5, 40, 25);
  pop();
}

function instruction()
{
  push();
  textStyle(BOLD);
  text("press initial state :", 260, 190);
  
  textSize(15); fill(120, 70, 100); text("TRUE" , 225, 210);
  textSize(12); fill(0);            text("or"   , 257, 210);
  textSize(15); fill(0,   70, 100); text("FALSE", 290, 210);
  pop();
}