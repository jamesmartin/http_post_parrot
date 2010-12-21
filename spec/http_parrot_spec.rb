require 'spec_helper'

describe "HttpParrot" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "should run a simple test" do
    get '/'
    last_response.should be_ok
  end

  it "persists posted values" do
    post '/listen/foo', "abc"
    get '/repeat/foo'
    last_response.body.should =~ /abc/
  end

  it "persists other values" do
    post '/listen/bar', "def"
    get '/repeat/bar'
    last_response.body.should =~ /def/
  end

  it "persists more than one route at a time" do
    post '/listen/foo', "abc"
    post '/listen/bar', "def"
    get '/repeat/foo'
    last_response.body.should =~ /abc/
    get '/repeat/bar'
    last_response.body.should =~ /def/
  end

  it "gets the latest thing posted for a given route" do
    post '/listen/foo', "abc"
    post '/listen/foo', "def"
    get '/repeat/foo'
    last_response.body.should =~ /def/
  end

  it "forgets what it knows about a request" do
    post '/listen/bar', "def"
    delete '/listen/bar'
    # 204 = enacted but does not return an entity in the response body
    last_response.status.should == 204 
    get '/repeat/bar'
    last_response.status.should == 404
  end

  it "forgets what it knows about all requests" do
    post '/listen/bar', "def"
    post '/listen/bar', "abc"
    post '/listen/bar', "xyz"
    delete '/all'
    # 204 = enacted but does not return an entity in the response body
    last_response.status.should == 204 
    get '/repeat/bar'
    last_response.status.should == 404
  end

  it "returns 404 if the route hasn't been recorded" do
    post '/listen/foo', "def"
    get '/repeat/bar'
    last_response.status.should == 404
    last_response.body.should =~ /I never heard anything about 'bar'/
  end

  it "gives you a hint if try to GET /remember" do
    get '/listen/foo'
    last_response.status.should == 405
    last_response.body.should =~ /^.*hear.*POST.*/
  end

end

