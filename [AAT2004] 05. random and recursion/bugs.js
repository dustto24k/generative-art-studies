// https://editor.p5js.org/dus24k/sketches/1qe0oCn_w

function setup() {
  frameRate(1);
  createCanvas(720, 480);
  rectMode(CENTER);
  imageMode(CENTER);
  strokeWeight(2);
  stroke(255);
  noFill();
  bugs = loadImage('bugs.png');
}

function draw() {
  background(random(75, 255), random(75, 255), random(75, 255));
  translate(width/2, height/2);
  frame(width - 80);
}

function frame(w)
{
  if (w > 20)
    {      
      frame(w * 0.8);
      
      let r = int(random(3.9));
      let s = 1; if (int(random(1.9))%2) s = -1;
      switch(r)
        {
          case 0:
            scale(s, 1);
            image(bugs, w * random(-0.4, 0.4), 0.25 * w, w/3.6, w/2.25);
            break;
          case 1:
            push();
            rotate(radians(180));
            scale(s, 1);
            image(bugs, w * random(-0.4, 0.4), 0.25 * w, w/3.6, w/2.25);
            pop();
            break;
          case 2:
            push();
            rotate(radians(90));
            scale(s, 1);
            image(bugs, w * random(-0.2, 0.2),  0.4 * w, w/3.6, w/2.25);
            pop();
            break;
          default:
            push();
            rotate(radians(270));
            scale(s, 1);
            image(bugs, w * random(-0.2, 0.2),  0.4 * w, w/3.6, w/2.25);
            pop();
            break;
        }
      
      push();
      noStroke();
      fill(random(75, 255), random(75, 255), random(75, 255));
      rect(-0.6 * w, 0, 0.2 * w, 0.67 * w);
      rect( 0.6 * w, 0, 0.2 * w, 0.67 * w);
      rect(0, -0.4 * w, 1.3 * w, 0.14 * w);
      rect(0,  0.4 * w, 1.3 * w, 0.14 * w);
      pop();
      
      rect(0, 0, w, w * 0.66);
    }
}