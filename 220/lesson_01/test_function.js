var scores = [[2, 8, 5], [12, 48, 0], [12]];

function uniqueElements(values) {
  result = []

  function elementExists(element, arry) {
    var exists = false;

    for(var i = 0; i < arry.length; i++) {
      if (element == arry[i]) { exists = true ; break; }
    }
    return exists
  }

  for(var i = 0; i < values.length; i++) {
    if (!elementExists(values[i], result)) {
      result.push(values[i]);
    }
  }

  return result
}

console.log(uniqueElements([1, 2, 4, 3, 4, 1, 5, 4]));
