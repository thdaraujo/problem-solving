class Trie < Hash
  def initialize
    super
  end

  def add(key)
    key.chars.inject(self) do |hash, char|
      hash[char] ||= {}
    end
  end

  def have?(word)
    hash = self

    word.each_char do |char|
      return false if hash.nil?
      return false if hash[char].nil?
      hash = hash[char]
    end

    true
  end
end

require "test/unit/assertions"
include Test::Unit::Assertions

trie = Trie.new
trie.add("dog")
trie.add("dogs")
trie.add("dogma")

puts trie.inspect

assert_equal(trie.have?("dog"), true)
assert_equal(trie.have?("dogs"), true)
assert_equal(trie.have?("dogma"), true)
assert_equal(trie.have?("do"), true)
assert_equal(trie.have?("doomas"), false)
assert_equal(trie.have?("dogmas"), false)
assert_equal(trie.have?(""), true)
