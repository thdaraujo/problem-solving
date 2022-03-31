class Trie
  def initialize
    @tree = {}
  end

  def add(key)
    key.chars.each_with_index.inject(tree) do |tree, (char, index)|
      tree[char] ||= {}
      tree[char][:terminal] = true if index == key.size - 1

      tree[char]
    end

    nil
  end

  def have?(key)
    node = tree
    key.each_char do |char|
      return false if node.nil? || node[char].nil?

      node = node[char]
    end

    node.key? :terminal
  end

  def starts_with?(word)
    node = tree
    word.each_char do |char|
      return false if node.nil? || node[char].nil?

      node = node[char]
    end

    true
  end

  private

  attr_reader :tree
end

require 'test/unit/assertions'
include Test::Unit::Assertions

trie = Trie.new
trie.add('dog')
trie.add('dogs')
trie.add('dogma')

assert_equal(trie.have?('dog'), true)
assert_equal(trie.have?('dogs'), true)
assert_equal(trie.have?('dogma'), true)
assert_equal(trie.have?('do'), false)
assert_equal(trie.have?('doomas'), false)
assert_equal(trie.have?('dogmas'), false)
assert_equal(trie.have?(''), false)

assert_equal(trie.starts_with?('d'), true)
assert_equal(trie.starts_with?('dog'), true)
assert_equal(trie.starts_with?('dogs'), true)
assert_equal(trie.starts_with?('dogma'), true)
assert_equal(trie.starts_with?('do'), true)
assert_equal(trie.starts_with?('doomas'), false)
assert_equal(trie.starts_with?('dogmas'), false)
assert_equal(trie.starts_with?(''), true)
