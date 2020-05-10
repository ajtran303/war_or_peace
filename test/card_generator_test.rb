require 'minitest/autorun'
require 'minitest/pride'
require './lib/card_generator'


class CardGeneratorTest < Minitest::Test

  def setup
    @card_generator = CardGenerator.new
  end

  def test_it_exists
    assert_instance_of CardGenerator, @card_generator
  end

  def test_it_says_hello
    assert_equal "hello", @card_generator.hi
  end

  def test_it_starts_with_an_empty_array
    assert_instance_of Array, @card_generator.arr
    assert_empty @card_generator.arr
  end

  def test_it_has_an_integer_number
    assert_instance_of Integer, @card_generator.i
  end

  def test_it_starts_at_number_0
    assert_equal 0, @card_generator.i
  end

  def test_it_can_have_a_different_number
    diff = CardGenerator.new(2)
    assert_equal 2, diff.i
  end

  def test_it_can_put_that_number_in_the_array

    assert_empty @card_generator.arr
    @card_generator.move_it
    assert_equal [0], @card_generator.arr

    diff = CardGenerator.new(2)
    diff.move_it
    assert_equal [2], diff.arr

  end

  def test_it_has_an_array_of_standard_suits


    assert_equal [:club, :spade, :heart, :diamond], @card_generator.standard
  end

  def test_it_has_an_array_of_tarot_suits

    assert_equal [:cup, :wand, :coin, :sword], @card_generator.tarot
  end

end
