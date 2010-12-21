require 'rubygems'
require 'sinatra'
require 'ohm'

class Request < Ohm::Model
  attribute :route
  attribute :body
  index :route
end

get '/' do
  [200, "I <a href='/listen/'>listen</a> out for things and then <a href='/repeat/'>repeat</a> what I've heard"]
end

get '/listen/' do
  "Tell me about a thing by POSTing to the <a href='/listen/foo'>/listen/*</a> URI"
end

get '/listen/:something' do
  [405, "I can only hear things that are 'POST'ed"]
end

post '/listen/:something' do
  request.body.rewind
  Request.create :route => params[:something], 
                  :body => request.body.read
end

get '/repeat/' do
  "If you want to know what I've heard about something, add it to the URI: e.g. <a href='/repeat/crackers'>/repeat/crackers</a> will tell you what was POSTed there."
end

get '/repeat/:something' do
  route_name = params[:something]
  first_request = find_requests_for(route_name)
  if first_request == nil
    response_for_request_not_found(route_name)
  else
    first_request.body
  end
end

delete '/listen/:something' do
  route_name = params[:something]
  first_request = find_requests_for(route_name)
  if first_request == nil
    response_for_request_not_found(route_name)
  else
    first_request.delete
    204
  end
end

delete '/all' do
  Ohm.flush
  204
end

def find_requests_for(route)
  Request.find(:route => params[:something]).sort(:order => "DESC").first
end

def response_for_request_not_found(route_name)
  [404, "I never heard anything about '#{route_name}'"]
end

