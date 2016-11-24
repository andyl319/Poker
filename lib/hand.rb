require_relative 'card'

class Hand
  attr_reader :vals, :suits
  attr_accessor :cards

  HIGH = {"Card high"=> 0, "Pair" => 1, "Two pair" => 2, "Three of a kind" => 3,
    "Straight" => 4, "Flush" => 5, "Full house" => 6, "Four of a kind" => 7, "Straight flush" => 8}

  def initialize(cards)
    @cards = cards
    @vals = []
    @suits = []
    get_vals
  end

  def get_vals
    @cards.each do |card|
      @vals << card.face_value
      @suits << card.suit
    end
  end

  def hand_value
    if is_flush?
      return HIGH["Straight flush"] if is_straight?
      return HIGH["Flush"]
    end

    if is_straight?
      return HIGH["Straight"]
    end
    ace_val
    return HIGH[find_value]

  end

  def is_flush?
    return @suits.all? { |suit| suit == @suits.first }
  end

  def is_straight?
    straight = true
    (1..4).each do |x|
      straight = false unless @vals.sort[x] == @vals.sort[x-1] + 1
    end
    return true if straight || ace_straight?
    false
  end

  def ace_straight?
    arr = [10,11,12,13]
    if @vals.sort.first == 1
      if @vals.sort.drop(1) == arr
        ace_val
        true
      end
    end
    false
  end

  def ace_val
    @vals.map! do |val|
      if val == 1
        val = 14
      else
        val
      end
    end
  end

  def find_value
    count = Hash.new { |h,k| h[k] = 0 }
    @vals.each do |val|
      count[val] = @vals.count(val) if @vals.count(val) > 1
    end
    if count.keys.length == 2
      if count.max_by { |k,v| v }[1] == 3
        return "Full house"
      else
        return "Two pair"
      end
    end

    if count.keys.length == 1
      return "Four of a kind" if count[count.keys.first] == 4
      return "Three of a kind" if count[count.keys.first] == 3
      return "Pair"
    end

    return "Card high"
  end

  def beats_hand(*hands)
    hand_val_arr = [self.hand_value]
    hands.each do |hand|
      hand_val_arr << hand.hand_value
    end
    max = -1
    winning_idx = nil
    winner = 0
    hand_val_arr.each_with_index do |val, idx|
      if val > max
        max = val
        winning_idx = idx
        winner = 0
      elsif val == max
        if winning_idx == 0
          winner = tie_breaker(self, hands[idx-1])
          if winner == hands[idx-1]
            max = val
            winning_idx = idx
          end
        else
          winner = tie_breaker(hands[winning_idx-1], hands[idx-1])
          if winner = hands[idx-1]
            max = val
            winning_idx = idx
          end
        end
      end
    end
    return "No winner!!" if winner == -1
    return winning_idx == 0 ? self : hands[winning_idx-1]
  end

  def tie_breaker(hand1, hand2)
    rem_cards1 = hand1.vals.sort.dup
    rem_cards2 = hand2.vals.sort.dup
    loop do
      card1 = rem_cards1.pop
      card2 = rem_cards2.pop
      if card1 > card2
        return hand1
      elsif card2 > card1
        return hand2
      end
      break if rem_cards1.empty? # || rem_cards2.empty?
    end
    return -1
  end

  def inspect
    cards.each do |card|
      print "#{card.face_value}: #{card.suit}"
    end
  end
end
