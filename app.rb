
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'bundler/setup'
require 'sqlite3'

get '/' do 
  erb 'Hello'
end

get '/new' do
  erb :new
end

post '/new' do
  content = params[:content]
  erb "You typed #{content}"
  # <%=  %>
end
