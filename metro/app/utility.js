// Generated by CoffeeScript 1.10.0
this.sample = function(array) {
  return array[floor(random(0, array.length))];
};

this.polygonal = function(points) {
  var i, j, p, q, ref, results;
  results = [];
  for (i = j = 0, ref = points.length - 1; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
    p = points[i];
    q = points[i + 1];
    results.push(line(p.x, p.y, q.x, q.y));
  }
  return results;
};
