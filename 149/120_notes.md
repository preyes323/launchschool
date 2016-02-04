# Course 120 Notes

[**Classes and Objects**](http://www.rubyfleebie.com/3-steps-to-understand-how-classes-and-objects-work-in-ruby/)

* classes are the blueprints for objects
  * classes provide the defintion of what states and behaviors an object can have and perfrom
* classes are also objects
  * a look at the #ancestors of class shows that it is derived from an Object class
* every class defined is an **instance** of a class named Class
  * the class of a class is Class
* everyone can modify a class structure
  * since everything is an object, even what `strings` can do can be modified by editing its blueprint; its `class`
* everything in ruby is an object
  * i.e. : result = 5 + 2
    * 5 is a `Fixnum`
    * + is a method of a `Fixnum`
    * result will become a `Fixnum`