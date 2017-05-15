require 'pg'
class DatabasePersistence # :nodoc:
  def initialize
    @db = PG.connect dbname: 'todos'
  end

  def data
    sql = 'SELECT * FROM lists;'
    result = query sql
    result.map do |tuple|
      { id: tuple['id'].to_i, name: tuple['name'], todos: todos(tuple['id']) }
    end
  end

  def find_list(id)
    data.find { |list| list[:id] == id }
  end

  def name_exists?(name)
    data.any? { |list| list[:name] == name }
  end

  def add_list(list)
    sql = 'INSERT INTO lists (name) VALUES ($1);'
    query sql, list
  end

  def delete_list(id)
    sql = 'DELETE FROM lists WHERE id = $1'
    query sql, id
  end

  def update_list(id, name)
    sql = 'UPDATE lists SET name = $1 WHERE ID = $2'
    query sql, name, id
  end

  def add_todo(id, todo)
    sql = 'INSERT INTO todo (list_id, name) VALUES ($1, $2)'
    query sql, id, todo
  end

  def delete_todo(todo_id)
    sql = 'DELETE FROM todo WHERE id = $1'
    query sql, todo_id
  end

  def update_todo(todo_id, status)
    sql = 'UPDATE todo SET completed = $1 WHERE id = $2;'
    query sql, status, todo_id
  end

  def complete_all_todos(list_id)
    sql = 'UPDATE todo SET completed = true WHERE list_id = $1;'
    query sql, list_id
  end

  private

  def query(query_string, *args)
    args.empty? ? @db.exec(query_string) : @db.exec_params(query_string, args)
  end

  def todos(list_id)
    sql = 'SELECT * FROM todo WHERE list_id = $1'
    result = query sql, list_id
    result.map do |tuple|
      {
        id: tuple['id'].to_i,
        name: tuple['name'],
        completed: tuple['completed'] == 't'
      }
    end
  end
end
