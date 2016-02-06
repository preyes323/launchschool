# Course 120 Notes

[**Classes and Objects**](http://www.rubyfleebie.com/3-steps-to-understand-how-classes-and-objects-work-in-ruby/)

* classes are the blueprints for objects
  * classes provide the defintion of what states and behaviors an object can have and perfrom
* classes are also objects
  * a look at the #ancestors of class shows that it is derived from an Object class
  * `Class.is_a? Object` `=> true`
* every class defined is an **instance** of a class named Class
  * the class of a class is Class
```ruby
String.instance_of? Class     # => true
String.is_a? Class            # => true
String.instance_of? Object    # => false
String.is_a? Object           # => true

my_string = String.new("Paolo")
my_string.is_a? Object        # => true
my_string.instance_of? Class  # => flase
my_string.instance_of? Object # => false
my_string.is_a? Class         # => false
my_string.is_a? String        # => true
my_string.instance_of? String # => true
```
* every class is an Object
* everyone can modify a class structure
  * since everything is an object, even what `strings` can do can be modified by editing its blueprint; its `class`
* everything in ruby is an object
  * i.e. : result = 5 + 2
    * 5 is a `Fixnum`
    * + is a method of a `Fixnum`
    * result will become a `Fixnum`

**Inheritance**

*class-based*

* works best when used to model hierarchical domains
* can use `method lookup path` to see order in which Ruby will traverse the class hierarchy to look for methods to invoke.
  * see the lookup path by calling the `#ancestors` method on a class object.

*module-based*