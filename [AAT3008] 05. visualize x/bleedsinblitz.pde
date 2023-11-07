int renderspeed = 2; // super-fast = 2, normal = 20-30
boolean reset = false;

float rotY = PI/3.0;
color red = color(255, 0, 0);
color blue = color(0, 0, 255);

int[][][] pieces = new int[12][8][2];
Arrow[] arrows = new Arrow[400];
int arrN, cnt = 0; int tileSize = 50;
                                               /*
  W/B (0/1 * 6)  +  K/Q/B/N/R/P (0/1/2/3/4/5)  */

int[][] startingPos = {
  {4, 0}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8},
  {3, 0}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8},
  {2, 0}, {5, 0}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8},
  {1, 0}, {6, 0}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8},
  {0, 0}, {7, 0}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8},
  {7, 1}, {6, 1}, {5, 1}, {4, 1}, {3, 1}, {2, 1}, {1, 1}, {0, 1},
  {4, 7}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8},
  {3, 7}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8},
  {2, 7}, {5, 7}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8},
  {1, 7}, {6, 7}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8},
  {0, 7}, {7, 7}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8}, {-8, -8},
  {7, 6}, {6, 6}, {5, 6}, {4, 6}, {3, 6}, {2, 6}, {1, 6}, {0, 6}
};

void setup() {
  size(1080, 720, P3D);
  windowMove(410, 180);
  
  int r = floor(random(20057.9)); println("Game No. " + r);
  String filename = "src/game_" + r + ".txt";
  String[] moves = split(loadStrings(filename)[0], ' ');
  
  int p = 0;
  for (int i = 0; i < 12; i++){
    for (int j = 0; j < 8; j++){
      for (int k = 0; k < 2; k++){
        pieces[i][j][k] = startingPos[p][k];
      }
      p++;
    }
  }
  arrN = moves.length;
  for (int i = 0; i < arrN; i++){
    make_arrows(moves[i], i);
  }
}


void draw() {
  
  if (reset) {
    
    int r = floor(random(20057.9)); println("\n=========\nGame No. " + r);
    String filename = "src/game_" + r + ".txt";
    String[] moves = split(loadStrings(filename)[0], ' ');
    
    int p = 0;
    for (int i = 0; i < 12; i++){
      for (int j = 0; j < 8; j++){
        for (int k = 0; k < 2; k++){
          pieces[i][j][k] = startingPos[p][k];
        }
        p++;
      }
    }
    arrN = moves.length; cnt = 0;
    for (int i = 0; i < arrN; i++){
      make_arrows(moves[i], i);
    }
    
    reset = false;
  }
  
  background(0, 40, 0);
  
  pushMatrix();
    rotY += PI/1500.0;
    float camZ = (float(width)/2.0) / tan(0.5);
    perspective(0.7, float(width)/float(height),
                camZ/3.0, camZ*3.0);
    translate(width/2, height/2, 0);
    rotateX(-PI/7.5);
    rotateY(rotY);
    
    strokeWeight(3);
    stroke(0);
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        pushMatrix();
          translate((i-3.5)*tileSize, 0, (j-3.5)*tileSize);
          fill((i+j+1)%2 * 255);
          box(tileSize, 10, tileSize);
        popMatrix();
      }
    }
    for (int i = 0; i < cnt; i++){
      arrows[i].show();
    }
  popMatrix();
  
  if (cnt < arrN && frameCount % renderspeed == 0) cnt++;
}


void keyPressed() {
  if (key == ' ') reset = true;
}


void make_arrows(String str, int idx) {
  int srcx=0, srcy=0, dstx=0, dsty=0;
  int role, col, row, pos;
  int turn = idx % 2; // W = 0, B = 1
  println(turn, str);
  switch(str.length()){
    case 2:
      col = str.charAt(0) - 'a' + 0;
      row = str.charAt(1) - '0' - 1;
      pos = findValidPawn(turn, row, col);
      
      if (pos == -1) break;
      srcx = pieces[turn*6+5][pos][0];
      srcy = pieces[turn*6+5][pos][1];
      dstx = col; dsty = row;
      
      pieces[turn*6+5][pos][0] = col;
      pieces[turn*6+5][pos][1] = row;
      break;
      
    case 3:
      if (str.charAt(0) == 'O'){
        srcx = 4; srcy = turn*7;
        dstx = 6; dsty = turn*7;
        
        pieces[turn*6][0][0] = 6;
        pieces[turn*6][0][1] = turn*7;
        pieces[turn*6+4][1][0] = 5;
        pieces[turn*6+4][1][1] = turn*7;
      }
      else if (str.charAt(2) == '+' || str.charAt(2) == '#'){
        role = 5;
        col = str.charAt(0) - 'a' + 0;
        row = str.charAt(1) - '0';
        pos = findValidPawn(turn, row, col);
        
        if (pos == -1) break;
        srcx = pieces[turn*6+5][pos][0];
        srcy = pieces[turn*6+5][pos][1];
        dstx = col; dsty = row;
        
        pieces[turn*6+5][pos][0] = col;
        pieces[turn*6+5][pos][1] = row;
      }
      else {
        role = check_role(str.charAt(0));
        col = str.charAt(1) - 'a' + 0;
        row = str.charAt(2) - '0' - 1;
        
        if (role == 1) pos = findValidQueen(turn, row, col);
        else if (role == 2) pos = findValidBishop(turn, row, col);
        else if (role == 3) pos = findValidKnight(turn, row, col);
        else if (role == 4) pos = findValidRook(turn, row, col);
        else if (role == 5) pos = findValidPawn(turn, row, col);
        else pos = 0;
        
        if (pos == -1) break;
        srcx = pieces[turn*6+role][pos][0];
        srcy = pieces[turn*6+role][pos][1];
        dstx = col; dsty = row;
        
        pieces[turn*6+role][pos][0] = col;
        pieces[turn*6+role][pos][1] = row;
      }
      break;
      
    case 4:
      if (str.charAt(3) == '+' || str.charAt(3) == '#'){
        role = check_role(str.charAt(0));
        col = str.charAt(1) - 'a' + 0;
        row = str.charAt(2) - '0' - 1;
      }
      else if (str.charAt(2) == '='){
        role = 5;
        col = str.charAt(0) - 'a' + 0;
        row = str.charAt(1) - '0' - 1;
        break;
      }
      else if (str.charAt(1) == 'x'){
        // let exception by not killing (fix later)
        role = check_role(str.charAt(0));
        col = str.charAt(2) - 'a' + 0;
        row = str.charAt(3) - '0' - 1;
            
        if (role == 5){
          pos = findValidPawnByCol(turn, row, col);
          
          if (pos == -1) break;
          srcx = pieces[turn*6+5][pos][0];
          srcy = pieces[turn*6+5][pos][1];
          dstx = col; dsty = row;
          
          pieces[turn*6+5][pos][0] = col;
          pieces[turn*6+5][pos][1] = row;
          break;
        }
      }
      else {
        role = check_role(str.charAt(0));
        col = str.charAt(1);
        if (role == 4){
          if (col >= '0' && col <= '9'){
            col = col - '0' - 1;
            pos = findValidRookByRow(turn, col);
          }
          else {
            col = col - 'a' + 0;
            pos = findValidRookByCol(turn, col);
          }
        }
        else if (role == 3) {
          col = col - 'a' + 0;
          pos = findValidKnightByCol(turn, col);
        }
        else {
          if (col >= '0' && col <= '9'){
            col = col - '0' - 1;
            pos = findValidRookByRow(turn, col);
          }
          else {
            col = col - 'a' + 0;
            pos = findValidQueenByCol(turn, col);
          }
        }
        
        col = str.charAt(2) - 'a' + 0;
        row = str.charAt(3) - '0' - 1;
        
        if (pos == -1) break;
        srcx = pieces[turn*6+role][pos][0];
        srcy = pieces[turn*6+role][pos][1];
        dstx = col; dsty = row;
        
        pieces[turn*6+role][pos][0] = col;
        pieces[turn*6+role][pos][1] = row;
        break;
      }
      
      if (role == 1) pos = findValidQueen(turn, row, col);
      else if (role == 2) pos = findValidBishop(turn, row, col);
      else if (role == 3) pos = findValidKnight(turn, row, col);
      else if (role == 4) pos = findValidRook(turn, row, col);
      else if (role == 5) pos = findValidPawn(turn, row, col);
      else pos = 0;
        
      if (pos == -1) break;
      srcx = pieces[turn*6+role][pos][0];
      srcy = pieces[turn*6+role][pos][1];
      dstx = col; dsty = row;
      
      pieces[turn*6+role][pos][0] = col;
      pieces[turn*6+role][pos][1] = row;
      break;
      
    case 5:
      if (str.charAt(0) == 'O'){
        srcx = 4; srcy = turn*7;
        dstx = 1; dsty = turn*7;
        
        pieces[turn*6][0][0] = 1;
        pieces[turn*6][0][1] = turn*7;
        pieces[turn*6+4][0][0] = 2;
        pieces[turn*6+4][0][1] = turn*7;
        break;
      }
      else if (str.charAt(4) == '+' || str.charAt(4) == '#'){
          if (str.charAt(2) == '='){
            role = 5;
            col = str.charAt(0) - 'a' + 0;
            row = str.charAt(1) - '0' - 1;
          }
          else if (str.charAt(1) == 'x'){
            // let exception by not killing (fix later)
            role = check_role(str.charAt(0));
            col = str.charAt(2) - 'a' + 0;
            row = str.charAt(3) - '0' - 1;
            
            if (role == 5){
              pos = findValidPawnByCol(turn, row, col);
              
              if (pos == -1) break;
              srcx = pieces[turn*6+5][pos][0];
              srcy = pieces[turn*6+5][pos][1];
              dstx = col; dsty = row;
              
              pieces[turn*6+5][pos][0] = col;
              pieces[turn*6+5][pos][1] = row;
              break;
            }
          }
          else {
            role = check_role(str.charAt(0));
            col = str.charAt(1);
            if (role == 4){
              if (col >= '0' && col <= '9'){
                col = col - '0' - 1;
                pos = findValidRookByRow(turn, col);
              }
              else {
                col = col - 'a' + 0;
                pos = findValidRookByCol(turn, col);
              }
            }
            else if (role == 3) {
              col = col - 'a' + 0;
              pos = findValidKnightByCol(turn, col);
            }
            else {
              if (col >= '0' && col <= '9'){
                col = col - '0' - 1;
                pos = findValidRookByRow(turn, col);
              }
              else {
                col = col - 'a' + 0;
                pos = findValidQueenByCol(turn, col);
              }
            }
            
            col = str.charAt(2) - 'a' + 0;
            row = str.charAt(3) - '0' - 1;
          
            if (pos == -1) break;
            srcx = pieces[turn*6+role][pos][0];
            srcy = pieces[turn*6+role][pos][1];
            dstx = col; dsty = row;
            
            pieces[turn*6+role][pos][0] = col;
            pieces[turn*6+role][pos][1] = row;
            break;
          }
      }
      else { // Rexe1
        role = check_role(str.charAt(0));
        col = str.charAt(1);
        if (role == 4){
          if (col >= '0' && col <= '9'){
            col = col - '0' - 1;
            pos = findValidRookByRow(turn, col);
          }
          else {
            col = col - 'a' + 0;
            pos = findValidRookByCol(turn, col);
          }
        }
        else if (role == 3) {
          col = col - 'a' + 0;
          pos = findValidKnightByCol(turn, col);
        }
        else {
          if (col >= '0' && col <= '9'){
            col = col - '0' - 1;
            pos = findValidRookByRow(turn, col);
          }
          else {
            col = col - 'a' + 0;
            pos = findValidQueenByCol(turn, col);
          }
        }
        
        col = str.charAt(3) - 'a' + 0;
        row = str.charAt(4) - '0' - 1;
      
        if (pos == -1) break;
        srcx = pieces[turn*6+role][pos][0];
        srcy = pieces[turn*6+role][pos][1];
        dstx = col; dsty = row;
        
        pieces[turn*6+role][pos][0] = col;
        pieces[turn*6+role][pos][1] = row;
        break;
      }
      
      if (role == 1) pos = findValidQueen(turn, row, col);
      else if (role == 2) pos = findValidBishop(turn, row, col);
      else if (role == 3) pos = findValidKnight(turn, row, col);
      else if (role == 4) pos = findValidRook(turn, row, col);
      else if (role == 5) pos = findValidPawn(turn, row, col);
      else pos = 0;
      
      if (pos == -1) break;
      srcx = pieces[turn*6+role][pos][0];
      srcy = pieces[turn*6+role][pos][1];
      dstx = col; dsty = row;
      
      pieces[turn*6+role][pos][0] = col;
      pieces[turn*6+role][pos][1] = row;
      break;
    
    case 6:
      if (str.charAt(5) == '+' || str.charAt(5) == '#'){
        role = check_role(str.charAt(0));
        col = str.charAt(1);
        if (role == 4){
          if (col >= '0' && col <= '9'){
            col = col - '0' - 1;
            pos = findValidRookByRow(turn, col);
          }
          else {
            col = col - 'a' + 0;
            pos = findValidRookByCol(turn, col);
          }
        }
        else if (role == 3) {
          col = col - 'a' + 0;
          pos = findValidKnightByCol(turn, col);
        }
        else {
          if (col >= '0' && col <= '9'){
            col = col - '0' - 1;
            pos = findValidRookByRow(turn, col);
          }
          else {
            col = col - 'a' + 0;
            pos = findValidQueenByCol(turn, col);
          }
        }
        
        col = str.charAt(3) - 'a' + 0;
        row = str.charAt(4) - '0' - 1;
      
        if (pos == -1) break;
        srcx = pieces[turn*6+role][pos][0];
        srcy = pieces[turn*6+role][pos][1];
        dstx = col; dsty = row;
        
        pieces[turn*6+role][pos][0] = col;
        pieces[turn*6+role][pos][1] = row;
        break;
      }
      else {
        role = 5;
        col = str.charAt(2) - 'a' + 0;
        row = str.charAt(3) - '0' - 1;
        pos = findValidPawnByCol(turn, row, col);
      
        if (pos == -1) break;
        srcx = pieces[turn*6+5][pos][0];
        srcy = pieces[turn*6+5][pos][1];
        dstx = col; dsty = row;
        
        pieces[turn*6+5][pos][0] = col;
        pieces[turn*6+5][pos][1] = row;
        break;
      }
      
    default:
      role = 5;
      col = str.charAt(2) - 'a' + 0;
      row = str.charAt(3) - '0' - 1;
      pos = findValidPawnByCol(turn, row, col);
      
      if (pos == -1) break;
      srcx = pieces[turn*6+5][pos][0];
      srcy = pieces[turn*6+5][pos][1];
      dstx = col; dsty = row;
      
      pieces[turn*6+5][pos][0] = col;
      pieces[turn*6+5][pos][1] = row;
      break;
  }
  Arrow a = new Arrow(srcx, srcy, dstx, dsty, turn);
  arrows[idx] = a;  
}

int check_role(char c) {
  switch(c){
    case 'K':
      return 0;
    case 'Q':
      return 1;
    case 'B':
      return 2;
    case 'N':
      return 3;
    case 'R':
      return 4;
    default:
      return 5;
  }
}

int findValidQueenByCol(int t, int c) {
  for (int a = 0; a < 2; a++){
    if (pieces[t*6+1][a][0] == c) return a;
  }
  return -1;
}

int findValidQueenByRow(int t, int r) {
  for (int a = 0; a < 2; a++){
    if (pieces[t*6+1][a][1] == r) return a;
  }
  return -1;
}

int findValidQueen(int t, int r, int c) {
  for (int a = 0; a < 3; a++){
    if (pieces[t*6+1][a][1] == r) return a;
    if (pieces[t*6+1][a][0] == c) return a;
    
    for (int b = 1; b < 8; b++){
      if (r - b < 0 || c - b < 0) break;
      if (pieces[t*6+1][a][1] == r-b && pieces[t*6+1][a][0] == c-b) return a;
    }
    
    for (int b = 1; b < 8; b++){
      if (r - b < 0 || c + b > 7) break;
      if (pieces[t*6+1][a][1] == r-b && pieces[t*6+1][a][0] == c+b) return a;
    }
    
    for (int b = 1; b < 8; b++){
      if (r + b > 7 || c + b > 7) break;
      if (pieces[t*6+1][a][1] == r+b && pieces[t*6+1][a][0] == c+b) return a;
    }
    
    for (int b = 1; b < 8; b++){
      if (r + b > 7 || c - b < 0) break;
      if (pieces[t*6+1][a][1] == r+b && pieces[t*6+1][a][0] == c-b) return a;
    }
  }
  return -1;
}

int findValidBishop(int t, int r, int c) {
  for (int a = 0; a < 2; a++){    
    for (int b = 1; b < 8; b++){
      if (r - b < 0 || c - b < 0) break;
      if (pieces[t*6+2][a][1] == r-b && pieces[t*6+2][a][0] == c-b) return a;
    }
    
    for (int b = 1; b < 8; b++){
      if (r - b < 0 || c + b > 7) break;
      if (pieces[t*6+2][a][1] == r-b && pieces[t*6+2][a][0] == c+b) return a;
    }
    
    for (int b = 1; b < 8; b++){
      if (r + b > 7 || c + b > 7) break;
      if (pieces[t*6+2][a][1] == r+b && pieces[t*6+2][a][0] == c+b) return a;
    }
    
    for (int b = 1; b < 8; b++){
      if (r + b > 7 || c - b < 0) break;
      if (pieces[t*6+2][a][1] == r+b && pieces[t*6+2][a][0] == c-b) return a;
    }
  }
  return -1;
}

int findValidKnightByCol(int t, int c) {
  for (int a = 0; a < 3; a++){
    if (pieces[t*6+3][a][0] == c) return a;
  }
  return -1;
}

int findValidKnight(int t, int r, int c) {
  for (int a = 0; a < 3; a++){
    if (pieces[t*6+3][a][1] == r+1 && pieces[t*6+3][a][0] == c-2) return a;
    if (pieces[t*6+3][a][1] == r-1 && pieces[t*6+3][a][0] == c-2) return a;
    if (pieces[t*6+3][a][1] == r+1 && pieces[t*6+3][a][0] == c+2) return a;
    if (pieces[t*6+3][a][1] == r-1 && pieces[t*6+3][a][0] == c+2) return a;
    if (pieces[t*6+3][a][1] == r+2 && pieces[t*6+3][a][0] == c-1) return a;
    if (pieces[t*6+3][a][1] == r-2 && pieces[t*6+3][a][0] == c-1) return a;
    if (pieces[t*6+3][a][1] == r+2 && pieces[t*6+3][a][0] == c+1) return a;
    if (pieces[t*6+3][a][1] == r-2 && pieces[t*6+3][a][0] == c+1) return a;
  }
  return -1;
}

int findValidRookByCol(int t, int c) {
  for (int a = 0; a < 2; a++){
    if (pieces[t*6+4][a][0] == c) return a;
  }
  return -1;
}

int findValidRookByRow(int t, int r) {
  for (int a = 0; a < 2; a++){
    if (pieces[t*6+4][a][1] == r) return a;
  }
  return -1;
}

int findValidRook(int t, int r, int c) {
  for (int a = 0; a < 2; a++){
    if (pieces[t*6+4][a][1] == r) return a;
    if (pieces[t*6+4][a][0] == c) return a;
  }
  return -1;
}

int findValidPawnByCol(int t, int r, int c) {
  int dir = floor((t-0.5)*2);
  
  for (int a = 0; a < 8; a++){
    if (pieces[t*6+5][a][1] == r+1*dir && pieces[t*6+5][a][0] == c+1) return a;
    if (pieces[t*6+5][a][1] == r+1*dir && pieces[t*6+5][a][0] == c-1) return a;
  }
  return -1;
}

int findValidPawn(int t, int r, int c) {
  int dir = floor((t-0.5)*2);
  
  for (int a = 0; a < 8; a++){
    if (pieces[t*6+5][a][1] == r+1*dir && pieces[t*6+5][a][0] == c) return a;
  }
  
  for (int a = 0; a < 8; a++){
    if (pieces[t*6+5][a][1] == r+2*dir && pieces[t*6+5][a][0] == c) return a;
  }
  return -1;
}

public class Arrow {
  private float sx;
  private float sy;
  private float dx;
  private float dy;
  private float hx;
  private float hy;
  private color co;
  
  public Arrow(int srcx, int srcy, int dstx, int dsty, int turn) {
    this.sx = (srcx - 3.5) * tileSize; this.sy = (srcy - 3.5) * tileSize;
    this.dx = (dstx - 3.5) * tileSize; this.dy = (dsty - 3.5) * tileSize;
    this.hx = (this.sx + this.dx) / 2.0;
    this.hy = (this.sy + this.dy) / 2.0;
    
    if (turn == 0) this.co = blue;
    else this.co = red;
  }
  
  void show(){
    pushMatrix();
      noFill();
      strokeWeight(4);
      stroke(this.co);
      beginShape();
        vertex(this.sx, 0, this.sy);
        bezierVertex(this.sx, 0, this.sy, this.hx, -100, this.hy, this.dx, 0, this.dy);
      endShape();
    popMatrix();
  }
}
