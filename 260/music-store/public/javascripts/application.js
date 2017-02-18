const App = {
  init() {
    this.appView = new AppView({ collection: this.albums });
    this.appView.render();
  },
};

Handlebars.partials = Handlebars.templates;
Handlebars.registerHelper('formatDate', function(price) {
  return parseInt(price).toFixed(2);
});
