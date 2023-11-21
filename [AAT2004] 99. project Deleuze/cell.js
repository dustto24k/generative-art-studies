class Cell {
  constructor(pos, vel) {
    this.position = pos;
    this.velocity = vel;
    this.velocity.setMag(random(2, 4));
    this.acceleration = createVector();
    this.maxSpeed = 3;

    this.c = color(int(random(255)), int(random(255)), int(random(255)));

    this.v = [];
  }

  edges() {
    if (this.position.x > width) {
      this.position.x = 0;
    } else if (this.position.x < 0) {
      this.position.x = width;
    }
    if (this.position.y > height) {
      this.position.y = 0;
    } else if (this.position.y < 0) {
      this.position.y = height;
    }
  }

  update() {
    // tmp
    this.acceleration.add(random(-2, 2), random(-2, 2));

    this.velocity.limit(this.maxSpeed);
  }

  show() {
    stroke(this.c);
    for (let i = 0; i < this.v.length; i++) {
      point(this.v[i]);
    }
  }
}
