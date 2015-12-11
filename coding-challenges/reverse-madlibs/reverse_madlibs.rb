# reverse_madlibs.rb
# My implementation of reverse madlibs. Try it out with your own story =)
require 'pry'

def exit_with(msg)
  puts "=> #{msg}"
  exit
end

exit_with("No input file!") if ARGV.empty?
exit_with("File doesn't exist!") if !File.exists?(ARGV[0])

dictionary = { 'nouns' => [], 'verbs' => [], 'adjectives' => [] }

dictionary.each_key do |key|
  dictionary[key] = File.open(key + '.txt', 'r') do |file|
    file.read
  end.split
end

contents = File.open(ARGV[0], 'r') do |file|
  file.read
end

dictionary.each_key do |key|
  contents.gsub!(key.chomp('s').upcase).each do
    dictionary[key].sample
  end
end

p contents
