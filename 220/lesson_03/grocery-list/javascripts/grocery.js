$(document).ready(function() {
  $("form").submit(function(e) {
    e.preventDefault();

    var $form = $(this);
    var $item = $form.find("#itemName");
    var $qty = $form.find("#quantity");
    var qty = $qty.val() || '1';

    $("ul").append("<li>" + qty + ' ' +  $item.val() + "</li>");
    $form.get(0).reset();
  });
});
