/*
    Project 4. Generative Design System (Team Project)    
    https://editor.p5js.org/dus24k/sketches/FvxUUZwPk
*/

var capture;
var buffer;
var result;
var lines;
var w = 640, h = 480;

var imgRatio;

var colIdx;
var colList = [
  [255, 255, 255],
  [255, 0, 0],
  [0, 255, 0],
  [0, 0, 255],
  [255, 255, 0],
  [255, 0, 255],
  [0, 255, 255]
];

function preload()
{
  bgImg = loadImage('corridor.png');
  imgRatio = bgImg.height / bgImg.width;
}

function setup() {
  capture = createCapture(VIDEO);
  createCanvas(w, h);
  capture.size(w, h);
  capture.hide();
  buffer = new jsfeat.matrix_t(w, h, jsfeat.U8C1_t);
    stroke('red');
  strokeWeight(0.5);
  imageMode(CENTER);
}

function draw() {
  background(0);
  capture.loadPixels();
  if (capture.pixels.length > 0) {

    var y = select('#verSplit').elt.value;      
    var x = select('#horSplit').elt.value; 
    var o = select('#offset').elt.value;
    colIdx = select('#color').elt.value;

    y = map(y, 0, 100, 1, 0.4);
    x = map(x, 0, 100, 0.1, w/3);
    o = map(o, 0, 100, -w/3, w/3);
    colIdx = floor(map(colIdx, 0, 100, 0, 6));
    
    var b = map(x, 0, 100, 0, 105);
    
    image(bgImg, w/2+o, -h*2.6 * y**3, (w*27) * y**3, (w*27) * y**3 * imgRatio);
    background(0, 0, 0, b);

    var blurSize = map(x, 0, 100, 4, 7);
    var highThreshold = map(x, 0, 100, 60, 90);
    var lowThreshold = highThreshold;

    jsfeat.imgproc.grayscale(capture.pixels, w, h, buffer);
    jsfeat.imgproc.gaussian_blur(buffer, buffer, blurSize, 0);
    jsfeat.imgproc.canny(buffer, buffer, lowThreshold, highThreshold);
    var n = buffer.rows * buffer.cols;
    result = jsfeatToP5(buffer, result);

    image(result, w/2,      h/2);
    image(result, w/2 -x*1, h/2);
    image(result, w/2 -x*2, h/2);
    image(result, w/2 -x*3, h/2);
    image(result, w/2 +x*1, h/2);
    image(result, w/2 +x*2, h/2);
    image(result, w/2 +x*3, h/2);
    
    image(result, w/2 +o*(1-y)        , h/2 *(y**0.55), w*y, h*y);
    image(result, w/2 +o*(1-y) -x*1 *y, h/2 *(y**0.55), w*y, h*y);
    image(result, w/2 +o*(1-y) -x*2 *y, h/2 *(y**0.55), w*y, h*y);
    image(result, w/2 +o*(1-y) -x*3 *y, h/2 *(y**0.55), w*y, h*y);
    image(result, w/2 +o*(1-y) +x*1 *y, h/2 *(y**0.55), w*y, h*y);
    image(result, w/2 +o*(1-y) +x*2 *y, h/2 *(y**0.55), w*y, h*y);
    image(result, w/2 +o*(1-y) +x*3 *y, h/2 *(y**0.55), w*y, h*y);

    image(result, w/2 +o*(1-y*y)          , h/2 *(y**1.1), w*y*y, h*y*y);
    image(result, w/2 +o*(1-y*y) -x*1 *y*y, h/2 *(y**1.1), w*y*y, h*y*y);
    image(result, w/2 +o*(1-y*y) -x*2 *y*y, h/2 *(y**1.1), w*y*y, h*y*y);
    image(result, w/2 +o*(1-y*y) -x*3 *y*y, h/2 *(y**1.1), w*y*y, h*y*y);
    image(result, w/2 +o*(1-y*y) +x*1 *y*y, h/2 *(y**1.1), w*y*y, h*y*y);
    image(result, w/2 +o*(1-y*y) +x*2 *y*y, h/2 *(y**1.1), w*y*y, h*y*y);
    image(result, w/2 +o*(1-y*y) +x*3 *y*y, h/2 *(y**1.1), w*y*y, h*y*y);

    image(result, w/2 +o*(1-(y**3))             , h/2 *(y**1.6), w*(y**3), h*(y**3));
    image(result, w/2 +o*(1-(y**3)) -x*1 *(y**3), h/2 *(y**1.6), w*(y**3), h*(y**3));
    image(result, w/2 +o*(1-(y**3)) -x*2 *(y**3), h/2 *(y**1.6), w*(y**3), h*(y**3));
    image(result, w/2 +o*(1-(y**3)) -x*3 *(y**3), h/2 *(y**1.6), w*(y**3), h*(y**3));
    image(result, w/2 +o*(1-(y**3)) +x*1 *(y**3), h/2 *(y**1.6), w*(y**3), h*(y**3));
    image(result, w/2 +o*(1-(y**3)) +x*2 *(y**3), h/2 *(y**1.6), w*(y**3), h*(y**3));
    image(result, w/2 +o*(1-(y**3)) +x*3 *(y**3), h/2 *(y**1.6), w*(y**3), h*(y**3));

    image(result, w/2 +o*(1-(y**4))             , h/2 *(y**2), w*(y**4), h*(y**4));
    image(result, w/2 +o*(1-(y**4)) -x*1 *(y**4), h/2 *(y**2), w*(y**4), h*(y**4));
    image(result, w/2 +o*(1-(y**4)) -x*2 *(y**4), h/2 *(y**2), w*(y**4), h*(y**4));
    image(result, w/2 +o*(1-(y**4)) -x*3 *(y**4), h/2 *(y**2), w*(y**4), h*(y**4));
    image(result, w/2 +o*(1-(y**4)) +x*1 *(y**4), h/2 *(y**2), w*(y**4), h*(y**4));
    image(result, w/2 +o*(1-(y**4)) +x*2 *(y**4), h/2 *(y**2), w*(y**4), h*(y**4));
    image(result, w/2 +o*(1-(y**4)) +x*3 *(y**4), h/2 *(y**2), w*(y**4), h*(y**4));

    image(result, w/2 +o*(1-(y**5))             , h/2 *(y**2.2), w*(y**5), h*(y**5));
    image(result, w/2 +o*(1-(y**5)) -x*1 *(y**5), h/2 *(y**2.2), w*(y**5), h*(y**5));
    image(result, w/2 +o*(1-(y**5)) -x*2 *(y**5), h/2 *(y**2.2), w*(y**5), h*(y**5));
    image(result, w/2 +o*(1-(y**5)) -x*3 *(y**5), h/2 *(y**2.2), w*(y**5), h*(y**5));
    image(result, w/2 +o*(1-(y**5)) +x*1 *(y**5), h/2 *(y**2.2), w*(y**5), h*(y**5));
    image(result, w/2 +o*(1-(y**5)) +x*2 *(y**5), h/2 *(y**2.2), w*(y**5), h*(y**5));
    image(result, w/2 +o*(1-(y**5)) +x*3 *(y**5), h/2 *(y**2.2), w*(y**5), h*(y**5));
    }
}

function jsfeatToP5(src, dst) {
    if (!dst || dst.width != src.cols || dst.height != src.rows)
      dst = createImage(src.cols, src.rows);
  
    var n = src.data.length;
    dst.loadPixels();
    var srcData = src.data;
    var dstData = dst.pixels;
    for (var i = 0, j = 0; i < n; i++) {
      var cur = srcData[i];
      dstData[j++] = colList[colIdx][0];
      dstData[j++] = colList[colIdx][1];
      dstData[j++] = colList[colIdx][2];
      dstData[j++] = cur;
    }
    dst.updatePixels();
    return dst;
}
