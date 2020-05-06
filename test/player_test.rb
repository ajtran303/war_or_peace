require 'minitest/autorun'
require 'minitest/pride'
require './lib/player'
require './lib/deck'
require './lib/card'

class PlayerTest < Minitest::Test

  def setup
    @card1 = Card.new(:diamond, "Queen", 12)
    @card2 = Card.new(:spade, "3", 3)
    @card3 = Card.new(:heart, "Ace", 14)

    @deck = Deck.new([@card1, @card2, @card3])

    @player = Player.new("Clarisa", @deck)

  end

  def test_it_exists
    player = @player

    assert_instance_of Player, player
  end

  def test_it_has_a_name
    player = @player

    assert_equal "Clarisa", player.name
  end

  def test_it_has_a_deck
    player = @player

    assert_equal @deck, player.deck
  end


  def test_it_knows_if_lost
    player = @player

    refute player.has_lost?
  end

  def test_it_has_lost_when_deck_is_empty
    player = @player

    3.times do
      player.deck.remove_card
    end

    assert_empty player.deck.cards

    assert player.has_lost?
  end

end
