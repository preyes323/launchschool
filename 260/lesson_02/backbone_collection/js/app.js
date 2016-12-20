const User = Backbone.Model.extend({
  url: 'http://jsonplaceholder.typicode.com/users',
});

const Users = Backbone.Collection.extend({
  model: User,
  url: 'http://jsonplaceholder.typicode.com/users',
});

const users = new Users;

users.fetch({
  success(collection) {
    console.log(collection.toJSON());
    var me = new User({
      name: 'Victor Paolo Reyes',
      email: 'vpaoloreyes@gmail.com',
    });

    users.add(me);

    me.save(null, {
      success() {
        console.log(users.toJSON());
      },
    });
  },
});
