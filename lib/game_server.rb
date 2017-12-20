class GameServer

  attr_reader :guesses,
              :number

  def initialize
    @guesses = []
    @number = rand(0..20)
  end


  def start_game
    "Good luck!"
  end

  def how_many_guesses
    number_of_guesses = @guesses.count
    if number_of_guesses == 0
      response = "you haven't guessed anything. Can't tell you how low or how high."
    elsif @guesses.last.to_i > @number
      response = "your last guess was to high."
    else
      response = "your last guess was to low."
    end
  "you have made #{number_of_guesses} guesses and #{response} ."
  end

end
