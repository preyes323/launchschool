$(document).ready(function() {
  $("form").submit(function(e) {
    e.preventDefault();

    var num1 = $("input[type='text']:first-of-type").val();
    var num2 = $("input[type='text']:last-of-type").val();
    var operator = $("select").val();
    var result = computeValue(num1, num2, operator);

    $("h1").text(result.toFixed(2));
  });
});

function computeValue(num1, num2, operator) {
  var value1 = parseFloat(num1, 10);
  var value2 = parseFloat(num2, 10);
  var result;

  switch (operator) {
  case '+':
    result = value1 + value2;
    break;
  case '-':
    result = value1 - value2;
    break;
  case '*':
    result = value1 * value2;
    break;
  default:
    result = value1 / value2;
  }

  return result;
}
