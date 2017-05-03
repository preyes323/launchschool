class SessionPersistence # :nodoc:
  attr_reader :data

  def initialize(session)
    @data = session[:lists] || []
  end

  def find_list(id)
    data.find { |list| list[:id] == id }
  end

  def name_exists?(name)
    data.any? { |list| list[:name] == name }
  end

  def add_list(list)
    list[:id] = next_element_id(data)
    data << list
  end

  def delete_list(id)
    data.reject! { |list| list[:id] == id }
  end

  def update_list(id, name)
    list = find_list id
    list[:name] = name
  end

  def add_todo(id, todo)
    list = find_list id
    todo[:id] = next_element_id(list[:todos])
    list[:todos] << todo
  end

  def delete_todo(list_id, todo_id)
    list = find_list list_id
    list[:todos].reject! { |todo| todo[:id] == todo_id }
  end

  def update_todo(list_id, todo_id, status)
    list = find_list list_id
    todo = list[:todos].find { |todo| todo[:id] == todo_id }
    todo[:completed] = status
  end

  def complete_all_todos(list_id)
    list = find_list list_id
    list[:todos].each do |todo|
      todo[:completed] = true
    end
  end

  private

  def next_element_id(elements)
    max = elements.map { |todo| todo[:id] }.max || 0
    max + 1
  end
end
