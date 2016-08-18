$(function() {
  var $canvas = $("#canvas");
  $("form").submit(function(e) {
    e.preventDefault();
    var $form = $(e.currentTarget);
    var data = getFormData($form);

    $canvas.append(createShape(data));
  });

  function getFormData(formObject) {
    var o = {};
    formObject.serializeArray().forEach(function(item) {
      o[item.name] = item.value;
    });

    return o;
  }
});
