class Ray {
  PVector pos, dir;

  Ray(PVector pos, float angle) {
    this.pos = pos;
    dir = PVector.fromAngle(angle);
  }
  
  void lookat(float x, float y){
    dir.x = x - pos.x;
    dir.y = y - pos.y;
    this.dir.normalize();
  }
  
  void show(){
    stroke(255);
    pushMatrix();
      translate(pos.x, pos.y);
      line(0, 0, dir.x * 10, dir.y * 10);
    popMatrix();
  }
  
  PVector cast(Box wall, int z){
      PVector a = wall.edges.get(z); PVector b;
      if (z == 3) b = wall.edges.get(0);
      else b = wall.edges.get(z+1);
      
      float x1 = a.x;           float y1 = a.y;
      float x2 = b.x;           float y2 = b.y;
      float x3 = pos.x;         float y3 = pos.y;
      float x4 = pos.x + dir.x; float y4 = pos.y + dir.y;
      
      float den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
      if (den == 0) return null;
      
      float t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den;
      float u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / den;
      
      if (t > 0 && t < 1 && u > 0) {
        PVector pt = new PVector();
        pt.x = x1 + t * (x2 - x1);
        pt.y = y1 + t * (y2 - y1);
        return pt;
      }
      else return null;
  }
}


class Box {
  ArrayList<PVector> edges = new ArrayList<PVector>();

  Box(float i, float j) {
    float x = (i+0.5)*space;
    float y = (j+0.5)*space;
    edges.add(new PVector(x-space/2, y-space/2));
    edges.add(new PVector(x-space/2, y+space/2));
    edges.add(new PVector(x+space/2, y+space/2));
    edges.add(new PVector(x+space/2, y-space/2));
  }

  void show() {
    stroke(255);
    for (int i = 0; i < 4; i++){
      PVector a = edges.get(i); PVector b;
      if (i == 3) b = edges.get(0);
      else b = edges.get(i+1);
      line(a.x, a.y, b.x, b.y);
    }
  }
}


void buildBarrier() {
  for (int i = -1; i < unit+1; i++){
    for (int j = -1; j < unit+1; j++){
      if (i == -1 || j == -1 || i == unit || j == unit){
        walls.add(new Box(i, j));
      }
    }
  }
}
