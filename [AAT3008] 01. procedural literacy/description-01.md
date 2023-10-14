# Metro Map Generator

### Project 1: Procedural Literacy

<img src="https://github.com/dustto24k/weekly-p5js-23FW/assets/105871083/37d8820d-b123-4472-9a22-31b9056ed71d" width="50%" height="50%">

\> Here is a direct [link](https://editor.p5js.org/dus24k/sketches/v6nHrgN3I) to p5js sketch

#### Create one your own Process & implement it. - What is a good Process?

>(1) Can it lead to new findings?
>
>(2) Is it clear enough to be implemented by others?
>
>(3) Does it provide enough room for open results?

## Process

Decide the range of the number of metro lines and stations per line you want the map to draw. Each line's color and the departure station's position are set randomly every time the code is executed. The line decides its direction to expand according to the following rules.

<div align ="center">

![rules](https://github.com/dustto24k/weekly-p5js-23FW/assets/105871083/bf60fe91-b0a7-435e-8af8-5c09ede03b38)

</div>

1. Line cannot generate its next station in a position where the transfer station limit is already reached.

2. Lines cannot share two stations that are adjacent.

3. Angle formed by a single line must be at least 90°.

As long as it doesn't break the rules, the next station's position is randomly chosen within the possible options. Generation process terminates if the line reaches its designated number of stations, or it doesn't have any valid positions remaining.

## Brief Explanation

- In setup() function, canvas is mapped into a 2D grid with spacing of given value. (default = 20)
- Each point of the grid are potential position of stations.
- (for a single Line) A random point is chosen as the departure station, and by every loop, the next point to move to is designated within eight adjacent points, following the rule.

## Customizable Variables
- width, height // code works fine no matter the canvas size
- spacing // gap between columns and rows of grid, and it also decides the scale of generated shapes
- numOfLine // number of metro lines to generate
- (max/min)Station // range of num of stations per line, it can be given fixed num instead of random
- transferLimit // max num of transfer stations which can be located in a single point (related to Rule 1)
- etc // color of lines can also be fixed or be used from custom selections using list, border can be changed…

## Custom Examples

<div align ="center">

![examples](https://github.com/dustto24k/weekly-p5js-23FW/assets/105871083/3217da81-40cd-4357-bf47-597b660d0398)

</div>
<br></br>