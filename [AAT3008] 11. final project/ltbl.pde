int space = 36;
int unit = 720/space;

boolean SANDBOX = true;
boolean INITIATE = false;
boolean PATH_FOUND = false;
int start, goal; Spot st, go;

boolean[][] grid = new boolean[unit][unit];
Spot[][] maze = new Spot[unit][unit];

ArrayList<Box> walls = new ArrayList<Box>();
ArrayList<Spot> openSet = new ArrayList<Spot>();
ArrayList<Spot> closedSet = new ArrayList<Spot>();
ArrayList<Spot> path; int pdx;

Ray ray;
Particle particle;

void setup() {
  size(720, 720);
  windowMove(590, 180);
  rectMode(CENTER);
  buildBarrier();
  particle = new Particle();
  
  start = floor(random(0, unit*unit-1)); goal = start;
  while(start == goal) goal = floor(random(0, unit*unit-1));
  grid[start/unit][start%unit] = true; grid[goal/unit][goal%unit] = true;
}

void draw() {
  
  if (SANDBOX) {
    if (INITIATE) {
      for (int i = 0; i < unit; i++)
        for (int j = 0; j < unit; j++) {
          maze[i][j] = new Spot(i, j);
          if(grid[i][j]) {
            walls.add(new Box(i, j));
            maze[i][j].wall = true;
          }
        }

      for (int i = 0; i < unit; i++)
        for (int j = 0; j < unit; j++)
          maze[i][j].addNeighbors(maze);
      
      st = maze[start/unit][start%unit];
      go = maze[goal/unit][goal%unit];
      st.wall = false; go.wall = false;
      openSet.add(st);
      SANDBOX = false;
    }
    draw_grid();
  }
  
  else {
    background(0);
    if (!PATH_FOUND){
      for (Box wall : walls)
        wall.show();
        
      pathfind();
    }
    else {
      if (pdx < path.size() && frameCount % 15 == 0){
        if (pdx > 0){
          int dx = path.get(pdx-1).i - path.get(pdx).i;
          int dy = path.get(pdx-1).j - path.get(pdx).j;
          int dr = 0;
          if (dy == 0) dr = 90 + 90*dx;
          if (dx == 0) dr = 135 + 135*dy;
          
          particle.setHead(dr);
        }
        particle.update(space*(path.get(pdx).i+0.5), space*(path.get(pdx++).j+0.5));
        particle.look(walls);
      } else if (pdx == path.size()) reset();
      
      float[] scene = particle.look(walls);
      float w = 720 / scene.length;
      for (int i = 0; i < scene.length; i++) {
        noStroke();
        float sq = scene[i] * scene[i];
        float wSq = 720 * 720;
        float b = map(sq, 0, wSq, 255, 0);
        float h = map(scene[i], 0, 720, 720, 0);
        fill(b);
        rectMode(CENTER);
        rect(i * w + w / 2, 720 / 2, w + 1, h);
      }
   }
  }
}
