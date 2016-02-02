require 'minitest/spec'
require 'minitest/autorun'
require_relative 'todo_list'

describe TodoList do
  attr_reader :todo1, :todo2, :todo3, :list, :populated_list

  before do
    @todo1 = Todo.new('Buy milk')
    @todo2 = Todo.new('Clean room')
    @todo3 = Todo.new('Go to gym')
    @list = TodoList.new("Today's Todos")
    @populated_list = TodoList.new("Today's Todos")
    @populated_list << @todo1 << @todo2 << @todo3
  end

  describe '#add' do
    it 'must add an item to the list' do
      list.add(todo1).must_equal [todo1]
    end

    it 'must add the additional items to the end of the list' do
      list.add(todo1).must_equal [todo1]
      list.add(todo2).must_equal [todo1, todo2]
      list.add(todo3).must_equal [todo1, todo2, todo3]
    end

    it 'must raise a TypeError if a non-todo object is passed as parameter' do
      proc { list.add(1) }.must_raise TypeError
    end
  end

  describe '#<<' do
    it 'must add an item to the list' do
      (list << todo1).must_equal [todo1]
    end

    it 'must add the additional items to the end of the list' do
      (list << todo1).must_equal [todo1]
      (list << todo2).must_equal [todo1, todo2]
      (list << todo3).must_equal [todo1, todo2, todo3]
    end

    it 'must raise a TypeError if a non-todo object is passed as parameter' do
      proc { list << 1 }.must_raise TypeError
    end
  end

  describe '#size' do
    it 'must return the correct number of items in the list' do
      populated_list.size.must_equal 3
    end
  end

  describe '#first' do
    it 'must return the first item in the list' do
      populated_list.first.must_equal todo1
    end
  end

  describe '#last' do
    it 'must return the last item in the list' do
      populated_list.last.must_equal todo3
    end
  end

  describe '#done?' do
    it 'must return true if all Todos are done' do
      todo1.done!
      todo2.done!
      todo3.done!
      assert populated_list.done?
    end

    it 'must return false if not att Todo are done' do
      todo1.done!
      todo2.done!
      refute populated_list.done?
    end
  end

  describe '#item_at' do
    it 'must raise an ArgumentError' do
      proc { populated_list.item_at }.must_raise ArgumentError
    end

    it 'must return the correct Todo based on the index provided' do
      populated_list.item_at(1).must_equal todo2
    end

    it 'must raise an index error' do
      proc { populated_list.item_at(100) }.must_raise IndexError
    end
  end

  describe '#mark_done_at' do
    it 'must raise an ArgumentError' do
      proc { populated_list.mark_done_at }.must_raise ArgumentError
    end

    it 'must mark the correct Todo based on the index provided' do
      populated_list.mark_done_at(1).must_equal todo2.done!
    end

    it 'must raise an index error' do
      proc { populated_list.mark_done_at(100) }.must_raise IndexError
    end
  end

  describe '#mark_undone_at' do
    it 'must raise an ArgumentError' do
      proc { populated_list.mark_undone_at }.must_raise ArgumentError
    end

    it 'must mark the correct Todo based on the index provided' do
      populated_list.mark_undone_at(1).must_equal todo2.undone!
    end

    it 'must raise an index error' do
      proc { populated_list.mark_undone_at(100) }.must_raise IndexError
    end
  end

  describe '#shift' do
    it 'must remove and return the first item in the list' do
      populated_list.shift.must_equal todo1
    end
  end

  describe '#pop' do
    it 'must remove and return the last item in the list' do
      populated_list.pop.must_equal todo3
    end
  end

  describe '#remove_at' do
    it 'must raise an ArgumentError' do
      proc { populated_list.remove_at }.must_raise ArgumentError
    end

    it 'must mark the correct Todo based on the index provided' do
      populated_list.remove_at(1).must_equal todo2
    end

    it 'must raise an index error' do
      proc { populated_list.remove_at(100) }.must_raise IndexError
    end
  end

  describe '#to_s' do
    it 'must return a string representation of the list' do
      string_rep = %(---- Today's Todos ----
[ ] Buy milk
[X] Clean room
[ ] Go to gym)

      todo2.done!
      populated_list.to_s.must_equal string_rep
    end
  end

  describe '#each' do
    it 'must return every todo object in the Todo List' do
      items = [todo1, todo2, todo3]
      index = 0

      populated_list.each do |list_todo|
        list_todo.must_equal items[index]
        index += 1
      end
    end

    it 'must return a list after running the each method' do
       populated_list.each { |_| 'do something' }.must_equal populated_list
    end
  end

  describe '#select' do
    it 'must return the correct todo items based on the given block' do
      todo2.done!

      new_list = populated_list.select(&:done?)

      new_list.each { |todo| todo.must_equal todo2 }
    end

    it 'must return a new TodoList object after running the select' do
      todo2.done!

      new_list = populated_list.select { |todo| todo.done? }

      assert new_list.instance_of?(TodoList) &&
             new_list.object_id != populated_list.object_id
    end
  end

  describe '#find_by_title' do
    it 'must return the first Todo object that matches the argument' do
      populated_list.find_by_title('Buy milk').must_equal todo1
    end

    it 'must return nil if no todo is found' do
      populated_list.find_by_title('Play game').must_be_nil
    end
  end

  describe '#all_done' do
    it 'must return all todos that are marked done' do
      todo1.done!
      todo2.done!
      index = 0

      done_items = [todo1, todo2]
      new_list = populated_list.all_done

      new_list.each do |todo|
        todo.must_equal done_items[index]
        index += 1
      end
    end
  end

  describe '#all_not_done' do
    it 'must return all todos that are marked undone' do
      todo2.done!
      index = 0

      done_items = [todo1, todo3]
      new_list = populated_list.all_not_done

      new_list.each do |todo|
        todo.must_equal done_items[index]
        index += 1
      end
    end
  end

  describe '#mark_done' do
    it 'must mark the first Todo object that matches the argument as done' do
      populated_list.mark_done(todo1.title)
      assert todo1.done?
    end
  end

  describe '#mark_all_done' do
    it 'must mark every todo as done' do
      populated_list.mark_all_done
      populated_list.each { |todo| assert todo.done? }
    end
  end

  describe' #mark_all_undone' do
    it 'must mark every todo as not done' do
      populated_list.mark_all_undone
      populated_list.each { |todo| refute todo.done? }
    end
  end
end
