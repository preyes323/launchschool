$(document).ready(function() {
  var answer = Math.floor(Math.random() * (100)) + 1;

  $("form").on("submit", function(e) {
    e.preventDefault();
    var guess = parseInt($("input[type='text']").val(), 10);
    var msg;

    if (guess === answer) {
      msg = 'You have guessed correctly!';
    } else if (guess < answer) {
      msg = 'Your guess of ' + guess + ' is lower, guess higher!';
    } else {
      msg = 'Your guess of ' + guess + ' is higher, guess lower!';
    }

    $("p").text(msg);
  });

  $("a").on("click", function(e) {
    e.preventDefault();
    answer = Math.floor(Math.random() * 100) + 1;
    $("p").text("Guess a number from 1 to 100");
  });
});
