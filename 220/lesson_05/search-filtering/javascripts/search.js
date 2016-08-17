$(function() {
  $(".sidebar input:checkbox").change(function(e) {
    e.preventDefault();

    var category = $(this).data("category");
    var checked = this.checked;

    if (checked) {
      $("li").filter("[data-category*='" + category +"']").show();
    } else {
      $("li").filter("[data-category*='" + category +"']").hide();
    }
  });

  $("button").click(function(e) {
    e.preventDefault();
    var term = $("input[type='text']").val();
    var pattern = new RegExp($("input[type='text']").val(), 'gi');
    if (term) {
      $("article li").each(function(item) {
        if (!$("article li").eq(item).text().match(pattern)) {
          $("article li").eq(item).hide();
        }
      });
    } else {
      $("li").show();
    }
  });
});
