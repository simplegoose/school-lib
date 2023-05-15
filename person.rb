class Person
  def initialize(
    age, 
    parent_permission = true,
    name = "Unknown"
  )
    @age = age
    @id = Random.rand(1...1000)
    @name = name
    @parent_permission = parent_permission
  end

  attr_accessor :name
  attr_accessor :age
  attr_reader :id

  def can_use_services?
    self.of_age?
  end

  private
  
  def of_age?
    @age > 18
  end

end
