# frozen_string_literal: true

require 'test/unit/assertions'

class BinarySearch
  def self.search_index(arr, element)
    arr.sort! # must be sorted

    left = 0
    right = arr.size - 1

    while left <= right
      middle = left + (right - left) / 2
      return middle if arr[middle] == element

      if arr[middle] < element
        left = middle + 1
      else
        right = middle - 1
      end
    end
    nil
  end
end

include Test::Unit::Assertions

def simple_test
  arr = [1, 2, 3, 4, 5]
  arr.each do |el|
    assert_equal BinarySearch.search_index(arr, el), arr.index(el)
  end
  assert_equal BinarySearch.search_index(arr, -1), nil
end

simple_test
