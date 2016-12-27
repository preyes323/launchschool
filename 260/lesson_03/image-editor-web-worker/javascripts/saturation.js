onmessage = function(app_data) {
  var data = app_data.data.image_data.data,
      s = +app_data.data.param * -.01,
      max,
      saturate = function(val) {
        return val === max ? 0 : (max - val) * s;
      };

  for (var i = 0, len = data.length; i < len; i += 4) {
    max = Math.max(data[i], data[i + 1], data[i + 2]);
    data[i] += saturate(data[i]);
    data[i + 1] += saturate(data[i + 1]);
    data[i + 2] += saturate(data[i + 2]);
  }

  postMessage(app_data.data);
};
