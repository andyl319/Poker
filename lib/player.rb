require_relative 'hand'

class Player
  attr_accessor :hand, :money
  def initialize(name, hand = [], money = 500)
    @name = name
    @hand = hand
    @money = money
  end

  def action
    print "Give an action: 'fold', 'bet', 'raise', 'call'"
    action = gets.chomp.split(",")
  end

  def discard(indices)
  #  a = gets.chomp.split(",").map(&:to_i)
    indices.each do |idx|
      @hand.cards[idx] = nil
    end
  end


end
