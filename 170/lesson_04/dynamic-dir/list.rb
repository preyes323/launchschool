require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

get_files = lambda do
  @files = Dir.glob('public/*.*').map { |file| File.basename(file) }.sort
  @files.reverse! if params['sort'] == 'desc'

  erb :list
end

get '/', &get_files
get '/list', &get_files
