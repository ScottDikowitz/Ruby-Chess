require 'colorize'
require_relative 'board'
require_relative 'cursorable'


class Display
  attr_reader :board
  attr_accessor :cursor

  def initialize(board)
    @cursor = [0,0]
    @selected = false
    @board = board
  end

  def render
    board.grid.each_with_index do |row, idx|
      row_rep = []
      row.each_with_index do |square, idy|
        if self.cursor == [idx, idy]
          row_rep << " #{board[[idx, idy]].symbol} ".colorize(:color => :white, :background => :blue)
        elsif board[[idx, idy]]
          row_rep << " #{board[[idx, idy]].symbol} "
        else
          row_rep << " _ "
        end
      end
      puts row_rep.join("|")
    end
  end
end
