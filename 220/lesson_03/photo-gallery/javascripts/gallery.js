$(function() {
  var $thumbs = $("ul a");
  var $figures = $("figure");

  function toggleThumbs(index) {
    $thumbs.toggleClass("active", false);
    $thumbs.eq(index).toggleClass("active");
  }

  function changeDisplayImage(index) {
    $figures.css("display", "none");
    $figures.eq(index).fadeIn("slow");
  }

  $("ul a").click(function(e) {
    e.preventDefault();

    var index = $thumbs.index(this);
    toggleThumbs(index);
    changeDisplayImage(index);
  });

  $(document).keydown(function(e) {
    var index = $figures.index($("figure:visible").get(0));
    if (e.which === 37) {
      if (index === 0) {
        index = 3;
      } else {
        index--;
      }
    } else if (e.which === 39) {
      if (index === 3) {
        index = 0;
      } else {
        index++;
      }
    } else {
      return;
    }

    toggleThumbs(index);
    changeDisplayImage(index);
  });
});
