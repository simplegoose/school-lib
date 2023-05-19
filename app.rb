require_relative './student'
require_relative './teacher'
require_relative './classroom'
require_relative './book'

class AppLogic
  def initialize
    @books = []
    @rentals = []
    @people = []
    @classrooms = []
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the option]: '
    option = gets.chomp

    case option
    when '1'
      create_student
    when '2'
      create_teacher
    end
  end

  def create_book
    print 'Enter title: '
    book_title = gets.chomp
    print 'Enter author: '
    book_author = gets.chomp

    book = Book.new(book_title, book_author)
    @books.push(book)
  end

  def create_rental
    if @books.length.positive? && @people.length.positive?
      book = select_book
      person = select_person

      puts ''
      print 'Enter date: '
      date = gets.chomp.strip

      rental = Rental.new(date, book, person)

      @rentals.push(rental)
    end

    puts 'Either of books of people does not exist, please add books or people to continue!'
  end

  def list_books
    @books.each_with_index { |element, index| puts "#{index}) Title: \"#{element.title}\", Author: #{element.author}" }
  end

  def list_people
    @people.each_with_index do |element, index|
      puts "#{index}) [#{element.class.name}] Name: \"#{element.name}\", ID: #{element.id}, Age: #{element.age}"
    end
  end

  def list_rentals
    print 'Please enter person\'s ID: '
    person_id = gets.chomp.to_i
    person = @people.find { |element| element.id == person_id }
    puts 'Rentals:'
    person.rentals.each do |rental|
      puts "Date: #{rental.date}, Book: \"#{rental.book.title}\" by #{rental.book.author}"
    end
  end

  def exit_app
    exit 1
  end

  private

  def create_teacher
    print 'Enter your name: '
    name = gets.chomp
    print 'Enter your age: '
    age = gets.chomp
    print 'Enter your specialization: '
    specialization = gets.chomp

    teacher = Teacher.new(specialization, age)
    teacher.name = name
    @people.push(teacher)
    puts "Person created successfully, person id is #{teacher.id}"
  end

  def create_student
    print 'Enter your name: '
    name = gets.chomp
    print 'Enter your age: '
    age = gets.chomp
    print 'Enter your classroom: '
    classroom_label = gets.chomp.strip
    print 'Has parent permission? [Y/N] '
    permission = gets.chomp
    is_ermitted = permission.downcase == 'y'

    classroom_exists = @classrooms.any? { |classroom| classroom.label == classroom_label.upcase }
    classroom = if classroom_exists
                  @classrooms.grep { |classroom| classroom.label == classroom_label.upcase }
                else
                  Classroom.new(classroom_label.upcase)
                end
    student = Student.new(classroom, age, is_ermitted, name)

    @people.push(student)
    puts "Person created successfully, person id is #{student.id}"
  end

  def select_book
    puts 'Select book from the following list by number'
    @books.each_with_index do |element, index|
      puts "#{index}) Title: \"#{element.title}\", Author: #{element.author}"
    end
    book_index_string = gets.chomp
    book_index = book_index_string.to_i

    @books[book_index]
  end

  def select_person
    puts ''
    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |element, index|
      puts "#{index}) [#{element.class.name}] Name: \"#{element.name}\", ID: #{element.id}, Age: #{element.age}"
    end
    person_index_string = gets.chomp
    person_index = person_index_string.to_i

    @people[person_index]
  end
end
