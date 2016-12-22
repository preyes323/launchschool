const app = {};

app.Item = Backbone.Model.extend();

const ItemsCollection = Backbone.Collection.extend({
  model: app.Item,
  localStorage: new Backbone.LocalStorage('items-backbone'),

  sortWith(comparator) {
    this.comparator = comparator;
    this.sort();
  },

  initialize() {
    this.sortWith('name');
    return this;
  },
});

app.AppView = Backbone.View.extend({
  el: 'main',
  events: {
    'click table th': 'sortItems',
    'submit form': 'addItem',
    'click p a': 'deleteItems',
  },

  render() {
    this.$('tbody').html('');
    app.Items.each(this.addOne, this);
  },

  addOne(item) {
    const view = new app.ItemView({ model: item });
    this.$('tbody').append(view.render().el);
  },

  initialize() {
    this.$form = this.$('form');
    this.listenTo(app.Items, 'add', this.addOne);
    this.listenTo(app.Items, 'all', this.render);

    app.Items.fetch();
  },

  newAttributes() {
    return {
      name: this.$form.find('[name="name"]').val(),
      quantity: this.$form.find('[name="quantity"]').val(),
    };
  },

  sortItems(e) {
    const criteria = $(e.target).data('prop');
    app.Items.sortWith(criteria);
  },

  addItem() {
    app.Items.create(this.newAttributes());
    this.$form.get(0).reset();
    return false;
  },

  deleteItems() {
    _.invoke(app.Items.slice(), 'destroy');
    return false;
  },
});

app.ItemView = Backbone.View.extend({
  tagName: 'tr',
  template: Handlebars.compile($('#item').html()),
  events: {
    'click a': 'clear',
  },

  initialize() {
    this.listenTo(this.model, 'destroy', this.remove);
  },

  render() {
    this.$el.html(this.template(this.model.toJSON()));
    return this;
  },

  clear() {
    this.model.destroy();
  },
});

app.Items = new ItemsCollection();
new app.AppView();
