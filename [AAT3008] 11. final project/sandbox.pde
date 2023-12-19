void draw_grid() {
    background(255);
    stroke(0); strokeWeight(3);
    
    for (int i = 0; i < unit; i++){
      for (int j = 0; j < unit; j++){
        if(grid[i][j]) fill(0);
        else fill(255);
        rect(space*(i+0.5), space*(j+0.5), space, space);}}
    
    noFill(); rect(width/2, height/2, width-2, height-2);
}

void mouseDragged() {
  if (mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height) {
    int p = floor(mouseX/space);
    int q = floor(mouseY/space);
    grid[p][q] = true;
  }
}

void keyPressed() {
  if (key == ' '){
      if (!INITIATE) INITIATE = true;
      else reset();
  }
}

void reset() {
  grid = new boolean[unit][unit];
  walls = new ArrayList<Box>();
  particle = new Particle();
  buildBarrier();
  
  INITIATE = false;
  SANDBOX = true;
}
