class Dictionary
  def initialize
    @dictionary = nil
    open_dictionary
  end

  def open_dictionary
    @dictionary = File.open('5desk.txt', 'r')
  end

end
