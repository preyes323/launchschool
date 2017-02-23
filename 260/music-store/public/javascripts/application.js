const App = {
  setupTemplates() {
    Handlebars.partials = Handlebars.templates;
    Handlebars.registerHelper('formatPrice', function(price) {
      return Number(price).toFixed(2);
    });
    Handlebars.registerHelper('pluralize', function(quantity) {
      let msg;
      if (quantity > 1) {
        msg = `${quantity} items`;
      } else {
        msg = `${quantity} item`;
      }

      return msg;
    });
  },

  setupRouter() {
    Backbone.history.start({
      pushState: true,
    });

    $(document).on('click', 'a[href^="/"]', function(e) {
      e.preventDefault();
      App.router.navigate($(e.currentTarget).attr('href').replace(/^\//, ''), { trigger: true });
    });
  },

  init() {
    this.setupTemplates();
    this.router = new Router;
    this.cart = new CartItems;
    this.setupRouter();
  },
};
