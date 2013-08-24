require 'rubygems'
require 'sinatra'
require 'mongo'
require 'json'

DB = Mongo::Connection.new.db("landa", :pool_size => 5, :timeout => 5)

not_found do
  send_file File.expand_path('404.html', settings.public_folder)
end

get '/' do
  haml :index
end

post '/signup' do
  oid = DB.collection('user').insert(JSON.parse(params.to_json))
  haml :confirmation, locals: { email: params[:email] }
end

