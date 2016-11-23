require 'hand'

describe Hand do
  let(:hand) { Hand.new([Card.new(1, "Hearts"), Card.new(2, "Hearts"), Card.new(3, "Hearts"),
    Card.new(4, "Hearts"), Card.new(5, "Hearts")]) }
  let(:hand2) { Hand.new([Card.new(8, "Hearts"), Card.new(2, "Hearts"), Card.new(3, "Hearts"),
    Card.new(4, "Hearts"), Card.new(5, "Hearts")]) }
  let(:hand3) { Hand.new([Card.new(1, "Hearts"), Card.new(2, "Hearts"), Card.new(3, "Hearts"),
    Card.new(4, "Spades"), Card.new(5, "Hearts")]) }
  let(:hand4) { Hand.new([Card.new(1, "Hearts"), Card.new(1, "Hearts"), Card.new(1, "Hearts"),
    Card.new(1, "Spades"), Card.new(5, "Hearts")]) }
  let(:hand5) { Hand.new([Card.new(1, "Hearts"), Card.new(3, "Spades"), Card.new(3, "Hearts"),
    Card.new(4, "Hearts"), Card.new(4, "Hearts")]) }
  describe "#initialize" do
    it "initailizes a hand with the values of the cards" do
      expect(hand.vals.sort).to eq([1, 2, 3, 4, 5])
      expect(hand.suits).to eq(["Hearts", "Hearts", "Hearts", "Hearts", "Hearts"])
    end
  end

  describe "#hand_value" do
    it "Finds the straight flush" do
      expect(hand.hand_value).to eq(8)
    end
    it "Finds a regular flush" do 
      expect(hand2.hand_value).to eq(5)
    end
    it "Finds a straight" do
      expect(hand3.hand_value).to eq(4)
    end
    it "Finds a four of a kind" do
      expect(hand4.hand_value).to eq(7)
    end
    it "Finds a two pair" do
      expect(hand5.hand_value).to eq(2)
    end
  end
end
