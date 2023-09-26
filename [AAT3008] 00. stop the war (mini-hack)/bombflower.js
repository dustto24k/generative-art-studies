// https://editor.p5js.org/dus24k/sketches/atrEWtX86

let shapeList = [];

function setup() {
  frameRate(30);
  createCanvas(800, 800);
  
  // a1 = loadImage('amFlag.png');
  a2 = loadImage('bomb.png');
  // a3 = loadImage('bomber.png');
  // a4 = loadImage('cloud.png');
  // a5 = loadImage('eye1.png');
  // a6 = loadImage('eye2.png');
  // a7 = loadImage('face.png');
  // a8 = loadImage('foot.png');
  // a9 = loadImage('gmFlag.png');
  // a10 = loadImage('house.png');
  // a11 = loadImage('kid.png');
  // a12 = loadImage('mushroom.png');
  // a13 = loadImage('rats.png');
  // a14 = loadImage('road.png');
  // a15 = loadImage('stamp.png');
  // a16 = loadImage('trenchFoot1.png');
  // a17 = loadImage('trenchFoot2.png');
  back = loadImage('original.png');
  // let imgList = [a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17];
  
  for (let i = 0; i < 50; i++)
  {
    // randImgN = random(16);
    // randImg = imgList[randImgN];
    ns = new Shape();
    shapeList.push(ns);
  }
    
}

function draw() {
  background(220);
  image(back, -50, -50);
  for (let i = 0; i < shapeList.length; i++)
    {
      shapeList[i].show();
    }
}

function mouseClicked()
{
  shapeList.splice(0, 1)
}

class Shape
  {  
  // constructor(x)
  //   {
  //     this.Img = x;
  //   }
  show()
    {
      // rectMode(CENTER);
      image(a2, random(-150, width-50), random(-150, height-50), 300, 300);
    }
    
  }