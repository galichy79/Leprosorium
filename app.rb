
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'bundler/setup'
require 'sqlite3'

get '/' do 
  erb 'Hello'
end

get '/new' do
  erb "Hello World"
end
