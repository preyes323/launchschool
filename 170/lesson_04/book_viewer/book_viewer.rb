require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"

get "/" do
  @title = 'The Adventures of Sherlock Holmes'
  @contents = File.read("data/toc.txt").split("\n")
  erb :home
end

get "/chapters/1" do
  @title = 'The Adventures of Sherlock Holmes'
  @contents = File.readlines("data/toc.txt")
  @chapter = File.read('data/chp1.txt')

  erb :chapter
end
