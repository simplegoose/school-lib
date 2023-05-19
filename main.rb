#!/usr/bin/env ruby
require_relative './app'

class App
  def initialize
    @app_logic = AppLogic.new
  end

  def run
    menu
  end

  def run_option(user_selected_option)
    puts
    options = {
      '1' => :list_books,
      '2' => :list_people,
      '3' => :create_person,
      '4' => :create_book,
      '5' => :create_rental,
      '6' => :list_rentals,
      '7' => :exit_app
    }

    if options[user_selected_option]
      @app_logic.send(options[user_selected_option])
    else
      print 'Please enter a valid option: '
      valid_option = gets.chomp
      run_option(valid_option)
    end

    menu
  end

  def menu
    puts ''
    puts 'Welcome to school library app!'
    puts 'Please choose an option by entering a number'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'

    print 'Your option: '
    option = gets.chomp

    run_option(option)
  end
end

def main
  app = App.new

  app.run
end

main
