require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"

before do
  @contents = File.readlines("data/toc.txt")
end

get "/" do
  @title = 'The Adventures of Sherlock Holmes'
  erb :home
end

get "/chapters/:number" do
  number = params['number'].to_i
  ch_name = @contents[number - 1]

  @title = "Chapter #{number}: #{ch_name}"
  @chapter = File.read("data/chp#{number}.txt")

  erb :chapter
end
