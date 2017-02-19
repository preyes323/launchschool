const IndexView = Backbone.View.extend({
  el: 'main',
  template: Handlebars.templates.index,

  render() {
    this.$el.html(this.template({ title: 'Music Store' }));
  },
});
