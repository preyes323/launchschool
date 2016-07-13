function extend(destination) {
  var result = destination;
  var objects = Array.prototype.slice.call(arguments, 1);

  for (var i = 0, length = objects.length; i < length; i++) {
    for (var prop in objects[i]) {
      if (Object.prototype.hasOwnProperty.call(objects[i], prop)) {
        result[prop] = objects[i][prop];
      }
    }
  }

  return result;
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

console.log(object.b.x);     // 1
console.log(object.sayHello());
