const App = {
  setupTemplates() {
    Handlebars.partials = Handlebars.templates;
    Handlebars.registerHelper('formatDate', function(price) {
      return parseInt(price).toFixed(2);
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
    this.setupRouter();
  },
};
