require 'minitest/autorun'
require 'minitest/pride'
require './lib/deck'
require './lib/card'

class DeckTest < Minitest::Test

  def setup
    @card1 = Card.new(:diamond, "Queen", 12)
    @card2 = Card.new(:spade, "3", 3)
    @card3 = Card.new(:heart, "Ace", 14)
    @card4 = Card.new(:club, "5", 5)

    @cards = [@card1, @card2, @card3]

    @deck = Deck.new(@cards)
  end

  def test_it_exists
    deck = @deck

    assert_instance_of Deck, deck
  end

  def test_it_knows_cards
    deck = @deck

    assert_equal [@card1, @card2, @card3], deck.cards
  end

  def test_it_knows_card_ranks
    deck = @deck

    assert_equal 12, deck.rank_of_card_at(0)
  end

  def test_it_knows_ranks_of_other_indices
    deck = @deck

    assert_equal 14, deck.rank_of_card_at(2)
  end

  def test_it_gives_rank_of_the_last_card_in_array_when_index_not_found
    deck = @deck

    assert_nil deck.cards[3]
    assert_equal 14, deck.rank_of_card_at(3)
  end

  def test_it_gives_rank_of_the_last_card_when_index_not_found
    deck = Deck.new([@card1])

    assert_equal 1, deck.cards.length
    assert_equal true, deck.last_card?

    deck.remove_card

    assert_empty deck.cards
    assert_nil deck.cards[0]

    assert_equal "LAST CARD NOT FOUND", deck.rank_of_card_at(0)
  end


  def test_it_knows_faces_and_aces
    deck = @deck

    assert_equal [@card1, @card3], deck.high_ranking_cards
  end

  def test_it_calculates_percentage_highs
    deck = @deck

    assert_equal 66.67, deck.percent_high_ranking
  end

  def test_it_removes_cards_from_the_top
    # @cards = [@card1, @card2, @card3]
    deck = @deck

    assert_equal @card1, deck.remove_card
  end

  def test_it_changes_percent_ranks_when_card_removed
    deck = @deck
    deck.remove_card

    assert_equal 50.0, deck.percent_high_ranking
  end

  def test_it_adds_cards_to_the_bottom
    deck = @deck
    deck.add_card(@card4)

    assert_equal [@card1, @card2, @card3, @card4], deck.cards
  end

  def test_it_changes_percent_ranks_when_card_removed_and_added
    deck = @deck
    deck.remove_card
    deck.add_card(@card4)

    assert_equal 33.33, deck.percent_high_ranking
  end

end
