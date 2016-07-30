// function getDefiningObject(object, propKey) {
//   while (Object.getPrototypeOf(object)) {
//     if (Object.prototype.hasOwnProperty.call(object, propKey)) {
//       return object;
//     }
//     object = Object.getPrototypeOf(object);
//   }

//   return null;;
// }

// var foo = { a: 1, b: 2 };
// var bar = Object.create(foo);
// var baz = Object.create(bar);
// var qux = Object.create(baz);

// bar.c = 3;

// console.log(getDefiningObject(qux, 'c') === bar);
// console.log(getDefiningObject(qux, 'e'))    // null

// function shallowCopy(object) {
//   var obj = Object.create(Object.getPrototypeOf(object));
//   var props = Object.keys(object);

//   for (var i = 0; i < props.length; i++) {
//     obj[props[i]] = object[props[i]];
//   }

//   return obj;
// }

// var foo = { a: 1, b: 2 };
// var bar = Object.create(foo);

// bar.c = 3;
// bar.say = function() {
//   console.log('c is ' + this.c);
// };

// var baz = shallowCopy(bar);

// console.log(baz.a);
// baz.say();

function extend(destination) {
  var source;

  for (var i = 1; i < arguments.length; i++) {
    source = arguments[i];
    for (prop in source) {
      if (Object.prototype.hasOwnProperty.call(source, prop)) {
        destination[prop] = source[prop];
      }
    }
  }

  return destination;
}

var foo = {
  a: 0,
  b: { x: 1, y: 2 }
};

var joe = { name: 'Joe' };

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
