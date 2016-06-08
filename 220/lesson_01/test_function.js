

var number_array = [1, 2, 3, 4, 5];
console.log(average(number_array));

fizzbuzz([1, 2, 3, 4, 5, 6, 15]);

function average(numbers) {
  return sum(numbers) / numbers.length;
}

function sum(numbers) {
  var total = 0;

  for (var i in numbers) {
    total += numbers[i];
  }

  return total
}

function fizzbuzz(numbers) {
  for (var i in numbers) {
    if (numbers[i] % 5 == 0 && numbers[i] % 3 == 0) {
      console.log("fizzbuzz");
    } else if (numbers[i] % 5 == 0) {
      console.log("buzz");
    } else if (numbers[i] % 3 == 0) {
      console.log("fizz");
    } else {
      console.log(numbers[i]);
    }
  }
}

function random(max) {
  return Math.floor(Math.random() * max) + 1;
}
