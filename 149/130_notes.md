# Course 130 Notes

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

1. Defer implementation of code to method caller/invocation
  * When there different possible code that could be executed depending on a given condition
  * When it is defferd to a caller how certain input will be manipulated i.e. the `select` method
  * Can also be used to when a set methods have similar code. The similar code can be extracted out and the code that is different can be passed as block
2. Methods that need to perform some before and after actions "sandwich code"
  * A good use case is when testing how long a code executes
  * Another use case is when doing resource management (i.e making sure that a file is closed)

#### Methods with explicit block parameters

* passed as a parameter using the `&` ampersand.
```ruby
def test(&block)
  puts "What's &block? #{block}"
end
```

#### Blocks keep track of its binding - its surrounding context

* The block considers the code that was executed before it was used as a parameter for a method

#### Test

* Required gems
  * minitest
  * minitest-reporters
  * simplecov

* Program call statements to load test gems
  * simplecov (*must be called at the very top of the program*)
  * SimpleCov.start
  * minitest/autorun
  * minitest/reporters
  * minitest/spec (*when using spec*)
  * Minitest::Reporters.use!

* Key terms
  * **Test Suite** this is the entire set of tests that accompanies your program or application
  * **Test** this describes a situation or context in which tests are run
  * **Assertion** this is the actual verification step to confirm that the data returned by your program or application is indeed what is expected

* SEAT Approach
1. **S**etup the necessary objects
2. **E**xecute the code against the object we're testing
3. **A**ssert the results of the execution
4. **T**ear down and clean up any lingering artifacts
