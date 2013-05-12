#! /usr/bin/env ruby

require 'findcode'

filename = ARGV[0]
puts "Reading #{filename}"
content = File.read(filename)
puts FindCode.new.tokenize(content)