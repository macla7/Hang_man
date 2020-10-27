# frozen_string_literal: true

class Dictionary
  def initialize
    @dictionary = nil
    open_dictionary
  end

  def open_dictionary
    @dictionary = File.open('5desk.txt', 'r')
    @dictionary = @dictionary.read.split
    words_5_to_7
  end

  def words_5_to_7
    @dictionary = @dictionary.select { |word| word.length <= 12 && word.length >= 6 }
  end

  def random_worder
    p @dictionary.sample
  end
end
