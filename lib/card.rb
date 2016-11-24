class Card
  attr_reader :face_value, :suit

  def initialize(face_value, suit)
    @face_value = face_value
    @suit = suit
  end

  def inspect
    print "#{card.face_value}: #{card.suit}"
  end

  
  def to_s
    print "#{card.face_value}: #{card.suit}"
  end
end
