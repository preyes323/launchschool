require 'pry'
require "tilt/erubis"
require "sinatra"
require "sinatra/reloader" if development?

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
    @chapters = @contents.each_with_index.each_with_object({}) do |(_, idx), result|
      result[idx + 1] = phrase_indexes(load_chapter("data/chp#{idx + 1}.txt"), @phrase)
    end.delete_if { |_, value| value.empty? }
  end

  erb :search
end

not_found do
  redirect '/'
end

helpers do
  def in_paragraphs(content)
    paragraphs(content).each_with_index.map do |paragraph, number|
      "<p id=paragraph#{number}>#{paragraph}</p>"
    end.join
  end

  def paragraphs(content)
    content.split("\n\n")
  end

  def phrase_indexes(chapter, phrase)
    paragraphs(chapter).each_with_index
      .each_with_object({}) do |(paragraph, index), results|
      results[index] = paragraph if paragraph =~ /#{phrase}/
    end
  end

  def load_chapter(chapter)
    File.read(chapter)
  end
end
