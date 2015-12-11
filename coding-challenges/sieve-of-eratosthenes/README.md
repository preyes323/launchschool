# Sieve of Eratosthenes

### Challenge exercise of [gotealeaf](www.gotealeaf.com).
#### Time Limit: 45 mins


Challenge details:
Write a program that uses the Sieve of Eratosthenes to find all the primes from 2 up to a given number.

The Sieve of Eratosthenes is a simple, ancient algorithm for finding all prime numbers up to any given limit. It does so by iteratively marking as composite (i.e. not prime) the multiples of each prime, starting with the multiples of 2.

Create your range, starting at two and continuing up to and including the given limit. (i.e. [2, limit]).

The algorithm consists of repeating the following over and over:

take the next available unmarked number in your list (it is prime)
mark all the multiples of that number (they are not prime)
Repeat until you have processed each number in your range. When the algorithm terminates, all the numbers in the list that have not been marked are prime. The wikipedia article has a useful graphic that explains the algorithm: https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes

Notice that this is a very specific algorithm, and the tests don't check that you've implemented the algorithm, only that you've come up with the correct list of primes.

### Challenge Results

* Initial Working Model - Completed: ~25 mins; Test Run Time: 0.003504s, 570.7984 runs/s, 570.7984 assertions/s.
* Refactored Working Model - Completed: 45 mins; Test Run Time: 0.004674s, 427.8676 runs/s, 427.8676 assertions/s.
