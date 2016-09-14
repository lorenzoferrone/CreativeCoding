// Generated by CoffeeScript 1.10.0
var Gibber, Particle, count, draw, keyTyped, particles, setup;

Particle = require('./app/particle').Particle;

Gibber = require('p5.gibber.js');

count = 1000;

particles = [];

keyTyped = function() {
  if (key === 'p') {
    this.a.disconnect();
    return noLoop();
  }
};

setup = function() {
  var force, i, j, p, ref, type, vx, vy, x, y;
  createCanvas(windowWidth, windowHeight);
  for (i = j = 1, ref = count; 1 <= ref ? j <= ref : j >= ref; i = 1 <= ref ? ++j : --j) {
    x = random(-2500, width + 2500);
    y = random(-2500, height + 2500);
    vx = random(-4, 4);
    vy = random(-4, 4);
    type = random([0, 1, 2, 3]);
    force = 0.1 + type / 200;
    p = new Particle(x, y, vx, vy, type, force);
    this.particles.push(p);
  }
  return this.a = Sine({});
};

draw = function() {
  var j, k, l, lasts, leading, leadingParticles, len, len1, len2, particle, total;
  background(70);
  total = 0;
  leadingParticles = particles.slice(-1);
  for (j = 0, len = leadingParticles.length; j < len; j++) {
    lasts = leadingParticles[j];
    lasts.x = lasts.x + random(-500, 500);
    lasts.y = lasts.y + random(-500, 500);
    lasts.x = constrain(lasts.x, 50, width - 50);
    lasts.y = constrain(lasts.y, 50, height - 50);
    lasts.vx = 0;
    lasts.vy = 0;
    lasts.force = 2000;
    lasts.type = 2;
  }
  for (k = 0, len1 = particles.length; k < len1; k++) {
    particle = particles[k];
    for (l = 0, len2 = leadingParticles.length; l < len2; l++) {
      leading = leadingParticles[l];
      particle.interact(leading);
      particle.update();
    }
    total = total + Math.pow(particle.vx, 2) + Math.pow(particle.vy, 2);
    point(particle.x, particle.y);
  }
  return this.a.frequency = total / 100;
};
