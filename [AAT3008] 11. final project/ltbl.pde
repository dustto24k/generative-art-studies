int space = 36;
int unit = 720/space;

boolean SANDBOX = true;
boolean INITIATE = false;
boolean[][] grid = new boolean[unit][unit];
ArrayList<Box> walls = new ArrayList<Box>();
Ray ray;
Particle particle;

void setup() {
  size(720, 720);
  windowMove(590, 180);
  
  rectMode(CENTER);
  buildBarrier();
  particle = new Particle();
}

void draw() {
  
  if (SANDBOX) {
    if (INITIATE) {
      for (int i = 0; i < unit; i++){
        for (int j = 0; j < unit; j++){
          if(grid[i][j]) walls.add(new Box(i, j));
        }
      }
      
      SANDBOX = false;
    }
    
    draw_grid();
  }
  
  else {
    background(0);
    for (Box wall : walls){
      wall.show();
    }
    
    particle.update(mouseX, mouseY);
    particle.show();
    particle.look(walls);
  }
}
