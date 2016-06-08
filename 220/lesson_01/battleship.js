var location1 = 3,
    location2 = 2,
    location3 = 4,
    guesses = 0,
    hits = 0;
    is_sunk = false;

var guess;

while (!is_sunk) {
  guess = prompt("Ready, aim, fire! (enter a number 0-6):");
  if (guess < 0 || guess > 6 ) {
    alert("Please enter a valid cell number!");
  } else {
    guesses = guesses + 1;
    if (guess == location1 || guess == location2 || guess == location3) {
      alert("HIT!");
      hits = hits + 1;
      if (hits == 3) {
        is_sunk = true;
        alert("You've sunk my ship!");
      }
    } else {
      alert("MISS!");
    }
  }
}

var stats = "You took " + guesses + " to sink the ship. You're accuracy is " + (3/guesses);
alert(stats);
