$: << File.expand_path(File.dirname(__FILE__) + "/..")
require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'http_parrot_app'

set :environment, :test
#set :run, false
#set :raise_errors, true
#set :logging, false

RSpec.configure do |config|
  config.before :each do
    Ohm.flush
  end
  config.after :each do
    Ohm.flush
  end
end
