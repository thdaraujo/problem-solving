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

  def delete(key)  
    node = tree
    delete_recursive(key, node)

    nil
  end

  private

  def delete_recursive(key, parent)
    return if key.nil? || key.empty? || parent.nil?

    head, tail = key[0], key[1..-1]

    child = parent[head] 
    delete_recursive(tail, child)

    if key.size == 1 && child.key?(:terminal)
      child.delete(:terminal)
    end
    
    if child.keys.empty?
      parent.delete(head) # prune tree
    end
  end

  attr_reader :tree
end

require 'test/unit/assertions'
include Test::Unit::Assertions

words = ['dog', 'dogs', 'dogma', 'dogmas', 'dogmatic', 'apple', 'apples']
trie = Trie.new

words.each do |word|
  trie.add(word)
end

words.each do |word|
  assert_equal(trie.have?(word), true)
end

assert_equal(trie.have?('do'), false)
assert_equal(trie.have?('doomas'), false)
assert_equal(trie.have?(''), false)

words.each do |word|
  assert_equal(trie.starts_with?(word), true)
end

assert_equal(trie.starts_with?('d'), true)
assert_equal(trie.starts_with?('do'), true)
assert_equal(trie.starts_with?('dogma'), true)
assert_equal(trie.starts_with?('app'), true)
assert_equal(trie.starts_with?(''), true)

assert_equal(trie.starts_with?('e'), false)
assert_equal(trie.have?('dogss'), false)


# delete
trie.delete('dogma')
words.delete('dogma')

words.each do |word|
  assert_equal(trie.have?(word), true)
end

assert_equal(trie.have?('dogma'), false)

words.each do |word|
  assert_equal(trie.starts_with?(word), true)
end

assert_equal(trie.starts_with?('d'), true)
assert_equal(trie.starts_with?('do'), true)
assert_equal(trie.starts_with?('dogma'), true)
assert_equal(trie.starts_with?(''), true)
assert_equal(trie.starts_with?('e'), false)
assert_equal(trie.have?('dogss'), false)

trie.delete('apple')
words.delete('apple')

assert_equal(trie.have?('apple'), false)
assert_equal(trie.have?('apples'), true)
assert_equal(trie.starts_with?('apple'), true)

trie.delete('apples')
words.delete('apples')

assert_equal(trie.have?('apple'), false)
assert_equal(trie.have?('apples'), false)
assert_equal(trie.starts_with?('apple'), false)
