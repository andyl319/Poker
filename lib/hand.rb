require_relative 'card'

class Hand
  attr_reader :vals, :suits

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
      puts "flush"
      return HIGH["Straight flush"] if is_straight?
      return HIGH["Flush"]
    end

    if is_straight?
      puts "straight"
      return HIGH["Straight"]
    end
    puts "high"
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
    print @vals
    print @suits
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
    hand_values = Hash.new { |h,k| h[k] = 0 }
    hands.each_with_index do |hand, index|
      hand_values[hand] = [hand.hand_value, index]
    end

    max = hand_values.values.map { |value| value.take(1) }.max
    ties = []
    hand_values.each do |h, k|



    end
  end

end
