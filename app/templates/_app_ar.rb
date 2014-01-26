# encoding: utf-8
require 'multi_json'
require 'sinatra'
require 'sinatra/activerecord'

class <%= _.capitalize(baseName) %> < Sinatra::Application
  enable :sessions

  configure :development do
    set :database, "sqlite3:///tmp/my.db"
  end

  configure :production do
    set :database, 'postgres://postgres:12345@localhost/sinatra_service'
  end
end

require_relative 'helpers/init'
require_relative 'models/init'
require_relative 'routes/init'
