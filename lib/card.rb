class Card
  attr_reader :face_value, :suit

  def initialize(face_value, suit)
    @face_value = face_value
    @suit = suit
  end

end
