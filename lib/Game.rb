# frozen_string_literal: true

class Game
  def initialize(secret_word)
    @secret_word = secret_word
    @limbs = 6
    @secret_array = []
    @wrong_letters = ''
    @action_approved = false
    @letter = ''
    say_hi
  end

  def say_hi
    print "\n\nHowdy! Please type 'new' to start a new game, or 'load' to load your saved copy.\n\n"
    start_game
  end

  def start_game
    until @action_approved == true
      print '   : '
      action = gets.chomp.downcase
      if action == 'load'
        # code here..
        @action_approved = true
      elsif action == 'new'
        new_game
        @action_approved = true
      end
    end
  end

  def new_game
    @secret_array = @secret_word.split('')
    turn
  end

  def turn
    print "\nType in your letter of choice!\n\n"
    letter_approved = false
    until letter_approved == true
      print '   : '
      @letter = gets.chomp
      my_regex = /[a-z]/
      letter_approved = true if @letter.match(my_regex) && @letter.length == 1
    end
    checker
  end

  def checker
    if @secret_array.include? @letter
      correct_guess
    else
      incorrect_guess
    end
  end

  def correct_guess
    puts 'correct guess'
    finish
  end

  def incorrect_guess
    @limbs -= 1
    puts 'incorrect guess'
    finish
  end

  def finish
    if @limbs.zero?
      puts "You're done! You line has ended!"
    else
      turn
    end
  end
end