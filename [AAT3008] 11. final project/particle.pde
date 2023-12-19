class Particle {
  PVector pos;
  ArrayList<Ray> rays;
  
  Particle() {
    pos = new PVector(width/2, height/2);
    rays = new ArrayList<Ray>();
    
    for (int i = 0; i < 360; i += 1) {
      Ray ray = new Ray(pos, radians(i));
      rays.add(ray);
    }
  }
  
  void look(ArrayList<Box> walls){
    for (Ray ray : rays){
      PVector closest = null;
      float rec = Float.POSITIVE_INFINITY;
      for (Box wall : walls){
        for (int z = 0; z < 4; z++) {
              PVector pt = ray.cast(wall, z);
              if (pt != null){
                float d = PVector.dist(pos, pt);
                if (d < rec) {
                  rec = d;
                  closest = pt;
                }
              }
        }
      }
      if (closest != null){
        stroke(255, 100);
        line(pos.x, pos.y, closest.x, closest.y);
      }
    }
  }
  
  void update(float x, float y){
    pos.set(x, y);
  }
  
  void show(){
    fill(255);
    ellipse(pos.x, pos.y, 16, 16);
    
    for (int i = 0; i < rays.size(); i++){
      rays.get(i).show();
    }
  }
}
