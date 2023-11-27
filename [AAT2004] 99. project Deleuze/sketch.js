const univ = [];

function setup() {
  createCanvas(720, 720);

  for (let i = 0; i < 200; i++) {
    univ.push(new Particle());
  }
}

function draw() {
  background(0);

  for (let p of univ) {
    p.edges();
    p.merge(univ);
    p.update();
    p.show();
  }
}

function mousePressed() {
  noLoop();
}

function mouseReleased() {
  loop();
}
