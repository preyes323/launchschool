require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'
require 'yaml'
require 'pry'

before do
  @users = YAML.load_file('public/users.yml')
  @interests = count_interests(@users)
end

get "/" do
  binding.pry
  erb :home
end

helpers do
  def count_interests(users)
    users.values.reduce(0) { |total, info| total + info[:interests].size }
  end
end
