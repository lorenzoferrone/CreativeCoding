// Generated by CoffeeScript 1.10.0
var Agent, DNA, Food;

DNA = require('./dna.js');

Food = (function() {
  function Food(x, y) {
    this.location = createVector(x, y);
    this.poisonous = false;
  }

  Food.prototype.draw = function() {
    if (this.poisonous) {
      fill(250, 0, 100, 150);
    } else {
      fill(0, 150, 0, 150);
    }
    noStroke();
    return ellipse(this.location.x, this.location.y, 15, 15);
  };

  return Food;

})();

Agent = (function() {
  function Agent(x, y, dna) {
    this.dna = dna;
    this.location = createVector(x, y);
    this.velocity = createVector(random(-4, 4), random(-4, 4));
    this.acceleration = createVector(0, 0);
    if (this.dna === void 0) {
      this.dna = new DNA(void 0, 10);
    }
    this.maxSpeed = map(this.dna.genes[0], 0, 1, 0.1, 4);
    this.maxForce = map(this.dna.genes[1], 0, 1, 0.5, 1);
    this.r = map(this.dna.genes[2], 0, 1, 20, 40);
    this.sight = map(this.dna.genes[3], 0, 1, 50, 150) + this.r / 2;
    this.color = map(this.dna.genes[4], 0, 1, 100, 200);
    this.age = map(this.dna.genes[5], 0, 1, 90, 110);
    this.health = map(this.dna.genes[6], 0, 1, 90, 110);
    this.velocity.limit(this.maxSpeed);
  }

  Agent.prototype.applyForce = function(force) {
    return this.acceleration.add(force);
  };

  Agent.prototype.reproduce = function() {
    var a, childDNA;
    if (random() < 0.001) {
      childDNA = this.dna.copy();
      childDNA.mutate();
      a = new Agent(this.location.x + this.r, this.location.y + this.r, childDNA);
      return a;
    }
  };

  Agent.prototype.see = function(environment) {
    var entity, i, len, neighbour, ref, vector;
    neighbour = [];
    ref = environment.entities;
    for (i = 0, len = ref.length; i < len; i++) {
      entity = ref[i];
      if (entity !== this) {
        vector = p5.Vector.sub(this.location, entity.location);
        if (vector.mag() < this.sight) {
          if (p5.Vector.angleBetween(this.velocity, vector) > HALF_PI) {
            neighbour.push(entity);
          }
        }
      }
    }
    return neighbour;
  };

  Agent.prototype.drawSight = function(elements) {
    var distance, i, len, n, results, textPos;
    stroke(100, 100, 100, 100);
    fill(100, 100, 100, 100);
    results = [];
    for (i = 0, len = elements.length; i < len; i++) {
      n = elements[i];
      line(this.location.x, this.location.y, n.location.x, n.location.y);
      distance = dist(this.location.x, this.location.y, n.location.x, n.location.y);
      textPos = {
        x: (this.location.x + n.location.x) / 2,
        y: (this.location.y + n.location.y) / 2
      };
      results.push(text(distance.toFixed(0), textPos.x, textPos.y, 50, 50));
    }
    return results;
  };

  Agent.prototype.steer = function(desired) {
    var steer;
    steer = p5.Vector.sub(desired, this.velocity);
    steer.limit(this.maxForce);
    return this.applyForce(steer);
  };

  Agent.prototype.wander = function(radius) {
    var angle, direction, futureLocation, position, target;
    angleMode(DEGREES);
    direction = this.velocity.copy();
    direction.setMag(4 * this.r + radius);
    futureLocation = p5.Vector.add(this.location, direction);
    angle = random(0, 360);
    position = p5.Vector.fromAngle(angle);
    target = p5.Vector.add(futureLocation, p5.Vector.mult(position, radius / 2));
    this.seek(target);
    return angleMode(RADIANS);
  };

  Agent.prototype.arrive = function(target) {
    var d, desired, m;
    desired = p5.Vector.sub(target, this.location);
    d = desired.mag();
    desired.normalize();
    if (d < 500) {
      m = map(d, 0, 100, 0, this.maxSpeed);
      desired.mult(m);
    } else {
      desired.mult(this.maxSpeed);
    }
    return this.steer(desired);
  };

  Agent.prototype.seek = function(target) {
    var desired;
    desired = p5.Vector.sub(target, this.location);
    desired.setMag(this.maxSpeed);
    return this.steer(desired);
  };

  Agent.prototype.decideTarget = function(targets) {
    targets = targets.filter((function(_this) {
      return function(element) {
        return (element instanceof Food) && (!element.poisonous);
      };
    })(this));
    if (targets.length > 0) {
      targets.sort((function(_this) {
        return function(a, b) {
          if (dist(_this.location.x, _this.location.y, a.location.x, a.location.y) > dist(_this.location.x, _this.location.y, b.location.x, b.location.y)) {
            return 1;
          } else {
            return -1;
          }
        };
      })(this));
      return this.seek(targets[0].location);
    } else {
      return this.wander(40);
    }
  };

  Agent.prototype.avoidWalls = function() {
    var desired, tolerance;
    tolerance = 100;
    if (this.location.x > width - tolerance) {
      desired = createVector(-this.maxSpeed, this.velocity.y);
    } else if (this.location.x < tolerance) {
      desired = createVector(this.maxSpeed, this.velocity.y);
    } else if (this.location.y > height - tolerance) {
      desired = createVector(this.velocity.x, -this.maxSpeed);
    } else if (this.location.y < tolerance) {
      desired = createVector(this.velocity.x, this.maxSpeed);
    } else {
      desired = this.velocity;
    }
    desired.setMag(this.maxSpeed);
    return this.steer(desired);
  };

  Agent.prototype.avoid = function(target) {
    var d, desired;
    desired = p5.Vector.sub(this.location, target);
    d = desired.mag();
    if (d < this.sight) {
      desired.setMag(map(d, 0, this.sight, this.maxSpeed, 0));
    } else {
      desired = this.velocity;
    }
    return this.steer(desired);
  };

  Agent.prototype.separate = function(targets) {
    var count, d, diff, i, len, target, total;
    total = createVector(0, 0);
    count = 0;
    for (i = 0, len = targets.length; i < len; i++) {
      target = targets[i];
      d = dist(this.location.x, this.location.y, target.location.x, target.location.y);
      if ((d > 0) && (d < this.sight + this.r + target.r)) {
        diff = p5.Vector.sub(this.location, target.location);
        diff.normalize();
        diff.mult(map(d, 0, this.sight + this.r + target.r, 0, this.maxSpeed));
        total.add(diff);
        count = count + 1;
      }
    }
    if (count > 0) {
      total.div(count);
      total.setMag(this.maxSpeed);
      return this.steer(total);
    }
  };

  Agent.prototype.bounce = function() {
    if ((this.location.x > width - this.r / 2) || (this.location.x < this.r / 2)) {
      this.velocity = createVector(-this.velocity.x, this.velocity.y);
    }
    if ((this.location.y > height - this.r / 2) || (this.location.y < this.r / 2)) {
      return this.velocity = createVector(this.velocity.x, -this.velocity.y);
    }
  };

  Agent.prototype.move = function(environment) {
    var neighbour;
    this.avoidWalls();
    this.bounce();
    neighbour = this.see(environment);
    this.decideTarget(neighbour);
    this.drawSight(neighbour);
    this.velocity.add(this.acceleration);
    this.location.add(this.velocity);
    return this.acceleration.mult(0);
  };

  Agent.prototype.draw = function() {
    fill(this.color, this.color, this.color, map(min(this.health, this.age), 0, 100, 10, 255));
    noStroke();
    ellipse(this.location.x, this.location.y, this.r, this.r);
    noFill();
    stroke(this.color, this.color, this.color, 100);
    return ellipse(this.location.x, this.location.y, 2 * this.sight, 2 * this.sight);
  };

  return Agent;

})();

module.exports = {
  Agent: Agent,
  Food: Food
};
