class CardGenerator
  attr_reader :suits,
              :i,
              :royal,
              :numbers,
              :pecking_order,
              :style

  def initialize(i)

    # start
    @i = i #gets.chomp
    @suits = []
    @royal = ["Jack", "Queen", "King"]
    @numbers = str_arr
    @pecking_order = nil
    @style = nil
    # get_style
    ## style determines pecking_order
    ## take the pecking order array and 
    # print_msg
  end

  def print_msg
    puts "Generating '#{@style}_deck.txt'"
    puts "...."
    puts "Success!"
  end

  def get_style
    puts "Pick a deck style: [S]tandard / [T]arot Minor Arcana"
    invalid_counter = 0

    loop do
      style = gets.chomp
      if style == "S"
        standardize
        break
      elsif style == "T"
        tarotize
        break
      else
        puts "Pick a deck style: [S]tandard / [T]arot Minor Arcana"
        invalid_counter += 1
        if invalid_counter == 3
          puts "Goodbye"
          exit
        end
      end
    end


  end

  def start

    puts "Hello. Let's build a deck of cards."
    puts "This program will generate a text file."
    puts "Continue? [Y]es / [N]o"
    invalid_counter = 0

    loop do

      p = gets.chomp

      if p == "Y"
        puts "OK"
        break
      elsif p == "N"
        puts "Goodbye"
        exit
      else
        puts "Invalid input. Continue? [Y]es / [N]o"
        invalid_counter += 1
        if invalid_counter == 3
          puts "Goodbye"
          exit
        end
      end

    end

  end

  def hi
    "hello"
  end

  # make into method to choose multiples of decks?
  def move_it
    @suits << @i
  end

  def standardize
    @suits = standard_suits
    @pecking_order = standard_order
    @style = "Standardized"
  end

  def standard_suits
    [:club, :spade, :heart, :diamond]
  end

  def tarotize
    @suits = tarot_suits
    @royal.unshift "Knight"
    @pecking_order = tarot_order
    @style = "Tarotized"
  end

  def tarot_suits
    [:cup, :wand, :coin, :sword]
  end

  def aces_high?
    @suits == standard_suits
  end

  def ace
    ["Ace"]
  end

  def str_arr
    (2..10).to_a.map { |num| num.to_s }
  end

  def standard_order
    [numbers, royal, ace].flatten!
  end

  def tarot_order
    [ace, numbers, royal].flatten!
  end

  def deck_size
    @pecking_order.size * @suits.size
  end

  def cards_to_print
    @i * deck_size
  end

end
