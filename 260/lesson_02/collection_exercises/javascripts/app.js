const templates = {};
$('[type="text/x-handlebars"]').each((_, template) => {
  const $template = $(template);
  templates[$template.attr('id')] = Handlebars.compile($template.html());
});

Handlebars.registerPartial({ item: templates.item });

const app = {};

app.Item = Backbone.Model.extend();

const ItemsCollection = Backbone.Collection.extend({
  model: app.Item,
  localStorage: new Backbone.LocalStorage('items-backbone'),

  seed() {
    this.reset();
    items_json.forEach((item) => this.create(item));
  },

  sortWith(comparator) {
    this.comparator = comparator;
    this.sort();
  },

  initialize() {
    this.fetch();
    if (!this.length) this.seed();
    this.comparator = 'name';
    this.sort();
    this.on('sort', view.renderItems.bind(view));
    return this;
  },
});

const view = {
  $table: '',
  $form: '',
  $deleteAll: '',
  renderItems() {
    this.$table.find('tbody').html(templates.items({ items: app.Items.models }));
  },

  renderItem(item) {
    this.$table.find('tbody').append(templates.item(item.toJSON()));
  },

  addItem(e) {
    e.preventDefault();
    const form = e.currentTarget;
    const itemData = {};
    $(form).serializeArray().forEach((item) => {
      itemData[item.name] = item.value;
    });

    form.reset();
    app.Items.create(itemData, { wait: true });
    return this;
  },

  deleteItem(e) {
    e.preventDefault();
    const $item = $(e.currentTarget);
    const id = $item.data('id');

    app.Items.get(id).destroy();
    $item.closest('tr').remove();
    return this;
  },

  deleteItems(e) {
    e.preventDefault();
    _.invoke(app.Items.models.slice(), 'destroy');
    this.$table.find('tbody').html('');
    return this;
  },

  sortItems(e) {
    const sortCriteria = $(e.currentTarget).data('prop');
    app.Items.sortWith(sortCriteria);
    this.renderItems();
    return this;
  },

  bindEvents() {
    this.$form.on('submit', this.addItem.bind(this));
    this.$table.on('click', 'a', this.deleteItem.bind(this));
    this.$table.on('click', 'th', this.sortItems.bind(this));
    this.$deleteAll.on('click', this.deleteItems.bind(this));
  },

  init() {
    this.$table = $('table');
    this.$form = $('form');
    this.$deleteAll = $('main > p a');
    this.bindEvents();
    this.renderItems();
    return this;
  },
};

app.Items = new ItemsCollection();
view.init();
