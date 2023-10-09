let dotSize = 9;
let rs = 0;
let smallOffset;
let largeOffset;

function setup() {
  createCanvas(600, 600);
  noStroke();
  fill(0);
  smallOffSet = radians(1.5);
  largeOffSet = radians(50);
}

function draw() {
  background(220);
  translate(width/2, height);
  randomSeed(rs);
  seed(0, 0, dotSize, radians(270), 1);
}

function seed(x, y, dotSize, angle, sign)
{
  if (dotSize > 1)
    {
      let r = random(1);
      
      circle(x, y, dotSize);
      let nX = x + dotSize * cos(angle);
      let nY = y + dotSize * sin(angle);
      
      if (r > 0.02)
        seed(nX, nY, dotSize * 0.99, angle + sign * smallOffset,  sign);
      else
      {
        seed(nX, nY, dotSize * 0.99, angle - sign * smallOffset, -sign);
        seed(nX, nY, dotSize * 0.50, angle + largeOffset,  sign);
        seed(nX, nY, dotSize * 0.50, angle - largeOffset, -sign);
      }
    }
}

function keyPressed()
{
  rs = millis();
}