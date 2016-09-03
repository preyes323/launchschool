$(document).ready(function() {
  Handlebars.partials = Handlebars.templates;
  var photos;

  var slideShow = {
    getSlideDetails: function() {
      return {
        $currentPhoto: $("#slides figure:visible"),
        photosCount: $("#slides figure").length,
        id: $("#slides figure:visible").data("id"),
      };
    },
    getNextPhoto: function(id, count) {
      if (id + 1 > count) {
        return $("#slides figure[data-id=1]");
      } else {
        return $("#slides figure[data-id=" + ++id + "]");
      }
    },
    getPrevPhoto: function(id, count) {
      if (id - 1 < 1) {
        return $("#slides figure[data-id=" + count + "]");
      } else {
        return $("#slides figure[data-id=" + --id + "]");
      }
    },
    nextSlide: function(e) {
      e.preventDefault();
      var slide = this.getSlideDetails();
      var $nextPhoto = this.getNextPhoto(slide.id, slide.photosCount);
      slide.$currentPhoto.fadeOut();
      $nextPhoto.fadeIn();
      this.loadPhotoInformation(slide.id);
    },
    prevSlide: function(e) {
      e.preventDefault();
      var slide = this.getSlideDetails();
      var $prevPhoto = this.getPrevPhoto(slide.id, slide.photosCount);
      slide.$currentPhoto.fadeOut();
      $prevPhoto.fadeIn();
      this.loadPhotoInformation(slide.id);
    },
    loadPhotoInformation: function(id) {
      renderPhotoInformation(id);
      getCommentsFor(id);
    },
    bind: function() {
      $("#slides .prev").on("click", $.proxy(this.prevSlide, this));
      $("#slides .next").on("click", $.proxy(this.nextSlide, this));
    },
    init: function() {
      this.bind();
    },
  };

  $.ajax({
    url: "/photos",
    type: "GET",
    dataType: "json",
  }).done(function(json) {
    photos = json;
    renderPhotos();
    renderPhotoInformation(photos[0].id);
    getCommentsFor(photos[0].id);
    slideShow.init();
  });

  $("#photoFeedback > header").on("click", ".actions a", function(e) {
    e.preventDefault();
    var $element = $(e.target);
    var id = $element.data("id");
    var photo = photos.filter(function(photo) {
      return photo.id === id;
    })[0];

    $.ajax({
      url: $element.attr("href"),
      type: "POST",
      data: "photo_id=" + id,
      dataType: "json",
    }).done(function(json) {
      $element.text(function(idx, txt) {
        return txt.replace(/\d+/, json.total);
      });
      photo[$element.attr("data-property")] = json.total;
    });
  });

  $("form").on("submit", function(e) {
    e.preventDefault();
    var $form = $(this);
    var id = $("slides figure:visible").attr("data-id");
    var formData = $form.serialize().replace(/\d+/, id);

    $.ajax({
      url: $form.attr("action"),
      type: $form.attr("method"),
      data: formData,
      dataType: "json"
    }).done(function(json) {
      $("#photoFeedback ul").append(Handlebars.templates.comment(json));
    });

    $form.get(0).reset();
  });

  function renderPhotos() {
    $("#slides").prepend(Handlebars.templates.photos({photos: photos}));
  }

  function renderPhotoInformation(photoId) {
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
