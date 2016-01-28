# Notes for Assessment 109

### Local Variable Scope

* Local variables are not accessible to methods unless they are passed in as parameters

```ruby
my_text = "Hello World!"

def my_method
  puts my_text
end

my_method

# This produces an error: undefined local variable or method `my_text`
```

* Methods have their own scope!
* Blocks create an inner scope. It can make use of local variables declared from an outer scope.

```ruby
my_text = "Hello World!"

[1].each do |num|
  puts my_text
end
```

* An inner scope can reassign the value of a local variable declared in its outer scope.

```ruby
my_text = "Hello World!"

[1].each do |num|
  puts my_text
  my_text = "New World!"
end

puts my_text

=> New World!
```

* Local variables that are initialized in an inner scope are not accesible in its outer scope.

```ruby
[1].each do |num|
  my_text = "New World!"
end

puts my_text
# This produces an error: undefined local variable or method `my_text`
```

**Note:** Ruby does not make use of keywords to initialize variables. It is not so easy to determine if something is an initialization or reassignment.

### Method Arguments

* Ruby is not pass by value
* Ruby is not 100% pass by reference
* Ruby is pass by value/reference depending on the method called on the object
  * How methods used the parameter passed to it is *key*

Pass by value

```ruby
def append_wolrd(str)
    str += " World"
end

str = "Hello"

str_contact(" World")

puts str

=> "Hello"
```

Pass by reference

```ruby
def append_world(str)
    str << " World"
end

str = "Hello"

str_contact(" World")

puts str

=> "Hello World"
```
**Note:** Don't rely on side effects

### Block

* Variables in the block that are initialized in an outer scope always start fresh in the inner loop

```ruby
[1, 2, 3, 4, 5].times do |num|
  total_product ||= 1
  total_product *= num
  puts total_product
end

=> 1
=> 2
=> 3
=> 4
=> 5
```

### Collections

* each
* map
* inject
* reduce
* take_while
* select
* keep_if
* delete_if
* detect
