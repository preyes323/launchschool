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
  erb :home
end

get "/users/:user" do
  filtered_users = @users.select { |name| name.to_s != params[:user] }
  @interests = count_interests(filtered_users)
  erb :user
end

helpers do
  def count_interests(users)
    users.values.reduce(0) { |total, info| total + info[:interests].size }
  end
end
