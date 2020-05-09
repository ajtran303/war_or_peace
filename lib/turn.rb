class Turn
  attr_reader :player1,
              :player2,
              :spoils_of_war,
              :players

  def initialize(p1, p2)
    @player1 = p1
    @player2 = p2
    @spoils_of_war = []
    @exile = []
    @players = [p1, p2]
    @counter = 0
    @limit = 10**6
  end

  def type
    if same_first_rank? && same_third_rank?
      :mutually_assured_destruction
    elsif same_first_rank?
      :war
    else
      :basic
    end
  end

  def same_first_rank?
    player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0)
  end

  def same_third_rank?
    player1.deck.rank_of_card_at(2) == player2.deck.rank_of_card_at(2)
  end

  def winner
    win_hash = {  basic: basic_winner,
                  war: war_winner,
                  mutually_assured_destruction: "No Winner"
                }
    win_hash[type]
  end

  def basic_winner
    @players.max_by do |player|
      player.deck.rank_of_card_at(0)
    end
  end

  def war_winner
    @players.max_by do |player|
      player.deck.rank_of_card_at(2)
    end
  end

  def pile_cards
    if type == :mutually_assured_destruction
      mad_exile
    elsif type == :war
      war_pile
    elsif type == :basic
      basic_pile
    end
  end

  def basic_pile
    @players.each do |player|
      @spoils_of_war << player.deck.remove_card
    end
  end

  def war_pile
    3.times { basic_pile }
  end

  def mad_exile
    3.times do
      @players.each do |player|
          @exile << player.deck.remove_card
      end
    end
  end

  def award_spoils(turn_winner)
    @spoils_of_war.shuffle!
    @spoils_of_war.each do |spoil|
      turn_winner.hand << spoil
    end
    @spoils_of_war = []
  end

  def count
    @limit.times do
      @counter += 1
    end
  end

end
