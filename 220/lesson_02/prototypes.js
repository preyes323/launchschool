// function getDefiningObject(object, propKey) {
//   do {
//     if (object.hasOwnProperty(propKey)) return object;
//   } while (object = Object.getPrototypeOf(object));

//   return object;
// }

// var foo = {a: 1, b: 2};
// var bar = Object.create(foo);
// var baz = Object.create(bar);
// var qux = Object.create(baz);

// bar.c = 3;

// console.log(getDefiningObject(qux, 'c') === bar);    // true
// console.log(getDefiningObject(qux, 'e'));            // null

// function shallowCopy(object) {
//   var copy = Object.create(Object.getPrototypeOf(object));

//   for (prop in object) {
//     if (Object.prototype.hasOwnProperty.call(object, prop)) copy[prop] = object[prop];
//   }

//   return copy;
// }

// var foo = {a: 1, b: 2};
// var bar = Object.create(foo);

// bar.c = 3;
// bar.say = function() {
//   console.log('c is ' + this.c);
// };

// var baz = shallowCopy(bar);

// console.log(baz.a);
// baz.say();


function extend(destination) {
  var destinationObject = destination[0];
  var sourceObjects = Array.prototype.slice.call(destination, 1);

  for (var i = 0, length = sourceObjects.length; i < length; i++) {

  }
}

var foo = {
  a: 0,
  b: {x: 1, y: 2}
};

var joe = {
  name: 'Joe'
};

var funcs = {
  sayHello: function() {
    console.log('Hello, ' + this.name);
  },

  sayGoodBye: function() {
    console.log('Goodbye, ' + this.name);
  }
};

var object = extend({}, foo, joe, funcs);

console.log(object.b.x);
console.log(object.sayHello());
