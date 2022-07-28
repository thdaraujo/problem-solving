def histogram(s)
    s.downcase.chars.group_by(&:itself).transform_values(&:count)
end

def anagram?(a, b)
    histogram(a) == histogram(b)
end

def count_anagrams(arr)
    counts = arr.group_by do |word|  
        histogram(word)
    end
    .transform_values(&:count)
    .count{|k, v| v > 1 }
end

def palindrome?(sentence)
    s = sentence.gsub(/\W+/, '').downcase
    s == s.reverse
end

def palindrome_recur?(sentence)
    return true if sentence.size < 2
    sentence[0] == sentence[-1] && palindrome_recur?(sentence[1...-1])
end

# tests

require 'test/unit/assertions'
include Test::Unit::Assertions

def anagram_test
    assert_equal anagram?("listen", "silent"), true
    assert_equal anagram?("foo", "bar"), false
end

def count_anagrams_test
    sentences = ["bob",
     "bob",
     "rats live on", 
     "no evil star",
     "no lemon",
     "no melon",
     "noxin",
     "nixon",
     "evil rat",
     "tar live",
     "listen",
     "silent",
     "foo",
     "bar",
     "baz"
    ]
    assert_equal count_anagrams(sentences), 6
end

def lyrics
%(I, man, am Regal, a German am I
Never odd or even
If I had a Hi-Fi
Madam, I'm Adam
Too hot to hoot
No lemon no melon
Too bad I hid a boot
Lisa Bonet ate no basil
Warsaw was raw
Was it a car or a cat I saw?
Rise to vote, sir
Do geese see God?
Do nine men Interpret? Nine men I nod
Rats live on no evil star
Won't lovers revolt now?
Race fast safe car
Pa's a sap
Ma is as selfless as I am
May a moody baby doom a yam
Ah Satan sees Natasha
No devil lived on
Lonely Tylenol
Not a banana baton
No X in Nixon
O stone, be not so
O Geronimo, no minor ego
"Naomi" I moan
A Toyota's a Toyota
A dog, a panic, in a pagoda
Oh no, Don Ho
Nurse, I spy gypsies, run!
Senile felines
Now I see bees, I won
UFO tofu
We panic in a pew
Oozy rat in a sanitary zoo
God, a red nugget, a fat egg under a dog
Go hang a salami, I'm a lasagna hog)
end

def palindromes_test
    lyrics.split("\n").each do |sentence|
        assert_equal palindrome?(sentence), true
    end
    assert_equal palindrome?("eleven dollar bills"), false
    assert_equal palindrome?("thinking about the government"), false
end

def palindromes_recur_test
    assert_equal palindrome_recur?([]), true
    assert_equal palindrome_recur?([1]), true
    assert_equal palindrome_recur?([1, 0, 1]), true
    assert_equal palindrome_recur?([1, 1, 1]), true
    assert_equal palindrome_recur?([1, 2, 2, 1]), true
    assert_equal palindrome_recur?("warsawwasraw"), true
    
    assert_equal palindrome_recur?([1, 2, 2, 3]), false
    assert_equal palindrome_recur?("eleven dollar bills"), false
    assert_equal palindrome_recur?("thinking about the government"), false
end

anagram_test
count_anagrams_test
palindromes_test
palindromes_recur_test