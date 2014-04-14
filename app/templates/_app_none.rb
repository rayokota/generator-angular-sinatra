# encoding: utf-8
require 'multi_json'
require 'sinatra'

class <%= _.capitalize(baseName) %> < Sinatra::Application
  enable :sessions

require_relative 'helpers/init'
require_relative 'routes/init'
