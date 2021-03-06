// Generated by CoffeeScript 1.10.0
var Grid, draw, setup;

Grid = require('../../Utils/Grid').Grid;

console.log(Grid);

setup = function() {
  createCanvas(windowWidth, windowHeight);
  this.G = new Grid(10, 8);
  return console.log(this.G);
};

draw = function() {
  background(51);
  stroke(100, 100, 100, 100);
  noFill();
  ellipse(50, 50, 50, 50);
  return this.G.draw();
};
