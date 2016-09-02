$(document).ready(function() {
  Handlebars.partials = Handlebars.templates;

  $.ajax({
    url: "/photos",
    type: "GET",
    dataType: "json",
  }).done(function(json) {
    var photos = json;
    renderPhotos(photos);
    renderPhotoInformation(photos, photos[0].id);
    getCommentsFor(photos[0].id);
  });

  function renderPhotos(photos) {
    $("#slides").prepend(Handlebars.templates.photos({photos: photos}));
  }

  function renderPhotoInformation(photos, photoId) {
    var photo = photos.filter(function(photo) {
      return photo.id === photoId;
    })[0];

    var photoInformation = Handlebars.templates.photoInformation(photo);
    $("#photoFeedback > header").html(photoInformation);
  }

  function getCommentsFor(photoId) {
    $.ajax({
      url: "/comments",
      type: "GET",
      data: "photo_id=" + photoId,
      dataType: "json",
    }).done(function(json) {
      $("#photoFeedback > ul").html(Handlebars.templates.comments({comments: json}));
    });
  }
});
