require 'minitest/autorun'
require 'minitest/pride'
require './lib/turn'
require './lib/player'
require './lib/deck'
require './lib/card'

class TurnTest < Minitest::Test

  def setup
    card1 = Card.new(:heart, "Jack", 11)
    card2 = Card.new(:heart, "10", 10)
    card3 = Card.new(:heart, "9", 9)
    card4 = Card.new(:diamonds, "Jack", 11)

    card5 = Card.new(:heart, "8", 8)
    card6 = Card.new(:diamond, "Queen", 12)
    card7 = Card.new(:heart, "3", 3)
    card8 = Card.new(:diamond, "2", 2)

    # player_1 has same deck for all turn types
    @control_deck = Deck.new([card1, card2, card5, card8])

    # player_2 deck will vary, esp in mad turn
    @basic_deck = Deck.new([card3, card4, card6, card7])
    @war_deck = Deck.new([card4, card3, card6, card7])
    @mad_deck = Deck.new([card4, card3, Card.new(:diamond, "8", 8), card7])

    @player_const = Player.new("Megan", @control_deck)

    @player_basic = Player.new("Aurora", @basic_deck)
    @player_war = Player.new("Aurora", @war_deck)
    @player_mad = Player.new("Aurora", @mad_deck)

    @turn_basic = Turn.new(@player_const, @player_basic)
    @turn_war = Turn.new(@player_const, @player_war)
    @turn_mad = Turn.new(@player_const, @player_mad)
  end


  def test_it_exists_in_setup
    assert_instance_of Turn, @turn_basic
    assert_instance_of Turn, @turn_war
    assert_instance_of Turn, @turn_mad
  end

  def test_it_has_readable_player1_attributes
    assert_equal @player_const, @turn_basic.player1
    assert_equal @player_const, @turn_war.player1
    assert_equal @player_const, @turn_mad.player1
  end

  def test_it_has_readable_player2_attributes
    assert_equal @player_basic, @turn_basic.player2
    assert_equal @player_war, @turn_war.player2
    assert_equal @player_mad, @turn_mad.player2
  end

  def test_it_inits_with_empty_spoils_array
    assert_empty @turn_basic.spoils_of_war
    assert_empty @turn_war.spoils_of_war
    assert_empty @turn_mad.spoils_of_war
  end

  def test_it_knows_when_the_first_cards_ranks_are_equal
    assert_equal true, @turn_war.same_first_rank?
  end

  def test_it_knows_when_the_first_cards_ranks_are_not_equal
    assert_equal false, @turn_basic.same_first_rank?
  end

  def test_it_knows_when_the_third_cards_ranks_are_equal
    assert_equal true, @turn_mad.same_third_rank?
  end

  def test_it_knows_when_the_third_cards_ranks_are_not_equal
    assert_equal false, @turn_war.same_third_rank?
  end

  def test_it_is_type_basic_when_first_cards_rank_are_not_equal
    assert_equal false, @turn_basic.same_first_rank?
    assert_equal :basic, @turn_basic.type
  end

  def test_it_is_type_war_when_first_cards_rank_are_equal
    assert_equal true, @turn_war.same_first_rank?
    assert_equal :war, @turn_war.type
  end

  def test_it_is_type_mad_when_first_and_third_cards_rank_are_equal
    assert_equal true, @turn_mad.same_first_rank? && @turn_mad.same_third_rank?
    assert_equal :mutually_assured_destruction, @turn_mad.type
  end

  def test_it_picks_basic_winner_with_higher_first_card
    assert_equal @player_const, @turn_basic.winner
  end

  def test_it_picks_war_winner_with_higher_third_card
    assert_equal @player_war, @turn_war.winner
  end

  def test_it_picks_no_winner_when_type_mad
    assert_equal "No Winner", @turn_mad.winner
  end

  def test_it_piles_two_cards_to_spoils_when_type_basic
    assert_equal 0, @turn_basic.spoils_of_war.size

    @turn_basic.pile_cards

    assert_equal 2, @turn_basic.spoils_of_war.size
  end

  def test_it_piles_six_cards_to_spoils_when_type_war
    assert_equal 0, @turn_war.spoils_of_war.size
    
    @turn_war.pile_cards

    assert_equal 6, @turn_war.spoils_of_war.size
  end

  def test_it_exiles_six_cards_away_when_type_mad
    assert_equal 0, @turn_war.spoils_of_war.size

    @turn_war.pile_cards

    assert_equal 0, @turn_war.spoils_of_war.size
  end

  #
  # def test_it_picks_basic_winner_with_higher_first_card
  #   assert @turn_basic.player1.deck.rank_of_card_at(0) > @turn_basic.player2.deck.rank_of_card_at(0)
  #   assert_equal @player_const, @turn_basic.winner
  # end
  #
  # def test_it_picks_war_winner_with_higher_third_card
  #   skip
  #   assert @turn_war.player1.deck.rank_of_card_at(0) > @turn_war.player2.deck.rank_of_card_at(0)
  #   assert_equal @player_war, @turn_war.winner
  # end
  #
  # def test_it_picks_no_winner_when_type_mad
  #   skip
  #   assert_equal :mutually_assured_destruction, @turn_mad.type
  #   assert_equal "No Winner", @turn_mad.winner
  # end



end
