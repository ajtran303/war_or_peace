class Turn
  attr_reader :player1,
              :player2,
              :spoils_of_war

  def initialize(p1, p2)
    @player1 = p1
    @player2 = p2
    @players = [p1, p2]
    @spoils_of_war = []
  end

  def type
    if @player1.deck.first_card == @player2.deck.first_card && @player1.deck.third_card == @player2.deck.third_card
      :mutually_assured_destruction
    elsif @player1.deck.first_card == @player2.deck.first_card
      :war
    else
      :basic
    end
  end

  def winner
    if type == :mutually_assured_destruction
      "No Winner"
    elsif type == :war
      war_winner
    elsif type == :basic
      basic_winner
    end
  end

  def war_winner
    winner = nil
    card_rank = 0
    @players.each do |player|
      if player.deck.third_card > card_rank
        card_rank = player.deck.third_card
        winner = player
      end
    end
    winner
  end

  def basic_winner
    winner = nil
    card_rank = 0
    @players.each do |player|
      if player.deck.first_card > card_rank
        card_rank = player.deck.first_card
        winner = player
      end
    end
    winner
  end

  def pile_cards
    if type == :mutually_assured_destruction
      3.times do
        take_cards(@player1)
      end
      3.times do
        take_cards(@player2)
      end
    elsif type == :war
      3.times do
        @spoils_of_war << take_cards(@player1)
      end
      3.times do
        @spoils_of_war << take_cards(@player2)
      end
    elsif type == :basic
      @spoils_of_war << take_cards(@player1)
      @spoils_of_war << take_cards(@player2)
    end
  end

  def take_cards(player)
    player.deck.cards.shift
  end

end
