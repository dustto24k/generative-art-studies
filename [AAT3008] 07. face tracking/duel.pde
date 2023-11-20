import processing.video.*;
import ddf.minim.*;
import oscP5.*;
import netP5.*;

int found;
float poseX;
float poseY;
float mouthHeight;
float mouthWidth;
float eyeLeft;
float eyeRight;
float eyebrowLeft;
float eyebrowRight;
float jaw;
float nostrils;

ArrayList<Piece> Rope = new ArrayList<Piece>();
float sparkX;
float sparkY;

float burnSpd = 2;
float tension = 0.5;

int expStart = 0;
boolean expAudi = false;
boolean expAnim = true;

PImage img;
Minim minim;
AudioPlayer boom;
OscP5 oscP5;
NetAddress dest;

void setup() {
  size(480, 480);
  
  float distance = 0;
  float angle = 0;
  float angularSpeed = 0.01;
  float distanceSpeed = 0.06;
  float drawingSpeed = 200;
  while(distance < width/2){
    for (int i = 0; i < drawingSpeed; i++){
      angle += angularSpeed;
      distance += distanceSpeed;
      
      float x = sin(angle) * distance + width/2;
      float y = cos(angle) * distance + height/2;
      Piece p = new Piece(x, y);
      Rope.add(p);
    }
  }
  
  sparkX = Rope.get(Rope.size()-1).x;
  sparkY = Rope.get(Rope.size()-1).y;

  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
  oscP5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
  oscP5.plug(this, "eyeLeftReceived", "/gesture/eye/left");
  oscP5.plug(this, "eyeRightReceived", "/gesture/eye/right");
  oscP5.plug(this, "eyebrowLeftReceived", "/gesture/eyebrow/left");
  oscP5.plug(this, "eyebrowRightReceived", "/gesture/eyebrow/right");
  oscP5.plug(this, "jawReceived", "/gesture/jaw");
  oscP5.plug(this, "nostrilsReceived", "/gesture/nostrils");
  
  dest = new NetAddress("127.0.0.1", 6448);
  
  img = loadImage("floor.jpg");
  minim = new Minim(this);
  boom = minim.loadFile("boom.mp3");
}

void draw() {
  
  if (Rope.size() > 1) {
      image(img, 0, 0, width, height);
      noStroke(); fill(0, 0, 0, 70);
      rect(0, 0, width, height);
      
      for (Piece p : Rope) {
        p.display();
      }
      
      spark(sparkX, sparkY);
    
      if (found > 0) {
        float[] faceInfo = new float[8];
        faceInfo[0] = mouthWidth;
        faceInfo[1] = mouthHeight;
        faceInfo[2] = poseY - eyeLeft;
        faceInfo[3] = poseY - eyeRight;
        faceInfo[4] = poseY - eyebrowLeft;
        faceInfo[5] = poseY - eyebrowRight;
        faceInfo[6] = poseY - jaw;
        faceInfo[7] = poseY - nostrils;
        
        sendOsc(faceInfo);
      } else {
        burnSpd = 2;
      }
    
      if (tension > 0.5) {
        burnSpd += tension;
      } else {
        burnSpd += 0.6;
      }
      
      for (int i = 0; i < (int)(burnSpd); i++) {
        if (Rope.size() <= 1) break;
        Rope.remove(Rope.size()-1);
        sparkX = Rope.get(Rope.size()-1).x;
        sparkY = Rope.get(Rope.size()-1).y;
      }
  }
  
  else if (expAnim) {
      image(img, 0, 0, width, height);
      noStroke(); fill(0, 0, 0, 70);
      rect(0, 0, width, height);
        
      if (expStart == 0) expStart = frameCount;
      int sec = frameCount - expStart;
      
      if (!expAudi) {
        expAudi = true;
        boom.play();
      }
      
      for (int i = 0; i < 30; i++) {
        noStroke();
        fill(floor(random(200, 256)), floor(random(50, 150)), 0);
        beginShape();
        vertex(random(240-sec*20, 240+sec*20), random(240-sec*20, 240+sec*20));
        vertex(random(240-sec*20, 240+sec*20), random(240-sec*20, 240+sec*20));
        vertex(random(240-sec*20, 240+sec*20), random(240-sec*20, 240+sec*20));
        endShape();
      }
      
      if (sec >= 15) {
        expAnim = false;
      }
  }
  
  else {
      background(0);
      minim.stop();
      super.stop();
  }
}

public void found(int i) {
  found = i;
}

public void posePosition(float x, float y) {
  poseX = x; poseY = y;
}

public void mouthWidthReceived(float x) {
  mouthWidth = x;
}

public void mouthHeightReceived(float x) {
  mouthHeight = x;
}

public void eyeLeftReceived(float x) {
  eyeLeft = x;
}

public void eyeRightReceived(float x) {
  eyeRight = x;
}

public void eyebrowLeftReceived(float x) {
  eyebrowLeft = x;
}

public void eyebrowRightReceived(float x) {
  eyebrowRight = x;
}

public void jawReceived(float x) {
  jaw = x;
}

public void nostrilsReceived(float x) {
  nostrils = x;
}

void sendOsc(float[] px) {
  OscMessage msg = new OscMessage("/wek/inputs");
  for (int i = 0; i < px.length; i++) {
    msg.add(px[i]);
  }
  oscP5.send(msg, dest);
}

void oscEvent(OscMessage m) {

  if (m.checkAddrPattern("/wek/outputs")==true) {

    if (m.checkTypetag("f")) {

      tension = m.get(0).floatValue();
      println(tension);
    }
  }
}

class Piece {
  float x, y;
  
  Piece(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void display() {
    stroke(0);
    strokeWeight(0.2);
    fill(131, 105, 83);
    ellipse(x, y, 30, 30);
  }
}

void spark(float x, float y) {
  for (int n = 0; n < 80; n++) {
    float x2 = x + random(-25, 25);
    float y2 = y + random(-25, 25);
    
    stroke(floor(random(200, 256)), floor(random(50, 150)), 0);
    strokeWeight(random(1,4));
    line(x, y, x2, y2);
  }
}
