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

  def correct_name
    @name
  end

  private

  def of_age?
    @age > 18
  end
end

class Decorator < Nameable
  attr_accessor :nameable

  def initialize(nameable)
    super()
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end

class CapitalizeDecorator < Decorator
  def correct_name
    @nameable.correct_name.upcase
  end
end

class TrimmerDecorator < Decorator
  def correct_name
    return unless @nameable.correct_name.length > 10

    @nameable.correct_name[0...10]
  end
end

person = Person.new(18, false, 'Alex Campaneer')
decorated_person = CapitalizeDecorator.new(person)
trimmed_person = TrimmerDecorator.new(person)

p decorated_person.correct_name
p trimmed_person.correct_name
