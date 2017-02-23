const NewAlbumView = Backbone.View.extend({
  el: 'main',
  template: Handlebars.templates.newAlbum,
  events: {
    'click form .btn-add': 'createAlbum',
  },

  render() {
    this.$el.html(this.template);
  },

  getAlbumData(formData) {
    const album = {};
    formData.forEach((field) => {
      album[field.name] = field.value;
    });

    return album;
  },

  createAlbum(e) {
    e.preventDefault();
    App.albums.add(this.getAlbumData($('form').serializeArray()));
    App.router.navigate('/', { trigger: true });
  },
});
