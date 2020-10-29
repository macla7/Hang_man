# frozen_string_literal: true

require_relative 'drawings'
require_relative 'Save_Load'

class Game
  include Drawings
  include SaveLoad
  def initialize(secret_word)
    @secret_word = secret_word
    @hung_limbs = 0
    @secret_array = []
    @built_word = []
    @wrong_letters = ''
    @action_approved = false
    @letter = ''
    @begining = true
    start_game
  end

  def start_game
    until @action_approved == true
      system('clear')
      print "\n\nHowdy! Please type 'new' to start a new game, or 'load' to load your saved copy.\n\n"
      print '      : '
      action = gets.chomp.downcase
      system('clear')
      if action == 'load'
        if File.exist? 'hangman_save.yml'
          load_game
        else
          puts 'file doesn\'t exist'
        end
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
    print "\nType in your letter of choice!\nType 'save' anytime to save the game and come back to it later on!\n\n"
    letter_approved = false
    until letter_approved == true
      print '      : '
      @letter = gets.chomp.downcase
      my_regex = /[a-z]/
      letter_approved = true if @letter.match(my_regex) && @letter.length == 1
      letter_approved = true if @letter == 'save'
    end
    checker
  end

  def checker
    system('clear')
    if @letter == 'save'
      puts "\n\n Thanks for playing, come back and start where you left off at anytime! *whisphers* coward\n\n"
      def_game_state
    elsif (@wrong_letters.include? @letter) || (@built_word.include? @letter)
      puts "\nYou already guessed #{@letter}!\n\n"
      turn
    elsif @secret_array.include? @letter
      correct_guess
    else
      incorrect_guess
    end
  end

  def correct_guess
    @secret_array.each_with_index do |letter, ind|
      @built_word[ind] = @letter if letter == @letter
    end
    picture
  end

  def incorrect_guess
    @hung_limbs += 1
    add_incorrect_letter
  end

  def add_incorrect_letter
    @wrong_letters += "#{@letter} "
    picture
  end

  def picture
    print "\n  Word: "
    puts "#{@built_word.join(' ')}\n\n"
    print '  Wrong letters: '
    puts @wrong_letters
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
      puts "You're done! You line has ended!\nThe secret word was #{@secret_word}\n\n"
    elsif @built_word.join == @secret_word
      puts "You won boi!!\n\n"
    else
      turn
    end
  end
end
