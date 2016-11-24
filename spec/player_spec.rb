require 'player'

describe Player do
  let(:hand) {Hand.new([Card.new(1, "Hearts"), Card.new(2, "Hearts"), Card.new(3, "Hearts"),
    Card.new(4, "Hearts"), Card.new(5, "Hearts")]) }
  let(:player) { Player.new('greg', hand) }
  describe "#initialize" do
    it "initializes player with a hand and money" do
      expect(player.hand).to eq(hand)
    end
    it "initializes money to be 500" do
      expect(player.money).to eq(500)
    end
  end

  describe "#discard" do
    it "sets the discarded cards to nil in the hand" do
      player.discard([0,1,2])
      expect(player.hand.cards).to eq([nil, nil, nil, player.hand.cards[3], player.hand.cards[4]])
    end
  end

end
