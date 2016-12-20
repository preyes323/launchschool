const Product = Backbone.Model.extend({
  setFormattedDate() {
    const dateVal = this.get('date');
    this.set('datetime', moment(dateVal).format());
    this.set('date_formatted', moment(dateVal).format('MMMM Do, YYYY HH:mm:ss'));
    return this;
  },

  updateDate() {
    this.set('date', (new Date()).valueOf());
    return this;
  },

  initialize() {
    this.setFormattedDate();
  },
});

const sudoView = {
  $header: '',
  $form: '',
  headerTemplate: Handlebars.compile($('#product').html()),
  formTemplate: Handlebars.compile($('#form').html()),

  renderHeader() {
    this.$header.html(this.headerTemplate(this.product.toJSON()));
    return this;
  },

  renderForm() {
    this.$form.html(this.formTemplate(this.product.toJSON()));
    return this;
  },

  update(e) {
    e.preventDefault();
    this.product.set('name', $('#name').val());
    this.product.set('description', $('#description').val());
    this.product.updateDate().setFormattedDate();
    this.renderHeader();
  },

  bindEvents() {
    $('form').on('submit', this.update.bind(this));
  },

  init() {
    this.$header = $('article');
    this.$form = $('form fieldset');
    this.product = new Product(product_json);
    this.renderHeader();
    this.renderForm();
    this.bindEvents();
    return this;
  },
};

sudoView.init().renderHeader().renderForm();
