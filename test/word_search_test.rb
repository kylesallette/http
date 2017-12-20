require 'minitest/autorun'
require 'minitest/pride'
require './lib/word_search'


class WordSearchTest < Minitest::Test


  def test_it_exists
    word = WordSearch.new

    assert_instance_of WordSearch, word
  end

  def test_it_returns_word_is_a_known_word_
    word = WordSearch.new

    assert_equal "Church is a known word.", word.word_search("church")
  end

  def test_comes_back_invalid_with_a_single_letter
    word = WordSearch.new

    assert_equal "O is a known word.", word.word_search("o")
  end

  def test_comes_back_invalid_with_num
    word = WordSearch.new

    assert_equal "1 is not a known word.", word.word_search("1")
  end

  def test_comes_back_invalid_with_made_up_word
    word = WordSearch.new

    assert_equal "Abcde is not a known word.", word.word_search("Abcde")
  end

  def test_will_search_for_long_word
    word = WordSearch.new

    expected = "Elephant"

    assert_equal "#{expected} is a known word.",word.word_search("elephant")
  end

  def test_comes_back_valid_with_a_single_valid_character
    word = WordSearch.new

    expected = "A"

    assert_equal "#{expected} is a known word.",word.word_search("a")
  end

end
