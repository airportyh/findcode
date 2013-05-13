#! /usr/bin/env ruby

require './findcode'
require 'colorize'

filename = ARGV[0]
query = ARGV[1..ARGV.size]
#puts "Query: #{query}"
#puts "Reading #{filename}"
content = File.read(filename)
lines = content.split("\n")
find_code = FindCode.new
lines.each_with_index do |line, index|
  matches = find_code.find_match(query[0], line)
  if matches.size > 0 then
    display_line = ''
    idx = 0
    matches.each do |match|
      display_line += line[idx..match.pos - 1] +
        line[match.pos..match.pos + match.text.size - 1].green
      idx = match.pos + match.text.size
    end
    display_line += line[idx..line.size]
    puts "#{index}: #{display_line}"
  end
  
end