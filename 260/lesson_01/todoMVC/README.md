### General Requirements

Build a todo app using the following [HTML and CSS](http://d3905n0khyu9wc.cloudfront.net/todo_app/todo_app.zip) as starting point*. The todo app will use the MVC framework that was built earlier in the course.

Here's a link to the course page for the [complete requirements document](https://launchschool.com/lessons/fae4fa27/assignments/4953c85b).

**I'll use precompiled Handlebars templates instead of creating during runtime. I won't be using jQuery also.*

### Specific Requirements

* Typing in a todo and submitting the form creates a new todo item
* Clicking the check box for a todo toggles its completed state
* Clicking the text for the todo toggles editing for that todo
* Clicking outside of the text input for a currently editing todo saves the edit
* Clicking clear complete will find all completed todos and remove them

### Requirements Analysis

#### Typing in a todo and submitting the form creates a new todo item

*Input: Text*

Things to consider:
* Where is text input?
* Are there valid inputs?
* Invalid?
* Input length?

*Output: Todo Item*

Things to consider:
* Recipient/s of output?
  * What does recipient do with it
* Data structure of todo item
* Format of todo item

*Model: MVC responsibilities*

* Model: Store the todo item, trigger change event for when new todo is received
* View/Controller: Render the data for the new todo, modifying any existing list

---
#### Clicking the check box for a todo toggles its completed state

*Input: Click event*

Things to consider:
* Does it have to be the checkbox only? Can it be the label?
* Where to put the click event

*Output: Changed todo item state*

Things to consider:
* How is state represented
* How is it rendered/displayed

*Model: MVC responsibilities*

* Model: Update state
* View/Controller: Render todo-item based on state after toggling

---
#### Clicking the text for the todo toggles editing for that todo

Things to consider:
* How to differentiate from text box click event

---
#### Clicking outside of the text input for a currently editing todo saves the edit

Things to consider:
* How to differentiate from text box click event
* What event to use - blur?

---
#### Clicking clear complete will find all completed todos and remove them

Things to consider:
* Create change event that removes view once model is removed



