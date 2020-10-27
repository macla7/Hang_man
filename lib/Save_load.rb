require 'yaml'

module SaveLoad
  def def_game_state
    game_state = {
      secret_word: @secret_word,
      hung_limbs: @hung_limbs,
      secret_array: @secret_array,
      built_word: @built_word,
      wrong_letters: @wrong_letters,
      action_approved: @action_approved,
      letter: @letter
    }
    saver(game_state)
  end

  def saver(game_state)
    save_file = File.open('hangmang_save.yml', 'w')
    YAML.dump(game_state, save_file)
    save_file.close
    exit
  end

  def load_game
    save_file = YAML.load(File.read('hangman_save.yml'))
    @secret_word = save_file[:secret_word]
    @hung_limbs = save_file[:hung_limbs]
    @secret_array = save_file[:secret_array]
    @built_word = save_file[:built_word]
    @wrong_letters = save_file[:wrong_letters]
    @action_approved = save_file[:action_approved]
    @letter = save_file[:letter]
    turn
  end
end