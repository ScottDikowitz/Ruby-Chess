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

class SlidingPiece < Piece
  def initialize(pos, color, board)
    super
  end

  def moves
    move_array = []
    move_dirs.each do |delta|
      new_pos = pos.dup
      temp = [new_pos.first + delta.first, new_pos.last + delta.last]
      while temp.all? { |x| x.between(0,7) }
        if board.occupied?(temp) && board[temp].color != color
          move_array << temp
          next
        elsif board.occupied?(temp)
          next
        end
        move_array << temp
        temp = [temp.first + delta.first, temp.last + delta.last]
      end
    end
    move_array
  end

  def move_dirs
    raise NotImplementedError
  end
end

class SteppingPiece < Piece
  def initialize(pos, color, board)
    super
  end
end

class Queen < SlidingPiece
  def initialize(pos, color, board)
    super
  end

  def moves_dirs
    [1, 0, -1].repeated_permutations(2).to_a.delete_if{|a| a == [0,0]}
  end
end

class Bishop < SlidingPiece
  def initialize(pos, color, board)
    super
  end

  def moves_dirs
    [1, -1].repeated_permutations(2).to_a
  end
end

class Rook < SlidingPiece
  def initialize(pos, color, board)
    super
  end

  def moves_dirs
    [[1,0], [0,1], [-1,0], [0,-1]]
  end
end

class Knight < SteppingPiece
  def initialize(pos, color, board)
    super
  end
end

class King < SteppingPiece
  def initialize(pos, color, board)
    super
  end
end

class Pawn < Piece
  def initalize(pos, color, board)
    super
  end
end
