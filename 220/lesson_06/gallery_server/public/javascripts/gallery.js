$(document).ready(function() {
  $.ajax({
    url: "/photos",
    type: "GET",
    dataType: "json",
  }).done(function(json) {
    var photos = json;
    renderPhotos(photos);
    renderPhotoInformation(photos, photos[0].id);
  });

  function renderPhotos(photos) {
    $("#slides").prepend(Handlebars.templates.photos({photos: photos}));
  }

  function renderPhotoInformation(photos, photoId) {
    var photoInformation = Handlebars.templates.photoInformation(photos[photoId]);
    $("#photoFeedback > header").html(photoInformation);
  }
});
