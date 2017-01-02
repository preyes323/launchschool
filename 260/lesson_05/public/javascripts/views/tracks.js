const TracksView = Backbone.View.extend({
  tagName: 'article',
  template: Handlebars.compile($('#tracksHeader').html()),
  events: {
    'click': 'close',
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

  close(e) {
    if ($(e.target).hasClass('closeAlbum')) {
      this.fadeOut();
      history.back();
    }

    return false;
  },

  fadeOut() {
    this.$el.fadeOut(this.duration, this.remove.bind(this));
  },

  open() {
    $('body').append(this.$el);
    this.$el.fadeIn(this.duration);
  },

  render() {
    this.renderHeader();
    this.renderTracks();
    this.open();
  },

  initialize(options) {
    this.$el.addClass('closeAlbum');
    this.album = App.albums.findWhere({ title: options.album });
    this.duration = 500;
    this.collection = new Tracks();
    this.collection.url = `${this.album.get('tracksUrl')}.json`;
    this.collection.fetch({ success: this.render.bind(this) });
  },
});
