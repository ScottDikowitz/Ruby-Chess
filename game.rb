require_relative 'board'
require_relative 'display'
require_relative 'cursorable'
class ChessGame

  attr_reader :board, :display
  def initialize(player_1, player_2)
    @board = Board.new
    @display = Display.new(board)
    @player_1 = HumanPlayer.new(player_1, board)
    @player_2 = HumanPlayer.new(player_2, board)
  end

  # def run
  #
  #   over = false
  #   while over == false
  #     display.render
  #     pos = self.player_1.move
  #     pos = self.player_2.move
  #   end
  # end
  def turn(cur_player)
    display.selected = nil
    display.cursor_pos = [0,0]
    cur_player.cursor_pos = [0,0]

    selected_pos = nil
    until selected_pos
      display.render
      selected_pos = cur_player.get_input
      display.cursor_pos = cur_player.cursor_pos
    end
    display.selected = selected_pos

    target_pos = nil
    until target_pos
      display.render
      target_pos = cur_player.get_input
      display.cursor_pos = cur_player.cursor_pos
    end
    board.move(selected_pos, target_pos)

  rescue MoveError => e
    puts "Invalid move, sukkah"
    retry


    display.render
  end

end

class HumanPlayer
  include Cursorable

  def initialize(name, board)
    @name = name
    @board = board
    @cursor_pos = [0,0]
  end

  def test
    puts get_input
  end

end
