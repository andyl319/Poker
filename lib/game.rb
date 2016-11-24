require_relative 'deck'
require_relative 'player'

class Game
  attr_reader :deck, :players

  def initialize(*names)
    @folded_players = []
    @index = 0
    @current_bet = 0
    @deck = Deck.new
    @players = []

    names.each do |name|
      @players << Player.new(name)
    end
    @turn = @players[@index]
  end

  def play
    @folded_players.each { |player| @players << player }
    @folded_players = []
    until @players.length == 1
      @deck = Deck.new
      @deck.deck.shuffle!
      @players.each do |player|
        5.times do
          player.hand << @deck.deck.shift
        end
      end
      betting_round
      discard_round
      betting_round
      hands = []
      @players[1..-1].each do |player|
        hands << player.hand
      end

      @players[0].hand.beats_hand(hands)
    end
  end

  def discard_round
    @players.each do |player|
      p player.hand
      puts "Enter cards to discard"
      indices = gets.chomp.split(",").map(&:to_i)
      print indices
      player.discard(indices)
      player.hand.map! do |card|
        if card.nil?
          card = @deck.deck.shift
        else
          card
        end
      end
    end
  end

  def betting_round
    players.length.times do
      print @turn.hand.to_s
      action = @turn.action
      case action[0]
      when "bet"
        @current_bet = action[1].to_i
        @players[@index].money -= action[1].to_i
        @index = (@index+1) % @players.length
        @turn = @players[@index]
      when "raise"
        @current_bet += action[1].to_i
        @players[@index].money -= action[1].to_i
        @index = (@index+1) % @players.length
        @turn = @players[@index]
      when "fold"
        @folded_players << @players.delete_at(@index)
      when "call"
        @players[@index].money -= action[1].to_i
        @index = (@index+1) % @players.length
      end
    end
  end

end
