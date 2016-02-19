require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"

get "/" do
  @title = 'The Adventures of Sherlock Holmes'
  @contents = File.read("data/toc.txt").split("\n")
  erb :home
end

get "/chapters/:number" do
  @contents = File.readlines("data/toc.txt")

  number = params['number'].to_i
  ch_name = @contents[number - 1]

  @title = "Chapter #{number}: #{ch_name}"
  @chapter = File.read("data/chp#{number}.txt")

  erb :chapter
end
