function shallowCopy(object) {
  var result = Object.create(Object.getPrototypeOf(object));

  for (var prop in object) {
    if (Object.prototype.hasOwnProperty.call(object, prop)) {
      result[prop] = object[prop];
    }
  }

  return result;
}

var foo = {a: 1, b: 2};
var bar = Object.create(foo);

bar.c = 3;
bar.say = function() {
  console.log('c is ' + this.c);
}

var baz = shallowCopy(bar);

console.log(baz.a) // 1
baz.say(); // c is 3
console.log(Object.getPrototypeOf(baz));
