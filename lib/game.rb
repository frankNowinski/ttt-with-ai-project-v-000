class Game
  attr_accessor :board, :player_1, :player_2, :count_1, :count_2

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2],
  ]

  def initialize(player_1 = Player::Human.new("X"), player_2 = Player::Human.new("O"), board = Board.new)
    @player_1 = player_1 
    @player_2 = player_2 
    @board = board 
    @winner_token = nil
  end

  def current_player 
    board.turn_count.even? ? player_1 : player_2
  end

  def over?
    won? || draw?
  end

  def won?
    WIN_COMBINATIONS.each do |combo|
      if (board.cells[combo[0]] == board.cells[combo[1]] && 
        board.cells[combo[1]] == board.cells[combo[2]]) && 
        board.cells[combo[0]] != " "

        @winner_token = board.cells[combo[0]]
        return true 
      end
    end
    false
  end

  def draw?
    board.full? && !won?
  end

  def winner
    won?
    @winner_token
  end

  def turn 
    player_move = current_player.move(board) 

    if board.valid_move?(player_move) 
      board.update(player_move, current_player) 
    else
      turn
    end
  end

  def play
    until over?
      turn
      board.display
    end
    puts "Congratulations #{winner}!" if won?
    puts "Cats Game!" if draw?
  end

  def wargames
    until over?
      turn
      board.display
    end
    @count_1 = 0
    @count_2 = 0
  end
end
