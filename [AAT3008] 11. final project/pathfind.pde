class Spot {
  int i, j;
  float f, g, h;
  boolean wall;
  ArrayList<Spot> neighbors;
  Spot prev;

  Spot(int i, int j) {
    this.i = i; this.j = j;
    this.f = 0; this.g = 0;
    this.wall = false;
    this.h = 0; this.prev = null;
    this.neighbors = new ArrayList<Spot>();
  }

  void addNeighbors(Spot[][] grid) {
    if (i < unit - 1) {
      neighbors.add(grid[i + 1][j]);
    }
    if (i > 0) {
      neighbors.add(grid[i - 1][j]);
    }
    if (j < unit - 1) {
      neighbors.add(grid[i][j + 1]);
    }
    if (j > 0) {
      neighbors.add(grid[i][j - 1]);
    }
  }
}

void pathfind(){
  if (openSet.size() > 0) {
      int winner = 0;
      for (int i = 0; i < openSet.size(); i++) {
        if (openSet.get(i).f < openSet.get(winner).f) {
          winner = i;
        }
      }
      Spot current = openSet.get(winner);
      if (current == go) {
        path = new ArrayList<Spot>();
        Spot temp = current;
        path.add(temp);
        while(temp.prev != null) {
          path.add(temp.prev);
          temp = temp.prev;
        }
        PATH_FOUND = true;
      }
      
      openSet.remove(current);
      closedSet.add(current);
    
      ArrayList<Spot> neighbors = current.neighbors;
      for (int i = 0; i < neighbors.size(); i++) {
        Spot neighbor = neighbors.get(i);
    
        if (!closedSet.contains(neighbor) && !neighbor.wall) {
          float tempG = current.g + dist(neighbor.i, neighbor.j, current.i, current.j);
    
          boolean newPath = false;
          if (openSet.contains(neighbor)) {
            if (tempG < neighbor.g) {
              neighbor.g = tempG;
              newPath = true;
            }
          } else {
            neighbor.g = tempG;
            newPath = true;
            openSet.add(neighbor);
          }
    
          if (newPath) {
            neighbor.h = dist(neighbor.i, neighbor.j, go.i, go.j);
            neighbor.f = neighbor.g + neighbor.h;
            neighbor.prev = current;
          }
        }
      }
      
      if (current.prev != null){
        int dx = current.prev.i - current.i;
        int dy = current.prev.j - current.j;
        int dr = 0;
        if (dy == 0) dr = 90 + 90*dx;
        else if (dx == 0) dr = 135 + 135*dy;
        
        particle.setHead(dr);
      }
      particle.update(space*(current.i+0.5), space*(current.j+0.5));
      particle.show();
      particle.look(walls);
      
    } else { println("No Solution"); reset(); }
}
