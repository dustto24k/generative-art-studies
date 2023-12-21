class Particle {
  float fov;
  PVector pos;
  ArrayList<Ray> rays;
  float heading;
  
  Particle() {
    pos = new PVector(width/2, height/2);
    rays = new ArrayList<Ray>();
    fov = 45; heading = 0;
    updateRays();
  }
  
  float[] look(ArrayList<Box> walls){
    float[] scene = new float[this.rays.size()];
    for (int i = 0; i < this.rays.size(); i++){
      Ray ray = this.rays.get(i);
      float rec = Float.POSITIVE_INFINITY;
      for (Box wall : walls){
        for (int z = 0; z < 4; z++) {
          PVector pt = ray.cast(wall, z);
          if (pt != null){
            float d = PVector.dist(pos, pt);
            if (d < rec) rec = d;
          }
        }
      }
      scene[i] = rec;
    }
    return scene;
  }
  
  void setHead(float angle){
    heading = angle;
    updateRays();
  }

  void rotate(float angle) {
    heading += angle;
    updateRays();
  }

  void move(float amt) {
    PVector vel = PVector.fromAngle(heading);
    vel.setMag(amt);
    pos.add(vel);
  }
  
  void update(float x, float y){
    pos.set(x, y);
  }

  void updateRays() {
    rays = new ArrayList<Ray>();
    for (float a = -fov / 2; a < fov / 2; a += 1) {
      rays.add(new Ray(pos, radians(a) + heading));
    }
  }
  
  void show(){
    fill(255);
    ellipse(pos.x, pos.y, 16, 16);
    
    for (int i = 0; i < rays.size(); i++)
      rays.get(i).show();
  }
}
