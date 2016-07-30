// function Circle(radius) {
//   this.radius = radius;
// }

// Circle.prototype.area = function() {
//   return Math.PI * this.radius * this.radius;
// }

// var a = new Circle(3);
// var b = new Circle(4);

// console.log(a.area().toFixed(2));
// console.log(b.area().toFixed(2));

// function Ninja() {
//   this.swung = false;
// }

// var ninjaA = new Ninja;
// var ninjaB = new Ninja;

// Ninja.prototype.swing = function() {
//   this.swung = !this.swung;
//   return this;
// }

// console.log(ninjaA.swing().swung);
// console.log(ninjaB.swing().swung);

var ninjaA = (function() {
  function Ninja(){};
  return new Ninja();
})();

var ninjaB = Object.create(Object.getPrototypeOf(ninjaA));
console.log(ninjaB.constructor === ninjaA.constructor);
