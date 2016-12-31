const TracksView = Backbone.View.extend({
  tagName: 'article',
  template: Handlebars.compile($('#tracksHeader').html()),
  events: {
    'click .closeAlbum': 'close',
    'click article': 'close',
  },

  renderHeader() {
    this.$el.html(this.template(this.album.toJSON()));
  },

  renderTracks() {
    const $tbody = this.$('tbody');
    this.collection.each((track) => {
      const view = new TrackView({ model: track });
      $tbody.append(view.render().el);
    });
  },

  close() {
    this.$el.fadeOut(this.duration, this.remove.bind(this));
  },

  open() {
    $('body').append(this.$el.fadeIn(this.duration));
  },

  render() {
    this.renderHeader();
    this.renderTracks();
    this.open();
  },

  initialize(options) {
    this.album = options.album;
    this.duration = 2000;
    this.collection = new Tracks();
    this.collection.url = this.album.get('tracksUrl');
    this.collection.fetch();
  },
});
