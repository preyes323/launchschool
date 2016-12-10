var app = app || {};
const TodoList = Backbone.Collection.extend({
  model: app.Todo,
  localStorage: new Backbone.LocalStorage('todos-backbone'),
  completed() {
    return this.filter((todo) => todo.get('completed'));
  },
  remaining() {
    return this.without(...this.completed);
  },
  nextOrder() {
    if (!this.length) return 1;
    return this.last().get('order') + 1;
  },
  comparator(todo) {
    return todo.get('order');
  },
});

app.Todos = new TodoList();
