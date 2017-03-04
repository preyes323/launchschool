const App = {
  setupHandlebars() {
    Handlebars.registerHelper('formatPrice', function(price) {
      return `$${price}`;
    });

    Handlebars.registerHelper('imgSrc', function(name) {
      return name.toLowerCase().split(' ').join('-');
    });
  },

  renderMenu() {
    this.$menu.html(this.menu.render());
  },

  setupMenu() {
    this.$menu = $('.menu');
    this.menuItems = new MenuItems;
    this.menuItems.fetch({
      success() {
        App.menu = new Menu({ collection: App.menuItems });
        App.renderMenu();
      },
    });
  },

  addCartItem(item) {
    this.$itemCount.text(`${item.get('id')} Items`);
  },

  bindAnchors() {
    this.$itemCount = $('.cart-info .item-count');
  },

  bindEvents() {
    this.on('add-item', this.addCartItem, this);
  },

  init() {
    _.extend(this, Backbone.Events);
    this.setupHandlebars();
    this.setupMenu();
    this.bindAnchors();
    this.bindEvents();
  },
};

App.init();
