require_relative 'board'
require_relative 'display'
require 'cursorable'
class ChessGame

  attr_reader :board, :display
  def initialize(player_1, player_2)
    @board = Board.new
    @display = Display.new(board)
    @player_1 = HumanPlayer.new(player_1, board)
    @player_2 = HumanPlayer.new(player_2, board)
  end

  def run

    over = false
    while over == false
      display.render
      pos = self.player_1.move
      pos = self.player_2.move
    end
  end

end

class HumanPlayer
  include Cursorable

  def initialize(name, board)
    @name = name
    @board = board
    @cursor_pos = [0,0]
  end

end
