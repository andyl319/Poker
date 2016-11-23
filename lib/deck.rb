require_relative 'card'

class Deck
  attr_reader :deck

  SUITS = ["Hearts", "Spades", "Diamonds", "Clubs"]
  FACE = (1..13).to_a

  def initialize
      @deck = []
      populate
  end

  def populate
    SUITS.each do |suit|
      FACE.each do |val|
        @deck << Card.new(val, suit)
      end
    end
  end

end
