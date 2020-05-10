require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

class Start
  attr_reader :turn

  def initialize(turn)
    @turn = turn
    play
  end

  def play
    until turn.game_over? do
      final_winner = turn.winner
      p "Turn #{turn.count}: #{turn.pile_cards}"
      award_spoils(final_winner) unless final_winner == "No Winner"
      # p "Turn #{count}"
        if turn.game_over?
          if turn.counter == turn.limit || final_winner == "No Winner"
            p "---- DRAW ----"
          else
            p "*~*~*~* #{final_winner.name} has won the game! *~*~*~*"
          end
        break
      end
    end
  end

end
