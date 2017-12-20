

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
      yeah_man = "you haven't guessed anything. Can't tell you how low or how high."
    elsif @guesses.last.to_i > @number
      yeah_ man = "your last guess was to high."
    else
      yeah_man = "your last guess was to low."
    end
    "you have made #{number_of_guesses} guesses and #{yeah_man} ."
  end

end
