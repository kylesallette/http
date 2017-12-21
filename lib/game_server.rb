require './lib/redirect_response'

class GameServer

  attr_reader :guesses,
              :number,
              :count,
              :guess_number

  def initialize
    @guesses = []
    @number = rand(0..5)
    @count = count
    @guess_number = guess_number
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
    elsif @guesses.last.to_i < @number
      response = "your last guess was to low."
    else
      response = "Your guess was correct!"
    end
    "you have made #{number_of_guesses} guesses and #{response} ."
  end

  def checking_what_path(request_lines, client)
    count_1 = request_lines.select { |char| char.include?("Content-Length:")}.join("")
    @count = count_1.split(" ")[1]
    @guess_number = client.read("#{count}".to_i)
    split_out_guess(request_lines,client)
  end

  def split_out_guess(request_lines, client)
    number = @guess_number.split("\n")[3]
    @guesses << number.strip
    redirect = RedirectResponse.new
    redirect.redirect_message(request_lines, client, "302 Found")
  end

end
