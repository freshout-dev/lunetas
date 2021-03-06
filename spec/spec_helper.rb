$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'lunetas'
require 'rspec'

RSpec.configure do |config|
  
end

def mock_candy
  body = [200, {'Content-Type' => 'text/html'}, ["body"]]
  luneta_object = mock(:Luneta, :bite => body)
  [mock(:Luneta, :new => luneta_object), luneta_object]
end

def mock_env(path)
  Rack::MockRequest.env_for(path)
end

class TestClass
  include Lunetas::Candy
  matches '/just_a_test'
  def get
    'Chunky Bacon'
  end
  def other_verb(verb)
    if verb == 'REDIRECT'
      redirect 'http://example.com'
    end
  end
end

class TestException < Lunetas::Error::BaseError
  def code
    400
  end
  def message
    'a'
  end
end


