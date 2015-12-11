def palindrome?(word)
  word.downcase!
  original_word = word
  word = word.chars
  idx = -1
  word.each do |char|
    return false if char != original_word[idx] && ('a'..'z').include?(char)
    idx -= 1
  end
  true
end

def numeric?(char)
  !!Float(char) rescue false
end

puts "is 'motor' considered a palindrome? result =  #{palindrome?('motor')}"
puts "is 'rotor' considered a palindrome? result =  #{palindrome?('rotor')}"
puts "is 'no1, 3on' considered a palindrome? result =  #{palindrome?('no1, 3on')}"
puts "is ' ' considered a palindrome? result =  #{palindrome?(' ')}"
puts "is 'I' considered a palindrome? result =  #{palindrome?('I')}"
puts "is '' considered a palindrome? result =  #{palindrome?('')}"
