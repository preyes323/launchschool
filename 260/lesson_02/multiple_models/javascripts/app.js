const templates = {};
$('[type="text/x-handlebars"]').each((_, template) => {
  const $template = $(template);
  templates[$template.attr('id')] = Handlebars.compile($template.html());
});

Handlebars.registerPartial({ item: templates.item });

const Item = Backbone.Model.extend();

const collection = {
  lastId: 0,
  list: [],
  save() {},

  sortBy(criteria) {
    this.list = _.sortBy(this.list, (item) => item.get(criteria));
    return this;
  },

  fetch() {},

  add(itemData) {
    const item = new Item(itemData);
    item.set('id', ++this.lastId);
    this.list.push(item);
    return item;
  },

  remove(itemId) {
    this.list = _.reject(this.list, (item) => item.get('id') === itemId);
    return this;
  },

  deleteAll() {
    this.list.length = 0;
  },
};

const view = {
  $table: '',
  $form: '',
  $deleteAll: '',
  renderItems() {
    this.$table.find('tbody').html(templates.items({ items: collection.list }));
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
    this.renderItem(collection.add(itemData));
    return this;
  },

  deleteItem(e) {
    e.preventDefault();
    const $item = $(e.currentTarget);
    const id = $item.data('id');

    collection.remove(id);
    $item.closest('tr').remove();
    return this;
  },

  deleteItems(e) {
    e.preventDefault();
    collection.deleteAll();
    this.$table.find('tbody').html('');
    return this;
  },

  sortItems(e) {
    const sortCriteria = $(e.currentTarget).data('prop');
    collection.sortBy(sortCriteria);
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
    return this;
  },
};

view.init();
