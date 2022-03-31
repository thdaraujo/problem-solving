class Trie < Hash
  def initialize
    super
  end

  def add(key)
    last_index = key.size - 1

    key.chars.each_with_index.inject(self) do |hash, (char, index)|
      unless hash[char]
        hash[char] = {}
      end

      hash[char][:end] = true if index == last_index

      hash[char]
    end

    nil
  end

  def have?(key)
    hash = self
    key.each_char do |char|
      return false if hash.nil?
      return false if hash[char].nil?
      hash = hash[char]
    end

    hash.keys.include?(:end)
  end

  def starts_with?(word)
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

assert_equal(trie.have?("dog"), true)
assert_equal(trie.have?("dogs"), true)
assert_equal(trie.have?("dogma"), true)
assert_equal(trie.have?("do"), false)
assert_equal(trie.have?("doomas"), false)
assert_equal(trie.have?("dogmas"), false)
assert_equal(trie.have?(""), false)

assert_equal(trie.starts_with?("d"), true)
assert_equal(trie.starts_with?("dog"), true)
assert_equal(trie.starts_with?("dogs"), true)
assert_equal(trie.starts_with?("dogma"), true)
assert_equal(trie.starts_with?("do"), true)
assert_equal(trie.starts_with?("doomas"), false)
assert_equal(trie.starts_with?("dogmas"), false)
assert_equal(trie.starts_with?(""), true)
