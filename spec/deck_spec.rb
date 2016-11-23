require 'deck'

describe Deck do
  describe "#initialize" do
    let(:deck) {Deck.new}
    it "Makes a 52 card deck" do
      hash = Hash.new { |h,k| h[k] = 0 }
      1.upto(13) do |x|
        hash[x] =  4
      end
      deck_hash = Hash.new { |h,k| h[k] = 0 }
      deck.deck.each do |card|
        deck_hash[card.face_value] += 1
      end

      expect(deck_hash).to eq(hash)
    end
  end
end
