onmessage = function(app_data) {
  var data = app_data.data.image_data.data,
      cols = app_data.data.image_data.width,
      rows = app_data.data.image_data.height,
      new_rows = [], current_col;

  for (var y = 0; y < rows; y++) {
    new_rows.push([]);
    current_col = y * cols * 4;
    for (var x = current_col; x < current_col + cols * 4; x++) {
      new_rows[y].push(data[x]);
    }
  }

  new_rows.reverse();

  new_rows.forEach(function(row, y) {
    row.forEach(function(i, x) {
      data[y * cols * 4 + x] = i;
    });
  });

  postMessage(app_data.data);
}
