// https://editor.p5js.org/dus24k/sketches/Zh3UJisGq

function setup() {
    frameRate(16);
    createCanvas(400, 400);
  }
  
  function draw() {
  
    background(0);
  
    for(let w = width + 200; w > 0; w -= 20)
    {
      let T = frameCount / 10;
      
      let Rw = (w / 20) % 2;
      let Rt = (T % 1);
      
      stroke(0, 0);
      fill(0);
      if (T >= (w / 20 - 4))
      {
          stroke(0, abs(Rw - Rt) * 100);
          fill(w*0.75-50, abs(Rw - Rt) * 100);
      }
      
      ellipse(width/2, height/2, w, w);
    }
  }