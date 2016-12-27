onmessage = function(app_data) {
  var data = app_data.data.image_data.data,
      cols = app_data.data.image_data.width,
      rows = app_data.data.image_data.height,
      new_row, current_row;

  for (var y = 0; y < rows; y++) {
    new_row = [];
    current_row = y * cols * 4;
    for (var x = current_row; x < current_row + cols * 4; x += 4) {
      new_row.push(data[x + 3]);
      new_row.push(data[x + 2]);
      new_row.push(data[x + 1]);
      new_row.push(data[x]);
    }

    new_row.reverse();

    for (var i = 0; i < new_row.length; i+= 4) {
      data[current_row + i] = new_row[i];
      data[current_row + i + 1] = new_row[i + 1];
      data[current_row + i + 2] = new_row[i + 2];
      data[current_row + i + 3] = new_row[i + 3];
    }
  }

  postMessage(app_data.data);
}
