var me = {
  first_name: "Jane",
  last_name: "Doe"
};

var friend = {
  first_name: "John",
  last_name: "Smith"
};

var mother = {
  first_name: "Amber",
  last_name: "Doe"
};

var father = {
  first_name: "Shane",
  last_name: "Doe"
};

var people = {
  collection = [me, friend, mother, father],
  fullName: function(person) {
    console.log(person.first_name + " " + person.last_name);
  },
  rollCall: function() {
    this.collection.forEach(this.fullName);
  },
  add: function(person) {
    this.collection.push(person);
  },
  remove: function(person) {
    var idx = this.collection.indexOf(person);

  }
};

people.push(me);
people.push(friend);
people.push(mother);
people.push(father);

function fullName(person) {
  console.log(person.first_name + " " + person.last_name);
}

function rollCall(collection) {
  collection.forEach(fullName);
}
console.log(people.length);

rollCall(people);
