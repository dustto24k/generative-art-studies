PImage img;
ArrayList<Particle> PList = new ArrayList<Particle>();

boolean clicked = false;
int startFire;
float cx, cy;
float sp = 1.3;

void setup() {
  size(360, 360);
  
  img = loadImage("src/de-" + int(random(10)) + ".png");
  img.loadPixels();
  
  for (int i = 0; i < 360; i++) {
    for (int j = 0; j < 360; j++) {
      int idx = i * 360 + j;
      int pixelColor = img.pixels[idx];
      int r = (pixelColor >> 16) & 0xFF;
      int g = (pixelColor >> 8) & 0xFF;
      int b = pixelColor & 0xFF;
      Particle p = new Particle(j, i, r, g, b);
      PList.add(p);
    }
  }
}

void draw() {
  background(255);
  
  for (int i = 0; i < PList.size(); i++) {
    PList.get(i).show();
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
  int r, g, b;
  boolean alive;

  Particle(float x, float y, int r, int g, int b) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.g = g;
    this.b = b;
    
    this.o = random(4);
    this.alive = true;
  }
  
  void show() {
    if (clicked) {
      if (alive) {
        float d = dist(cx, cy, this.x, this.y);
  
        if (d <= sp * (frameCount - startFire + 4 * frameCount + o)) {
          alive = false;
        } else if (d <= sp * (frameCount - startFire + 2 * frameCount + o)) {
          fill(0);
        } else if (d <= sp * (frameCount - startFire + o)) {
          fill(255, 0, 0);
        } else {
          fill(r, g, b);
        }
        
        ellipse(this.x + 0.5, this.y + 0.5, 0.99, 0.99);
      }
    } else {
      fill(r, g, b);
      ellipse(this.x + 0.5, this.y + 0.5, 0.99, 0.99);
    }
  }
}
