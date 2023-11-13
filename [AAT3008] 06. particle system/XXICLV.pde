import java.util.ArrayList;

PImage img;
ArrayList<ArrayList<Particle>> L = new ArrayList<ArrayList<Particle>>(); 

boolean clicked = false;
int layer = 0;
int startFire;
float cx, cy;
float sp = 1.3;

void setup() {
  size(360, 360);
  
  for (int n = 0; n < 10; n++) {
    img = loadImage("src/de-" + n + ".png");
    img.loadPixels();
    
    ArrayList<Particle> P = new ArrayList<Particle>();
    for (int i = 0; i < 360; i++) {
      for (int j = 0; j < 360; j++) {
        int idx = i * 360 + j;
        int pixelColor = img.pixels[idx];
        int r = (pixelColor >> 16) & 0xFF;
        int g = (pixelColor >> 8) & 0xFF;
        int b = pixelColor & 0xFF;
        Particle p = new Particle(n, j, i, r, g, b);
        P.add(p);
      }
    }
    L.add(P);
  }
}

void draw() {
  background(255);
  
  noStroke();
  for (int j = 1; j >= 0; j--) {
    for (int i = 0; i < 129600; i++) {
      L.get(j).get(i).show();
    }
  }
  
  if (sp * (frameCount - startFire) > 500 && clicked) {
    clicked = false;
    ArrayList<Particle> temp = L.get(0);
    L.remove(0); L.add(temp);
    layer++;
  }
}

void mousePressed() {
  if (!clicked) {
    cx = mouseX;
    cy = mouseY;
    startFire = frameCount;
    clicked = true;
  }
}

class Particle {
  float x, y, o;
  int r, g, b, n;
  boolean alive;

  Particle(int n, float x, float y, int r, int g, int b) {
    this.n = n;
    this.x = x;
    this.y = y;
    this.r = r;
    this.g = g;
    this.b = b;
    this.alive = true;
  }
  
  void show() {
    if (layer % 10 == this.n && clicked) {
      if (alive) {
        float d = dist(cx, cy, this.x, this.y);
  
        if (d <= sp * (frameCount - startFire + 3 + random(5)) && 
            d >  sp * (frameCount - startFire + 2 + random(5))) {
              int rr = floor(random(200, 256));
              int rg = floor(random(50, 150));
              int rd = floor(random(2, 5));
              fill(rr, rg, 0);
              ellipse(this.x + 0.5, this.y + 0.5, rd, rd);
        } else if (d <= sp * (frameCount - startFire + 2 + random(6)) && 
                   d >  sp * (frameCount - startFire + 1 + random(6))) {
              fill(0);
              ellipse(this.x + 0.5, this.y + 0.5, 2, 2);
        } else if (d <= sp * (frameCount - startFire + 1 + random(6))) {
              alive = false;
        } else {
              fill(r, g, b);
              ellipse(this.x + 0.5, this.y + 0.5, 1.3, 1.3);
        }
      }
      
    } else {
      fill(r, g, b);
      ellipse(this.x + 0.5, this.y + 0.5, 1.3, 1.3);
    }
  }
}
