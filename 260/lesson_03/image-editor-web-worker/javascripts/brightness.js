onmessage = function(app_data) {
  var data = app_data.data.image_data.data,
      b = Math.floor(255 * +app_data.data.param / 100);

  for (var i = 0, len = data.length; i < len; i += 4) {
    data[i] += b;
    data[i + 1] += b;
    data[i + 2] += b;
  }

  postMessage(app_data.data);
};
