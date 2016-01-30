class School
  attr_accessor :students

  def initialize
    self.students = Hash.new([])
  end

  def add(name, grade_level)
    self.students[grade_level] += [name]
  end

  def grade(grade_level)
    students[grade_level]
  end

  def to_h
    students.each { |_, names| names.sort! }.sort.to_h
  end
end
