# frozen_string_literal: true

require_relative 'lib/Dictionary'
require_relative 'lib/Game'

Dict = Dictionary.new
secret_word = Dict.random_worder

game = Game.new(secret_word)
