var app = app || {};
app.TodoView = Backbone.View.extend({
  tagName: 'li',
  template: _.template($('#item-template').html()),
  events: {
    'click .toggle': 'toggleCompleted',
    'click .destroy': 'clear',
    'dblclick label': 'edit',
    'keypress .edit': 'updateOnEnter',
    'blur .edit': 'close',
  },

  initialize() {
    this.listenTo(this.model, 'change', this.render);
    this.listenTo(this.model, 'destroy', this.remove);
    this.listenTo(this.model, 'visible', this.toggleVisible);
  },

  render() {
    this.$el.html(this.template(this.model.attributes));

    this.$el.toggleClass('completed', this.model.get('completed'));
    this.toggleVisible();

    this.$input = this.$('.edit');
    return this;
  },

  toggleVisible() {
    this.$el.toggleClass('hidden', this.isHidden());
  },

  isHidden() {
    const isCompleted = this.model.get('completed');
    return ((!isCompleted && app.TodoFilter === 'completed') ||
            (isCompleted && app.TodoFilter === 'active'));
  },

  toggleCompleted() {
    this.model.toggle();
  },

  edit() {
    this.$el.addClass('editing');
    this.$input.focus();
  },

  close() {
    const value = this.$input.val().trim();

    if (value) {
      this.model.save({ title: value });
    } else {
      this.clear();
    }

    this.$el.removeClass('editing');
  },

  updateOnEnter(e) {
    if (e.which === ENTER_KEY) {
      this.close();
    }
  },

  clear() {
    this.model.destroy();
  },
});
