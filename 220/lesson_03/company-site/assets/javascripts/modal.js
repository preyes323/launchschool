$(function() {
  $("#team a").click(function(e) {
    e.preventDefault();
    var $teamMember = $(this).next("div.modal");
    $(".modal-overlay").fadeIn("slow");
    $teamMember.fadeIn("slow");

  });
});
