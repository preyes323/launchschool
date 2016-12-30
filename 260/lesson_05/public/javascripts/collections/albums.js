const Albums = Backbone.Collection.extend({
  model: Album,
  url: '/albums.json',
});
