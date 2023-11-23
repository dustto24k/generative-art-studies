import processing.video.*;
import oscP5.*;
Capture cam;
OscP5 oscP5;

int steer = 2;

void setup() {
  size(1280, 960);
  windowMove(320, 40);

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
  background(0); image(cam, 0, 0, width, height);
  
}

void oscEvent(OscMessage m) {
  if (m.checkAddrPattern("/wek/outputs")==true) {
    if (m.checkTypetag("f")) {
      steer = m.get(0).intValue();
      
      if (steer == 1) {
        
      } else if (steer == 3) {
        
      }
    }
  }
}
