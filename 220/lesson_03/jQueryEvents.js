$(function() {
  $("form").submit(function(e) {
    e.preventDefault();
    var key = $(this).find("input[type='text']").val().charCodeAt(0);

    $(document).off("keypress").on("keypress", function(e) {
      if (e.which != key) {
        return;
      } else {
        $("a").trigger("click");
      }
    });
  });

  $("a").click(function(e) {
    e.preventDefault();
    $("#accordion").slideToggle();
  });
});
