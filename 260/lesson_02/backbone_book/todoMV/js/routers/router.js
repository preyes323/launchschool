var app = app || {};
const Workspace = Backbone.Router.extend({
  routes: {
    '*filter': 'setFilter',
  },

  setFilter(param) {
    if (param) {
      param.trim();
    }

    app.TodoFilter = param || '';
    app.Todos.trigger('filter');
  },
});

app.TodoRouter = new Workspace();
Backbone.history.start();
