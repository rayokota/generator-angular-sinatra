# encoding: utf-8
class <%= _.capitalize(baseName) %> < Sinatra::Application
  get '/' do 
    send_file File.join('public', 'index.html')
  end
end
