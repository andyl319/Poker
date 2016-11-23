require 'card'

describe Card do
  describe "#intialize" do
    let(:card) { Card.new("K", "Hearts") }
    it "initializes a card with face value and suit" do
      expect(card.face_value).to eq("K")
      expect(card.suit).to eq("Hearts")
    end
  end
end
