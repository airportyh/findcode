require 'test/unit'
require './findcode'

class TestTokenize < Test::Unit::TestCase

  def tokenize(str, opts = {})
    FindCode.new.tokenize(str, opts).map { |tok| tok.to_s }
  end

  def test_tokenize_empty_string
    assert_equal([], tokenize(""))
  end

  def test_tokenize_a_word
    assert_equal(["abc"], tokenize("abc"))
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
      :ignore => ['def', 'end'])
    assert_equal(tokens, ['tokenize', 'abc'])
  end

  def test_underscore_words_treated_as_phrase
    tokens = tokenize("def tokenize_those_things")
    assert_equal(tokens, ["def", "tokenize those things"])
  end

  def test_camelcase_treated_as_phrase
    tokens = tokenize("def tokenizeThoseThings")
    assert_equal(tokens, ["def", "tokenize those things"])
  end

  def test_always_downcases
    assert_equal(['abc', 'def'], tokenize('ABC DEF'))
  end

  def test_gets_positions
    tokens = FindCode.new.tokenize('abc defg')
    puts tokens[0].pos
    positions = tokens.map {|tok| tok.pos }
    assert_equal([0, 4], positions)
  end

end

class TestFindMatch < Test::Unit::TestCase

  def test_matches_a_word
    match = FindCode.new.find_match("a method", "def a_method")
    assert_equal(match, [token('a_method', 4)])
  end

  def test_matches_multiple_words
    match = FindCode.new.find_match("abc", "abc = 'abc'")
    assert_equal(match, 
      [token('abc', 0), token('abc', 7)])
  end

  def test_matches_both_query_words
    #match = FindCode.new.find_match(["abc", "def"], "abc def")

  end

  def token(token, pos)
    Token.new(token, pos)
  end

end