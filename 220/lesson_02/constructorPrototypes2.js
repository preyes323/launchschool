// var shape = {
//   type: '',
//   getType: function() {
//     return this.type;
//   }
// }

// function Triangle(a, b, c) {
//   this.type = 'triangle'
//   this.a = a;
//   this.b = b;
//   this.c = c;
// }

// Triangle.prototype = shape;
// Triangle.prototype.getPerimeter = function() {
//   return this.a + this.b + this.c;
// };

// var t = new Triangle(1, 2, 3);
// console.log(t.constructor);
// console.log(shape.isPrototypeOf(t));
// console.log(t.getPerimeter());
// console.log(t.getType());

// function User(first, last) {
//   if (this instanceof User) {
//     this.name = first + ' ' + last;
//   } else {
//     var f = new User(first, last);
//     return f;
//   }
// }

// var name = 'Jane Doe';
// var user1 = new User('John', 'Doe');
// var user2 = User('John', 'Doe');

// console.log(name);
// console.log(user1.name);
// console.log(user2.name);

// function createObject(obj) {
//   function F() {};
//   F.prototype = obj;
//   return new F;
// }

// Object.prototype.begetObject = function() {
//   function F() {};
//   F.prototype = this;
//   return new F;
// };

// var foo = { a: 1 };
// var bar = foo.begetObject();
// console.log(foo.isPrototypeOf(bar));

function neww(constructor, args) {
  var obj = Object.create(constructor.prototype);
  console.log('obj',  obj);

  var result = constructor.apply(obj, args);
//  console.log('result', result);

  //return obj;
  return result === undefined ? obj : result;
}

function Person(firstName, lastName) {
  // this.firstName = firstName;
  // this.lastName = lastName;
}




Person.prototype.greeting = function() {
  console.log('Hello, ' + this.firstName + ' ' + this.lastName);
};

var john = neww(Person, ['John', 'Doe', 'test']);

//john.greeting();
console.log(john.constructor);
