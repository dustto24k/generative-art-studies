import java.util.List;
import processing.video.*;
import oscP5.*;
Capture cam;
OscP5 oscP5;

List<PImage> jetSpr = new ArrayList<PImage>();

float steer = 0;
float tilt = 0;

void setup() {
  size(1280, 960);
  // windowMove(320, 40);
  
  imageMode(CENTER);
  rectMode(CENTER);
  
  for (int i = 0; i < 15; i++) {
    PImage tmp = loadImage("src/jet_"+i+".png");
    jetSpr.add(tmp);
  }

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("no cam available");
    exit();
  } else {
    println("available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    cam = new Capture(this, cameras[1]);
    cam.start();     
  }  

  oscP5 = new OscP5(this, 12000);
}

void draw() {
  if (cam.available()) cam.read();
  background(0); image(cam, width/2, height/2, width, height);
  draw_jet();
}

void draw_jet() {
  int idx = floor( map(steer, -1.3, 1.3, 0, 14.99) );
  int ypos = height/2+150 + floor( map(tilt, -1.3, 1.3, -300, 300) );
  image(jetSpr.get(idx), width/2, ypos);
}

void oscEvent(OscMessage m) {
  if (m.checkAddrPattern("/wek/outputs")==true) {
    if (m.checkTypetag("ff")) {
      steer = m.get(0).floatValue();
      tilt = m.get(1).floatValue();
    }
  }
}
