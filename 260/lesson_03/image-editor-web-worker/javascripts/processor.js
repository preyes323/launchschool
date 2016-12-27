var workers = {
  inverter: new Worker("javascripts/inverter.js"),
  horiz_flipper: new Worker("javascripts/horiz_flipper.js"),
  vert_flipper: new Worker("javascripts/vert_flipper.js"),
  brightness: new Worker("javascripts/brightness.js"),
  saturation: new Worker("javascripts/saturation.js")
};

$(window).on("load", function() {
  var canvas = $("canvas").get(0),
      img = $("img").remove().get(0),
      ctx = canvas.getContext("2d"),
      last_data;

  canvas.width = img.width;
  canvas.height = img.height;
  ctx.drawImage(img, 0, 0);
  last_data = getData(ctx);

  for (var prop in workers) {
    workers[prop].addEventListener("message", function(message) {
      putData(ctx, message.data.image_data);
    });
  }

  $("#tools").on("click", "a", function(e) {
    e.preventDefault();
    var data = { image_data: getData(ctx) },
        worker = workers[$(e.target).attr("data-method")];

    worker.postMessage(data);
    worker.addEventListener("message", function(message) {
      last_data = message.data.image_data;
      worker.removeEventListener("message", message);
    });
  });

  $("input[type=range]").on("input", function() {
    var $e = $(this);

    $e.next("span").text($e.val() + "%");
    workers[$e.attr("name")].postMessage({
      image_data: last_data,
      param: $e.val()
    });
  });

  function getData(ctx) {
    return ctx.getImageData(0, 0, ctx.canvas.width, ctx.canvas.height);
  }

  function putData(ctx, data) {
    ctx.putImageData(data, 0, 0);
  }
});
