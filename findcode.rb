class FindCode

  def tokenize(str, opts = {})
    if str == '' then
      return []
    end
    tokens = str.split(/[^a-zA-Z0-9]+/)
    if opts[:keywords]
      tokens = tokens.select { |tok|
        not opts[:keywords].include?(tok)
      }
    end
    tokens
  end

end