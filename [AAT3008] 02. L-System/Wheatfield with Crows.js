// https://editor.p5js.org/dus24k/sketches/TNWTD3BDU

let S = "F"; let Rule = "F[-F]+[+F+]+";
let PXList = [], PYList = [], CList = [];
let cX = 0, cY = 0, pos = [360, 260], deg = -91;

let size_off = 0.34;  // crow's size
let angle_off = 30.3; // decides pattern of LSystem
let dis_off = 65;     // distance after single draw

function setup()
{
  frameRate(10);
  createCanvas(720, 720);
  bg = loadImage('wheatfield.jpg');
}

function draw()
{
  tint(255, 100);
  image(bg, 0, 0, 850, 850);
  fill(254, 76, 64, 50);
  rect(0, 0, 800, 800);
  fill(0, 0, 0, 30);
  rect(0, 0, 800, 800);
  
  while (PXList.length <= 300)
  {
    create(S, pos);
    S = ApplyRule(S);
    
    if (PXList.length >= 300)
      {
        for (let i = 0; i < PXList.length; i++)
          {
            let R = int(random(3));
            let C = new Crow(PXList[i], PYList[i], R);
            CList.push(C);
          }
      }
  }
  
  for (let i = 0; i < CList.length; i++)
    { CList[i].show(); }
  
  size_off  += 0.002 * cos(frameCount/17);
  angle_off += 0.001 * max(-0.2, cos(frameCount/23));
  dis_off   += 0.4 * cos(frameCount/43);
  S = "F"; CList = [];
  PXList = []; PYList = [];
  deg = -91;
}

function create(S, pos)
{
  for (let i = 0; i < S.length; i++)
    {
      switch(S[i])
        {
          case 'F':
            if (!PXList.includes(pos[0])) PXList.push(pos[0]);
            if (!PYList.includes(pos[1])) PYList.push(pos[1]);
            let pX = pos[0] + dis_off * cos(radians(deg));
            let pY = pos[1] + dis_off * sin(radians(deg));
            pos = [pX, pY];
            break;
          case '+':
            deg += angle_off;
            break;
          case '-':
            deg -= angle_off;
            break;
          case '[':
            cX = pos[0]; cY = pos[1];
            break;
          case ']':
            pos[0] = cX; pos[1] = cY;
            break;
        }
    }
}

function ApplyRule(S)
{
  let result = "";
  for (let i = 0; i < S.length; ++i)
    {
      let c = S[i];
      if (c === 'F')
      {
        result += Rule;
      }
      else
      {
        result += c;
      }
    }
  return result;
}

class Crow
{
  constructor(x, y, r)
  {
    this.x = x;
    this.y = y;
    this.r = r;
    this.o = random(-5, 5);
  }
  
  show()
  {
    push();
    fill(0);
    translate(this.x + this.o, this.y - this.o);

    switch((this.r + frameCount) % 5)
      {
        case 0:
          beginShape();
          vertex(0  * size_off,  0  * size_off);
          vertex(10 * size_off,  1  * size_off);
          vertex(17 * size_off, -7  * size_off);
          vertex(28 * size_off, -12 * size_off);
          vertex(33 * size_off, -23 * size_off);
          vertex(33 * size_off, -14 * size_off);
          vertex(25 * size_off,  1  * size_off);
          vertex(16 * size_off,  9  * size_off);
          vertex(0  * size_off, 12  * size_off);

          vertex(-16 * size_off,  9  * size_off);
          vertex(-25 * size_off,  1  * size_off);
          vertex(-33 * size_off, -14 * size_off);
          vertex(-33 * size_off, -23 * size_off);
          vertex(-28 * size_off, -12 * size_off);
          vertex(-17 * size_off, -7  * size_off);
          vertex(-10 * size_off,  1  * size_off);
          vertex(0   * size_off,  0  * size_off);
          endShape();
          break;

        case 1:
          beginShape();
          vertex(0  * size_off,  0  * size_off);
          vertex(10 * size_off,  1  * size_off);
          vertex(20 * size_off, -6  * size_off);
          vertex(33 * size_off, -5  * size_off);
          vertex(46 * size_off, -4  * size_off);
          vertex(38 * size_off, -1  * size_off);
          vertex(29 * size_off,  0  * size_off);
          vertex(21 * size_off,  7  * size_off);
          vertex(0  * size_off, 12  * size_off);
          vertex(-21 * size_off,  7  * size_off);
          vertex(-29 * size_off,  0  * size_off);
          vertex(-38 * size_off, -1  * size_off);
          vertex(-46 * size_off, -4  * size_off);
          vertex(-33 * size_off, -5  * size_off);
          vertex(-20 * size_off, -6  * size_off);
          vertex(-10 * size_off,  1  * size_off);
          vertex(0  * size_off,   0  * size_off);
          endShape();
          break;

        default:
          beginShape();
          vertex(0  * size_off,  0  * size_off);
          vertex(10 * size_off,  1  * size_off);
          vertex(20 * size_off,  6  * size_off);
          vertex(30 * size_off, 13  * size_off);
          vertex(34 * size_off, 30  * size_off);
          vertex(27 * size_off, 19  * size_off);
          vertex(14 * size_off, 17  * size_off);
          vertex(0  * size_off, 12  * size_off);
          vertex(-14 * size_off, 17  * size_off);
          vertex(-27 * size_off, 19  * size_off);
          vertex(-34 * size_off, 30  * size_off);
          vertex(-30 * size_off, 13  * size_off);
          vertex(-20 * size_off,  6  * size_off);
          vertex(-10 * size_off,  1  * size_off);
          vertex(0  * size_off,  0  * size_off);
          endShape();
          break;
      }
    pop();
  }
}