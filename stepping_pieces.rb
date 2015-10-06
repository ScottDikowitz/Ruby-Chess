require_relative 'piece'
class SteppingPiece < Piece
  def initialize(pos, color, board)
    super
  end

  def moves
    move_array = []
    move_dirs.each do |delta|
      new_pos = pos.dup
      temp = [new_pos.first + delta.first, new_pos.last + delta.last]
      if temp.all? {|x| x.between?(0,7)} && (!board.occupied?(temp) || board[temp].color != color)
        move_array << temp
      end
    end

    move_array
  end

  def move_dirs
    self.class.move_dirs
  end
end

class Knight < SteppingPiece
  def initialize(pos, color, board)
    super
  end

  def symbol
    color == :w ? "♘" : "♞"
  end

  def moves
    super
  end

  def move_dirs
    [[2,-1],[2,1],[-2-1],[-2,1],[1,2],[1,-2],[-1,2],[-1,-2]]
  end
end

class King < SteppingPiece
  def initialize(pos, color, board)
    super
  end

  def symbol
    color == :w ? "♔" : "♚"
  end

  def move_dirs
    [1, 0, -1].repeated_permutation(2).to_a.delete_if{|a| a == [0,0]}
  end

  def moves
    super
  end
end
