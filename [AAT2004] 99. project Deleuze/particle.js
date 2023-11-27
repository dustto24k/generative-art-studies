class Particle {
  constructor() {
    this.idx = univ.length;
    this.position = createVector(random(width), random(height));
    this.velocity = p5.Vector.random2D();
    this.velocity.setMag(random(2, 4));
    this.acceleration = createVector();
    this.maxSpeed = 3;

    this.ISCELL = false;
    this.ISCENTER = false;
    this.CELLBORN = 36000;
    this.CELLNUM = -1;
    this.CELLPOS = createVector();

    this.c = color(random(100, 255), random(100, 255), random(100, 255));
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
    if (!this.ISCELL) {
      let cparts = [];
      let r = 30;
      let cnt = 0;
      for (let other of univ) {
        if (other != this && !other.ISCELL) {
          let d = dist(
            this.position.x,
            this.position.y,
            other.position.x,
            other.position.y
          );
          if (d < r) {
            cnt++;
            cparts.push(other.idx);
          }
          if (cnt > 4) break;
        }
      }

      if (cnt > 4) {
        for (let i of cparts) {
          univ[i].ISCELL = true;
          univ[i].ISCENTER = false;
          univ[i].CELLNUM = this.idx;
          univ[i].CELLBORN = frameCount;
          univ[i].CELLPOS = p5.Vector.sub(univ[i].position, this.position);
        }

        this.ISCENTER = true;
        this.CELLNUM = this.idx;
        this.CELLBORN = frameCount;
        this.CELLPOS = createVector(0, 0);
      }
    }
  }

  update() {
    if (this.ISCENTER || !this.ISCELL) {
      this.acceleration.add(random(-2, 2), random(-2, 2));

      this.position.add(this.velocity);
      this.velocity.add(this.acceleration);
      this.velocity.limit(this.maxSpeed);

      if (frameCount - this.CELLBORN > 300 && this.ISCENTER)
        this.ISCENTER = false;
    } else {
      if (frameCount - this.CELLBORN > 300) {
        this.position.add(this.velocity);
        this.velocity.add(this.CELLPOS);
        this.velocity.limit(this.maxSpeed * 2);
        if (frameCount - this.CELLBORN > 330) this.ISCELL = false;
      } else {
        this.position.add(univ[this.CELLNUM].velocity);
        this.velocity.add(univ[this.CELLNUM].acceleration);
        this.velocity.limit(this.maxSpeed);
      }
    }
  }

  show() {
    strokeWeight(6);

    if (!this.ISCELL && !this.ISCENTER) {
      stroke(255);
    } else {
      stroke(univ[this.CELLNUM].c);
    }

    point(this.position.x, this.position.y);
  }
}
