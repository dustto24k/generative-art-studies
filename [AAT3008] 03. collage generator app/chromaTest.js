let imgList = [];

function preload() {
  let numOfImg = 5;
  for (let i = 0; i < numOfImg; i++) {
    path = "assets/" + str(i) + ".jpg";
    let tmp = loadImage(path);
    imgList.push(tmp);
  }
}

function setup() {
  for (let i = 0; i < imgList.size; i++) imgList[i].resize(width, height);

  frameRate(1);
  createCanvas(800, 800);
}

function draw() {
  background(0);
  imgList = shuffle(imgList);

  for (let i = 0; i < 5; i++) {
    let keyed = Key(
      imgList[i],
      [int(random(255)), int(random(255)), int(random(255))],
      113
    );
    image(keyed, 0, 0);
  }
}

function Key(image, color, level = 50) {
  image.loadPixels();
  let out = new p5.Image(image.width, image.height);
  out.loadPixels();
  let keyVec = createVector(...color);
  for (y = 0; y < image.height; y++) {
    for (x = 0; x < image.width; x++) {
      let col = image.get(x, y);
      let colVec = createVector(...col);
      let d = colVec.dist(keyVec);
      let newCol = [...col];
      if (d < level) {
        newCol[3] = 0;
      }
      out.set(x, y, newCol);
    }
  }
  out.updatePixels();
  return out;
}
