function Vehicle() {}

Vehicle.prototype = {
  doors: 4,
  wheels: 4
};

var sedan = new Vehicle();
var coupe = new Vehicle();
coupe.doors = 2;

console.log(sedan.hasOwnProperty('doors'));
console.log(coupe.hasOwnProperty('doors'));

function Coupe() {};
Coupe.prototype = new Vehicle();
Coupe.prototype.doors = 2;
Coupe.prototype.constructor = Coupe;

function Motorcycle() {
  var o = this;
  if (!(this instanceof Motorcycle)) {
    o = new Motorcycle();
  };

  o.doors = 0;
  o.wheels = 2;

  return o;
}

Motorcycle.prototype = new Vehicle();
Motorcycle.prototype.constructor = Motorcycle;

var coupe2 = new Coupe();
var motor = new Motorcycle();

console.log(coupe2 instanceof Coupe);
console.log(coupe2 instanceof Vehicle);

function Sedan() {

}

Sedan.prototype = Object.create(Vehicle.prototype);
var sedan2 = new Sedan()

console.log(sedan2 instanceof Sedan);
console.log(sedan2 instanceof Vehicle);
