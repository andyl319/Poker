require 'game'

describe 'Game' do
  let(:game) { Game.new("bob", "mike", "jaffar") }
  describe '#initialize' do
    it "should make a deck" do
      expect(game.deck.deck.uniq.length).to eq(52)
    end

    it "should make a space for every player" do
      expect(game.players.length).to eq(3)
    end
  end
end
