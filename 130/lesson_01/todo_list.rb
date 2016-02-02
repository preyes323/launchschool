require 'pry'
# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description = '')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo)
    raise TypeError, 'Can only add Todo objects' unless todo.instance_of? Todo
    @todos << todo
  end

  alias_method :<<, :add

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def item_at(index = nil)
    raise ArgumentError unless index
    @todos.fetch(index)
  end

  def mark_done_at(index)
    item_at(index).done!
  end

  def mark_undone_at(index = nil)
    item_at(index).undone!
  end

  def done?
    @todos.all?(&:done?)
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index = nil)
    @todos.delete(item_at(index))
  end

  def to_s
    result = "---- #{title} ----\n"
    result << @todos.map(&:to_s).join("\n")
  end

  def each
    counter = 0

    while counter < @todos.size
      yield(@todos[counter])
      counter += 1
    end

    self
  end

  def select
    new_list = TodoList.new(title)

    each do |todo|
      new_list << todo if yield(todo)
    end

    new_list
  end

  def find_by_title(todo_title)
    each { |todo| return todo if todo.title == todo_title }
    nil
  end

  def all_done
    select(&:done?)
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(todo_title)
    find_by_title(todo_title) &&  find_by_title(todo_title).done!
  end

  def mark_all_done
    each(&:done!)
  end

  def mark_all_undone
    each(&:undone!)
  end
end
