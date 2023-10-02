// https://editor.p5js.org/dus24k/sketches/v6nHrgN3I

/* Project #1 <Metro Map Generator>
   by Euihyeon Han (A&T 20191170)
  
Decide the range of the number of metro lines and stations per line you want the map to draw. Each line's color and the departure station's position are set randomly every time the code is executed. The line decides its direction to expand according to the following rules.
  No.1 | Line cannot generate its next station in a position
         where the transfer station limit is already reached.
  No.2 | Lines cannot share two stations that are adjacent.
  No.3 | Angle formed by a single line must be at least 90°.
As long as it doesn't break the rules, the next station's position is randomly chosen within the possible options.
Generation process terminates if the line reaches its designated number of stations, or it doesn't have any valid positions remaining. */

let allOptions = [{ dx:  1,  dy:  0 }, { dx: -1,  dy:  0 },
    { dx:  0,  dy:  1 }, { dx:  0,  dy: -1 },
    { dx:  1,  dy:  1 }, { dx: -1,  dy: -1 },
    { dx:  1,  dy: -1 }, { dx: -1,  dy:  1 }];
let Mlist = []; let DList = [];
let cols, rows, grid;


// Customizable Variables
let canvasWidth  = 600;
let canvasHeight = 300;
let spacing = 20;        // determines thickness of lines as well
let numOfLine  = 15;     // decide the number of lines
let maxStation = 30;     // decide max num of stations per line
let minStation = 15;     // should be value greater than 1

/* Try Example
spacing   = 40;  canvas[Width/Height] = 600, 600;
numOfLine = 12;  [max/min]Station     = 20, 12; */


function make2DArray(cols, rows)
{
let arr = new Array(cols);
for (var i = 0; i < arr.length; i++)
{ arr[i] = new Array(rows); }
return arr;
}

function setup()
{
frameRate(20);
createCanvas(canvasWidth, canvasHeight);
cols = floor(width / spacing);
rows = floor(height / spacing);
background(0);
grid = make2DArray(cols, rows);
for (let i = 0; i < cols; i++)
{ for (let j = 0; j < rows; j++)
{ grid[i][j] = 0; } }

// generating metro lines by given number
for (let i = 0; i < numOfLine; i++)
{
let depart_x = int(random(1, cols - 1));
let depart_y = int(random(1, rows - 1));
let numOfStation = int(random(minStation, maxStation));
let R = int(random(75, 255));
let G = int(random(75, 255));
let B = int(random(75, 255));

let M = new MetLine(depart_x, depart_y,
            R, G, B, numOfStation);
Mlist.push(M);
grid[depart_x][depart_y] += 1;
}
}

// set the maximum number of transfer stations which can be
// located in a single station
let transferLimit = 3;

function isValid(i, j)
{
if ( i < 1 || i >= cols || j < 1 || j >= rows )
{ return false; }
if (grid[i][j] <= transferLimit)
return true;
else
return false;
}

function draw() {
for (let i = 0; i < Mlist.length; i++)
{ Mlist[i].show(); }
for (let j = 0; j < DList.length; j++)
{ DList[j].show(); }
if (frameCount == 300) { noLoop(); }
}


class MetLine
{
constructor(X, Y, R, G, B, N)
{
this.x = X; this.y = Y;
this.R = R; this.G = G; this.B = B;
this.station = N;
this.options = [];
this.last_op = { dx: 100, dy: 100 };
this.last_dt = 0;
this.dead = false;
}

show()
{   

if (!this.dead)
{
push();

stroke(this.R, this.G, this.B);
strokeWeight(spacing * 0.3);
point(this.x * spacing, this.y * spacing);

this.options = [];
for (let option of allOptions)
{      
let newX = this.x + option.dx;
let newY = this.y + option.dy;
if ( isValid(newX, newY) &&
    (this.last_dt < 2 || grid[newX][newY] < 1) &&
    (this.last_op.dx + option.dx != 0 || option.dx == 0) &&
    (this.last_op.dy + option.dy != 0 || option.dy == 0) )
{ this.options.push(option); }
}

if (this.station <= 0)
{ this.dead = true; }
else if (this.options.length > 0)
{
let step = random(this.options);
strokeWeight(spacing * 0.1);
beginShape();
vertex(this.x * spacing, this.y * spacing);
this.x += step.dx;
this.y += step.dy;
vertex(this.x * spacing, this.y * spacing);
endShape();

this.last_op = step;
this.last_dt = ++grid[this.x][this.y];
this.station--;
}
pop();
}
let d = new Dot(this.x, this.y);
DList.push(d);
}
}

class Dot
{
constructor(x, y)
{
this.x = x;
this.y = y;
}

show()
{
push();
stroke(255);
strokeWeight(spacing * 0.17);
point(this.x * spacing, this.y * spacing);
pop();
}
}