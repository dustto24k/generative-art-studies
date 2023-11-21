const univ = [];
const cells = [];

function setup() {
  createCanvas(720, 720);

  // tmp
  for (let i = 0; i < 200; i++) {
    univ.push(new Particle());
  }
}

function draw() {
  background(0);

  // tmp
  for (let p of univ) {
    p.edges();
    p.merge(univ);
    p.update();
    p.show();
  }

  // tmp
  for (let c of cells) {
    c.update();
    c.show();
  }
}
