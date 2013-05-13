class FindCode

  def tokenize(str, opts = {})
    return [] if str == ''
    ignore = opts[:ignore] || []
    tokens = []
    token_regex = /[a-zA-Z_0-9]+/
    m = str.match(token_regex)
    while m do
      token = m[0]
      if not ignore.include?(token) then
        tokens.push(Token.new(token, m.begin(0)))
      end
      m = str.match(token_regex, m.end(0))
    end
    tokens
  end

  def find_match(query, text)
    tokens = tokenize(text)
    tokens.select do |token|
      token.to_s == query || token.text == query
    end
  end

end

class Token

  attr_reader :text, :pos

  def initialize(text, pos)
    @text = text
    @pos = pos
  end

  def ununderscorize(token)
    token.gsub(/_/, ' ')
  end

  def uncamelcase(token)
    token.gsub(/([a-z])([A-Z])/) { |m|
      m[0] + ' ' + m[1].downcase()
    }
  end

  def to_s
    ununderscorize(uncamelcase(text)).downcase
  end

  def == (other)
    other.text == text && other.pos == pos
  end

end