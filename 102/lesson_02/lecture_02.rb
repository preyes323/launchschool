class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    self.name = full_name
  end

  def name
    "#{first_name} #{last_name}"
  end

  def name=(full_name)
    name_parts = full_name.split
    self.first_name = name_parts.first
    self.last_name = name_parts.size > 1 ? name_parts.last : ''
  end
end

bob = Person.new('Paolo Reyes')

p bob.name
p bob.first_name
p bob.last_name
