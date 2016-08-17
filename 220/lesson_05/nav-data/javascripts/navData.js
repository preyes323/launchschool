$(function() {
  $("nav ul a").on("click", function(e) {
    e.preventDefault();

    $("article").finish()
    $("article").fadeOut("fast").delay(200).filter("[data-block=" + $(this).data("block") + "]").fadeIn("slow");
  });
});
