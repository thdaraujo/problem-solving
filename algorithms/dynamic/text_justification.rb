# frozen_string_literal: true

require 'test/unit/assertions'
include Test::Unit::Assertions

# given `words` as an input and `max_width`,
# format the text such that each line has
# exactly max_width characters and is
# fully (left and right) justified.

def justify(words, max_width)
  dp = [0] * (words.size + 1)
  breaks = [0] * (words.size + 1)

  (0...words.size).reverse_each do |i|
    puts "i = #{i}"
    puts "dp = #{dp.inspect}"
    costs_with_parent = (i + 1..words.size).map do |j|
      puts "j = #{j}"
      puts "dp[j] = #{dp[j]}"
      cost = dp[j] + badness(words[i...j], max_width)
      parent = j
      puts "> cost = #{cost}, parent = #{j}"
      { cost: cost, parent: parent }
    end
    min = costs_with_parent.min_by { |h| h[:cost] }
    dp[i] = min[:cost]
    breaks[i] = min[:parent] + i + 1
  end
  puts dp.inspect
  puts breaks.inspect

  lines = []
  i = 0
  breaks.each do |b|
    if b < words.size
      slice = words[i..b]
      lines << slice if slice
    end
    i = b
  end
  lines << words[i..-1] if i < words.size
 
  puts lines.inspect

  lines.join("\n")
end

def badness(line, max_width)
  gaps = line.size - 1 # spaces/gaps
  line_length = line.map(&:size).sum + gaps
  return Float::INFINITY if line_length > max_width
 
  (max_width - line_length) ** 3
end

def justify_simple
  words = ["foo", "bar"]

  max_width = 4
  expected = "foo\nbar"

  actual = justify(words, max_width)

  assert_equal actual, expected
end

def justify_test
  words = ['This', 'is', 'an', 'example',
           'of', 'text', 'justification.']

  max_width = 16
  expected = "This is an\nexample of text\njustification."

  actual = justify(words, max_width)

  assert_equal actual, expected
end


justify_simple
justify_test
