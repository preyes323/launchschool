require 'pry'
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
  @chapter = load_chapter("data/chp#{number}.txt")


  erb :chapter
end

get "/search" do
  @phrase = params[:query]
  if @phrase
    @chapters = @contents.each_with_index.select do |_, idx|
      phrase_exists?(load_chapter("data/chp#{idx + 1}.txt"), @phrase)
    end
  end

  erb :search
end

not_found do
  redirect '/'
end

helpers do
  def in_paragraphs(content)
    content.split("\n\n").map do |paragraph|
      "<p>#{paragraph}</p>"
    end.join
  end

  def phrase_exists?(chapter, phrase)
    chapter =~ /#{phrase}/
  end

  def load_chapter(chapter)
    File.read(chapter)
  end
end
