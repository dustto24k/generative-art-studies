import java.util.Collections;
import java.util.Vector;
import java.util.Arrays;
import java.util.List;

int numOfImg = 30; int numToShow = 7;
List<PImage> imgList = new ArrayList<PImage>();

void setup() {
  frameRate(1);
  size(800, 800);
  imageMode(CENTER);
  
  for (int i = 0; i < numOfImg; i++)
  {
    PImage tmp = loadImage("src/"+i+".jpg");
    imgList.add(tmp);
  }
}

void draw() {
  background(0);
  PImage bg = imgList.get(floor(random(numOfImg))); bg.resize(800, 800);
  image(bg, width/2, height/2);
  
  for (int i = 1; i <= numToShow; i++)
  {
    PImage keyed = Key(imgList.get(i), random(255), random(255), random(255), 215);
    
    int randomWidth = floor(random(300, 800));
    int resizeWidth = Math.min(randomWidth, floor(randomWidth * keyed.width/keyed.height));
    keyed.resize(resizeWidth, 0);
    
    int offX = floor(random(-300, 300)); int offY = floor(random(-300, 300));
    image(keyed, width/2 + offX, height/2 + offY);
  }
  
  Collections.shuffle(imgList);
}

PImage Key(PImage image, float keyR, float keyG, float keyB, int level) {
  image.loadPixels();
  PImage output = createImage(image.width, image.height, ARGB);
  output.loadPixels();
  
  for (int y = 0; y < image.height; y++)
  {
    for (int x = 0; x < image.width; x++)
    {
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
