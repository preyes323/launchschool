print 'Please write word or multiple words: '
phrase = gets.chomp

num_characters = phrase.tr(' ', '').size

puts "There are #{num_characters} characters in \"#{phrase}\""
