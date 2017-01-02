const Workspace = Backbone.Router.extend({
  routes: {
    'albums/:album': 'loadTracks',
  },

  loadTracks(album) {
    App.tracks = new TracksView({ album });
  },

  index() {
    if (!App.tracks.$el.is(':animated')) {
      App.tracks.fadeOut();
    }
  },

  initialize() {
    this.route(/^\/?$/, 'index', this.index);
    $(document).on('click', 'a[href^="/"]', function(e) {
      this.navigate($(e.currentTarget).attr('href').replace(/^\//, ''), { trigger: true });
      return false;
    }.bind(this));
  },
});
