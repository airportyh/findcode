require 'minitest/autorun'
require 'findcode'

class TestTokenize < Minitest::Test

  def tokenize(str, opts = {})
    FindCode.new.tokenize(str, opts)
  end

  def test_tokenize_empty_string
    assert_equal(tokenize(""), [])
  end

  def test_tokenize_a_word
    assert_equal(tokenize("abc"), ["abc"])
  end

  def test_tokenize_two_words
    assert_equal(tokenize("abc def"), ["abc", "def"])
  end

  def test_non_letter_numbers_are_ignored
    assert_equal(tokenize("def tokenize2; 'abc'; end"),
      ["def", "tokenize2", "abc", "end"])
  end

  def test_ignores_keywords
    tokens = tokenize("def tokenize; 'abc'; end", 
      :keywords => ['def', 'end'])
    assert_equal(tokens, ['tokenize', 'abc'])
  end

end