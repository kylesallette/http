class WordSearch

  attr_reader :word

  def initialize
    @word = word
  end

  def word_search(word)
      dic_words = []
      File.readlines("/usr/share/dict/words").each do |words|
        dic_words << words.chomp
      end
      if dic_words.include?(word)
        "#{word.capitalize} is a known word"
      else
        "#{word.capitalize} is not a known word"
      end
    end

end
