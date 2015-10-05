class Piece
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
end

class Bishop < SlidingPiece
  def initialize(pos, color, board)
    super
  end
end

class Rook < SlidingPiece
  def initialize(pos, color, board)
    super
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
