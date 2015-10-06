require 'colorize'
require_relative 'board'
require_relative 'cursorable'


class Display
  attr_reader :board
  attr_accessor :cursor, :selected

  def initialize(board)
    @cursor_pos = [0,0]
    @selected = nil
    @board = board
  end

  def render
    bg = :background
    c = :color

    board.grid.each_with_index do |row, idx|
      row_rep = []
      row.each_with_index do |square, idy|
        back = ((idx + idy) % 2 == 0) ? :light_white : :white
        if self.cursor == [idx, idy]
          if board[[idx,idy]]
            row_rep << " #{board[[idx, idy]].symbol} ".colorize(c => :red, bg => :blue)
          else
            row_rep << "   ".colorize(bg => :blue)
          end
        elsif selected == [idx, idy]
          if board[[idx,idy]]
            row_rep << " #{board[[idx, idy]].symbol} ".colorize(c => :green, bg => :red)
          else
            row_rep << "   ".colorize(bg => :red)
          end
        elsif board[[idx, idy]]
          row_rep << " #{board[[idx, idy]].symbol} ".colorize(bg => back)
        else
          row_rep << "   ".colorize(bg => back)
        end
      end
      puts row_rep.join
    end

    nil
  end
end
