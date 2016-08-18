$(function() {
  var $canvas = $("#canvas");
  $("form").submit(function(e) {
    e.preventDefault();
    var $form = $(e.currentTarget);
    var data = getFormData($form);

    $canvas.append(createShape(data));
  });

  $("#start").on("click", function(e) {
    e.preventDefault();
    stopMovement();

    $canvas.find("div").each(function() {
      var $shape = $(this);
      var data = $shape.data();
      resetShapes($shape, data);
      $shape.animate({
        left: parseInt(data.endX, 10),
        top: parseInt(data.endY, 10),
      }, 1000);
    });
  });

  $("#stop").on("click", function(e) {
    stopMovement();
  })

  function resetShapes($shape, data) {
    $shape.css({
      left: parseInt(data.startX, 10),
      top: parseInt(data.startY, 10),
    });
  }

  function stopMovement() {
    $canvas.find("div").stop();
  }

  function getFormData(formObject) {
    var o = {};
    formObject.serializeArray().forEach(function(item) {
      o[item.name] = item.value;
    });

    return o;
  }

  function createShape(data) {
    return $("<div />", {
      "class": data.shape,
      data: data,
      css: {
        left: parseInt(data.startX, 10),
        top: parseInt(data.startY, 10),
      },
    });
  }
});
