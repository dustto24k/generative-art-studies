class Particle {
  constructor() {
    this.position = createVector(random(width), random(height));
    this.velocity = p5.Vector.random2D();
    this.velocity.setMag(random(2, 4));
    this.acceleration = createVector();
    this.maxSpeed = 3;

    this.ISCELL = false;
    this.CELLNUM = -1;
    this.CELLPOS = createVector(0, 0);
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

  merge() {
    if (this.ISCELL) return;

    let r = 30;
    let cnt = 0;
    for (let other of univ) {
      if (other.ISCELL || other == this) continue;
      let d = dist(
        this.position.x,
        this.position.y,
        other.position.x,
        other.position.y
      );
      if (d < r) cnt++;
    }

    if (cnt > 5) {
      for (let other of univ) {
        if (other.ISCELL || other == this) continue;
        let d = dist(
          this.position.x,
          this.position.y,
          other.position.x,
          other.position.y
        );

        if (d < r) {
          let c = new Cell(this.position, this.velocity);
          cells.push(c);

          other.CELLNUM = cells.length - 1;
          other.CELLPOS = this.position - other.position;
          other.ISCELL = true;

          cells[other.CELLNUM].v.push(other.position);
        }
      }

      this.CELLNUM = cells.length - 1;
      this.CELLPOS = 0;
      this.ISCELL = true;

      cells[this.CELLNUM].v.push(this.position);
    }
  }

  update() {
    if (!this.ISCELL) {
      // tmp
      this.acceleration.add(random(-2, 2), random(-2, 2));

      this.position.add(this.velocity);
      this.velocity.add(this.acceleration);
      this.velocity.limit(this.maxSpeed);
    } else {
      this.position.add(cells[this.CELLNUM].velocity);
      this.velocity.add(cells[this.CELLNUM].acceleration);
      this.velocity.limit(this.maxSpeed);
    }
  }

  show() {
    strokeWeight(6);

    if (!this.ISCELL) {
      stroke(255);
      point(this.position.x, this.position.y);
    }
    // else {
    //   stroke(cells[this.CELLNUM].c);
    // }
  }
}
