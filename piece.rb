require_relative 'sliding_pieces'
require_relative 'stepping_pieces'

class Piece
  attr_reader :color, :pos, :board
  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
  end

  def moves

  end
end


class Pawn < Piece
  attr_accessor :moved
  def initalize(pos, color, board)
    super
    @moved = false
  end

  def moves
    move_array = []
    new_pos = pos.dup
    unless self.moved
      [[0, 2],[0, -2]].each do |delta|
        temp = [new_pos.first + delta.first, new_pos.last + delta.last]
        if !board.occupied?(temp) && temp.all? { |x| x.between?(0,7) }
          move_array << temp
        end
      end
    end

    
    move_dirs.each do |delta|
      temp = [new_pos.first + delta.first, new_pos.last + delta.last]
      if delta == dirs.first
        if !board.occupied?(temp)
          move_array << temp
        end
      elsif board.occupied?(temp) && board[temp].color != color
        move_array << temp
      end
    end

    move_array
  end

  def move_dirs
    if self.color == :b
      dirs = [[0,-1], [1,-1],[-1,-1]]
    else
      dirs = [[0,1], [1,1], [-1,1]]
    end
    dirs
  end
end
