# frozen_string_literal: true

require_relative 'drawings'

class Game
  include Drawings
  def initialize(secret_word)
    @secret_word = secret_word
    @hung_limbs = 0
    @secret_array = []
    @built_word = []
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
      print '      : '
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
    @built_word = @secret_array.map { |_letter| letter = '_' }
    turn
  end

  def turn
    print "\nType in your letter of choice!\n\n"
    letter_approved = false
    until letter_approved == true
      print '      : '
      @letter = gets.chomp.downcase
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
    puts "\ncorrect guess\n\n"
    add_letter
  end

  def add_letter
    @secret_array.each_with_index do |letter, ind|
      @built_word[ind] = @letter if letter == @letter
    end

    print ' Word : '
    puts @built_word.join(' ')
    picture
  end

  def incorrect_guess
    @hung_limbs += 1
    puts "\nincorrect guess\n\n"
    print '  Word: '
    puts @built_word.join(' ')
    picture
  end

  def picture
    case @hung_limbs
    when 0
      scene_0
    when 1
      scene_1
    when 2
      scene_2
    when 3
      scene_3
    when 4
      scene_4
    when 5
      scene_5
    when 6
      scene_6
    end
    finish
  end

  def finish
    if @hung_limbs == 6
      puts "You're done! You line has ended!\n\n"
    elsif @built_word.join == @secret_word
      puts "You won boi!!\n\n"
    else
      turn
    end
  end
end
