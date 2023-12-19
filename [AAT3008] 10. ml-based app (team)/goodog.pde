import java.util.ArrayList;
import oscP5.*;
import netP5.*;

ArrayList<ArrayList<PImage>> imgList = new ArrayList<ArrayList<PImage>>();
String[] keys = {"idle", "highfive", "sit_idle", "sit", "lay_idle", "lay"};
int[] vals = {2, 3, 2, 3, 2, 2};

boolean animInPlay = false;
int animBegin = -5;
int animIdx = 0;
int idle = 0;

OscP5 oscP5;
NetAddress dest;
int ML_Out; int[] wek_to_idx = {3, 1, 5, 0};

public void setup(){
  size(800, 800);
  frameRate(5);
  
  for (int x = 0; x < 6; x++){
    ArrayList<PImage> tmp = new ArrayList<PImage>();
    String k = keys[x]; int v = vals[x];
    
    for (int i = 0; i < v; i++){
      PImage img = loadImage("src/" + k + i + ".png");
      tmp.add(img);
    }
    imgList.add(tmp);
  }
  
  oscP5 = new OscP5(this, 12000);
  dest = new NetAddress("127.0.0.1", 6448);
}

public void draw(){
  background(102,158,207);
  int frame = frameCount - animBegin;
  
  if (animInPlay){
    
    switch(animIdx){
      case 3: // sit
        if (idle == 0){
          if (frame < 3) image(imgList.get(3).get(frame), 0, 0, 800, 800);
          else { idle = 2; end_anim(); }
        }
        else if (idle == 4){
          if (frame < 2) image(imgList.get(5).get(1-frame), 0, 0, 800, 800);
          else { idle = 2; end_anim(); }
        }
        else end_anim();
        break;
        
      case 1: // highfive
        if (idle == 2) from_sit_to(1, frame);
        else if (idle == 4){
          if (frame < 2) image(imgList.get(5).get(1-frame), 0, 0, 800, 800);
          else from_sit_to(1, frame - 2);
        }
        else {
          if (frame < 3) image(imgList.get(3).get(frame), 0, 0, 800, 800);
          else from_sit_to(1, frame - 3);
        }
        break;
        
      case 5: // lay down
        if (idle == 2) from_sit_to(5, frame);
        else if (idle == 0){
          if (frame < 3) image(imgList.get(3).get(frame), 0, 0, 800, 800);
          else from_sit_to(5, frame - 3);
        }
        else end_anim();
        break;
        
      default: // stand up
        if (idle == 2) from_sit_to(0, frame);
        else if (idle == 4){
          if (frame < 2) image(imgList.get(5).get(1-frame), 0, 0, 800, 800);
          else from_sit_to(0, frame - 2);
        }
        else end_anim();
    }
  }
  else {
    image(imgList.get(idle).get(frameCount % 2), 0, 0, 800, 800);
  }
}

void from_sit_to(int idx, int fr){
  switch(idx)
  {
    case 0: // stand up
      if (fr < 3) image(imgList.get(3).get(2-fr), 0, 0, 800, 800);
      else { idle = 0; end_anim(); }
      break;
    case 1: // high five
      if (fr < 3) image(imgList.get(1).get(fr), 0, 0, 800, 800);
      else if (fr < 6) image(imgList.get(1).get(5-fr), 0, 0, 800, 800);
      else { idle = 2; end_anim(); }
      break;
    default: // case 5, lay down
      if (fr < 2) image(imgList.get(5).get(fr), 0, 0, 800, 800);
      else { idle = 4; end_anim(); }
  }
}

void end_anim(){
  animInPlay = false;
  animBegin = frameCount;
  image(imgList.get(idle).get(frameCount % 2), 0, 0, 800, 800);
}

void oscEvent(OscMessage m) {
  if (m.checkAddrPattern("/wek/outputs") == true) {
    if (m.checkTypetag("f")) {
      if (frameCount - animBegin > 5 && !animInPlay) {
        ML_Out = (int)m.get(0).floatValue();
        animIdx = wek_to_idx[ML_Out - 1];
        animInPlay = true; animBegin = frameCount;
      }
    }
  }
}
