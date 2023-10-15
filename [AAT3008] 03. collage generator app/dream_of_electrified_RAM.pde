import java.util.Collections;
import java.util.Vector;
import java.util.Arrays;
import java.util.List;

int RENDERMODE = 3; int numToShow = 25;
/*
  1 :   random chroma shift +   auto reset (recommended numToshow =  7+)
  2 :   random chroma shift + manual reset (recommended numToshow = 15+)
  3 : animated chroma shift + manual reset (recommended numToshow = 25+)
*/

int numOfImg = 30;
int[] rwLst = new int[numToShow];
int[] oxLst = new int[numToShow];
int[] oyLst = new int[numToShow];
List<PImage> imgList = new ArrayList<PImage>();

float R = 0, G = 0, B = 0;
float t = 5;

void setup() {
  if (RENDERMODE == 1) frameRate(1);
  else frameRate(60);
  
  size(800, 800);
  imageMode(CENTER);
  
  for (int i = 0; i < numOfImg; i++) {
    PImage tmp = loadImage("src/"+i+".jpg");
    imgList.add(tmp);
  }
  
  if (RENDERMODE != 1) {
    for (int i = 0; i < numToShow; i++) {
      int ranW = floor(random(300, 800));
      int offX = floor(random(-300, 300));
      int offY = floor(random(-300, 300));
      rwLst[i] = ranW; oxLst[i] = offX; oyLst[i] = offY;
    }
  }
}

void draw() {
  background(0);
  if (RENDERMODE == 1) {
    PImage bg = imgList.get(floor(random(numOfImg))); bg.resize(800, 800);
    image(bg, width/2, height/2);
  }
  
  for (int i = 0; i < numToShow; i++) {
    PImage keyed;
    
    if (RENDERMODE == 3) keyed = Key(imgList.get(i), R, G, B, 150);
    else if (RENDERMODE == 2) keyed = Key(imgList.get(i), random(255), random(255), random(255), 150);
    else keyed = Key(imgList.get(i+1), random(255), random(255), random(255), 215);
    
    if (RENDERMODE == 1) {
      int randomWidth = floor(random(300, 800));
      int resizeWidth = Math.min(randomWidth, floor(randomWidth * keyed.width/keyed.height));
      int offX = floor(random(-300, 300)); int offY = floor(random(-300, 300));
      keyed.resize(resizeWidth, 0); image(keyed, width/2 + offX, height/2 + offY);
    }
    
    else {
      int resizeWidth = Math.min(rwLst[i], floor(rwLst[i] * keyed.width/keyed.height));
      keyed.resize(resizeWidth, 0); image(keyed, width/2 + oxLst[i], height/2 + oyLst[i]);
    }
  }
  
  R += t; G += t; B += t;
  if (frameCount % floor(254/abs(t)) == 0) t *= -1;
  
  if (RENDERMODE == 1) Collections.shuffle(imgList);
}

void mousePressed() {
  if (RENDERMODE != 1) {
    for (int i = 0; i < numToShow; i++) {
      int ranW = floor(random(300, 800));
      int offX = floor(random(-300, 300));
      int offY = floor(random(-300, 300));
      
      rwLst[i] = ranW; oxLst[i] = offX; oyLst[i] = offY;
    }
    Collections.shuffle(imgList);
  }
}

PImage Key(PImage image, float keyR, float keyG, float keyB, int level) {
  image.loadPixels();
  PImage output = createImage(image.width, image.height, ARGB);
  output.loadPixels();
  
  for (int y = 0; y < image.height; y++) {
    for (int x = 0; x < image.width; x++) {
      int pixelColor = image.get(x, y);
      float pixR = red(pixelColor);
      float pixG = green(pixelColor);
      float pixB = blue(pixelColor);
      
      float d = dist(keyR, keyG, keyB, pixR, pixG, pixB);
      float pixA = alpha(pixelColor);
      
      if (d < level) pixA = 0;
      
      output.set(x, y, color(pixR, pixG, pixB, pixA));
    }
  }
  
  output.updatePixels();
  return output;
}
