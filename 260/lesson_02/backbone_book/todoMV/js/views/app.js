var app = app || {};
app.AppView = Backbone.View.extend({
  el: '#todoapp',
  statsTemplate: _.template($('#stats-template').html()),
  events: {
    'keypress #new-todo': 'createOnEnter',
    'click #clear-completed': 'clearCompleted',
    'click #toggle-all': 'toggleAllComplete',
  },

  initialize() {
    this.allCheckbox = this.$('#toggle-all')[0];
    this.$input = this.$('#new-todo');
    this.$footer = this.$('#footer');
    this.$main = this.$('#main');

    this.listenTo(app.Todos, 'add', this.addOne);
    this.listenTo(app.Todos, 'reset', this.addAll);
    this.listenTo(app.Todos, 'change:completed', this.filterOne);
    this.listenTo(app.Todos, 'filter', this.filterAll);
    this.listenTo(app.Todos, 'all', this.render);

    app.Todos.fetch();
  },

  render() {
    const completed = app.Todos.completed().length;
    const remaining = app.Todos.remaining().length;

    if (app.Todos.length) {
      this.$main.show();
      this.$footer.show();

      this.$footer.html(this.statsTemplate({
        completed,
        remaining,
      }));

      this.$('#filters li a')
        .removeClass('selected')
        .filter('[href="/]' + (app.TodoFilter || '') + '"]')
        .addClass('selected');
    } else {
      this.$main.hide();
      this.$footer.hide();
    }

    this.allCheckbox.checked = !remaining;
  },

  addOne(todo) {
    const view = new app.TodoView({ model: todo});
    $('#todo-list').append(view.render().el);
  },

  addAll() {
    this.$('#todo-list').html('');
    app.Todos.each(this.addOne, this);
  },

  filterOne(todo) {
    todo.trigger('visible');
  },

  filterAll() {
    app.Todos.each(this.filterOne, this);
  },

  newAttributes() {
    return {
      title: this.$input.val().trim(),
      order: app.Todos.nextOrder(),
      completed: false,
    };
  },

  createOnEnter(event) {
    if (event.which !=== ENTER_KEY || !this.$input.val().trim()) {
      return;
    }

    app.Todos.create(this.newAttributes());
    this.$input.val('');
  }

  clearCompleted() {
    _.invoke(app.Todos.completed(), 'destroy');
    return false;
  }

  toggleAllComplete() {
    const completed = this.allCheckbox.checked;

    app.Todos.each((todo) => {
      todo.save({ completed });
    });
  },
});
