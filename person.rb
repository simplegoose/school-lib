class Nameable
  def correct_name
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class Person < Nameable
  def initialize(
    age,
    parent_permission = true,
    name = 'Unknown'
  )
    super()
    @age = age
    @id = Random.rand(1...1000)
    @name = name
    @parent_permission = parent_permission
  end

  attr_accessor :name, :age
  attr_reader :id

  def can_use_services?
    of_age?
  end

  private

  def of_age?
    @age > 18
  end
end

class Decorator < Person
  def initialize(person)
    super
    @person = person
  end

  def correct_name
    @person.name
  end
end

class CapitalizeDecorator < Decorator
  def correct_name
    @person.name.upcase
  end
end

class TrimmerDecorator < Decorator
  def correct_name
    @person.name[0...10]
  end
end

person = Person.new(18, false, 'Alex Campaneer')
decorated_person = CapitalizeDecorator.new(person)
trimmed_person = TrimmerDecorator.new(person)

p decorated_person.correct_name
p trimmed_person.correct_name
