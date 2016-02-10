# Course 120 Notes

#### Blocks

* blocks are code that begin with either the following:
  * `do ... end`
  * `{ ... }`
* block code example
```ruby
[1, 2, 3].each do |num|
  puts num
end

[1, 2, 3] # Array object
.each     # called on the array object; Array#each
do |num|  # block
  puts num
end
```
* block are parameters that are passed to methods
  * the method could either use the block (chunk) of code or not
  * every method can take an **optional** block as a parameter**
```ruby
def hello
  puts 'hello'
end

hello { puts 'hi' }  # hello
```
* Yield allows for methods to invoke blocks

#### Yielding

**Sample Code**
```ruby
def with_yield(str)
  yield
  puts str
end

with_yield('Paolo') { puts 'hello ' } # hello Paolo
```
* a method with a `yield` statement will raise a `LocalJumpError` if no block is given
  * a `block_given?` method can be used to allow for methods to work even if no block is passed
```ruby
def with_yield(str)
  yield if block_given?
  puts str
end
```
* code in passed-in block can be much longer than the method

#### Yielding with argument

* a `yield` can accept argument[s]
* blocks have a lenient `arity` (number of arguments called on a closure)
  * passing less than the block expects
```ruby
def test
  yield(1)
end

test do |num1, num2|
  puts "#{num1} #{num2}"   # "1 "  - quotes put for emphasis
end
```
  * passing more than the block expects
```ruby
def test
  yield(1, 2)
end

test do |num1|
  puts num1      # 1 - the block ignored the extra argument
end
```
* yielding to block also has a return value
  * return value is similar to methods.
  * the last expression is returned

#### When to use blocks

1 as
2 asd