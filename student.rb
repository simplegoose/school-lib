require_relative './person'

class Student < Person
  def initialize(classroom, age, parent_permission, name)
    super(age, parent_permission, name)
    @classroom = classroom
  
    @classroom.add_student(self)
  end

  def play_hooky
    '¯(ツ)/¯'
  end
end
