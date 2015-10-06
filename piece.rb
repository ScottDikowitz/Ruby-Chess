
class Piece
  attr_reader :color, :board, :symbol
  attr_accessor :pos
  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
  end

  def moves
  end

  # def move!(pos)
  #   old_pos = self.pos
  #   self.board[pos] = self
  #   self.board[old_pos] = nil
  #   self.pos = pos
  # end


  def move_into_check?(pos)
    board_dup = board.dup

    board_dup.move!(self.pos, pos)

    board_dup.in_check?(board_dup[pos].color)
  end



  def valid_moves
    self.moves.select { |pos| !move_into_check?(pos) }
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
      [[2, 0],[-2, 0]].each do |delta|
        temp = [new_pos.first + delta.first, new_pos.last + delta.last]
        if temp.all? { |x| x.between?(0,7) } && !board.occupied?(temp)
          move_array << temp
        end
      end
    end


    move_dirs.each do |delta|
      temp = [new_pos.first + delta.first, new_pos.last + delta.last]
      if delta == move_dirs.first
        if temp.all? { |x| x.between?(0,7) } && !board.occupied?(temp)
          move_array << temp
        end
      elsif (temp.all? { |x| x.between?(0,7) } && board.occupied?(temp) && board[temp].color != color)
        move_array << temp
      end
    end

    move_array
  end

  def symbol
    color == :w ? "♙" : "♟"
  end

  def move_dirs
    if self.color == :w
      dirs = [[-1, 0], [-1, 1],[-1,-1]]
    else
      dirs = [[1, 0], [1,1], [1, -1]]
    end
    dirs
  end
end
