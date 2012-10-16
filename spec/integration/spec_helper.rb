path = File.expand_path "../../../", __FILE__
require "spec_helper"

require 'rack/test'

def app
  TenCard
end
include Rack::Test::Methods

enable :sessions

require "#{path}/tencard"


# spec helpers

def body
  last_response.body
end

def referer
  location = last_response.headers["Location"]
  location.gsub(/http:\/\/example\.org/, '') if location
end

def login(user)
  session[:user_id] = user.id
end

def app.current_user
  $spec_current_user
end

def login(user=User.first)
  $spec_current_user = user
end

def clear_login
  $spec_current_user = nil
end

module PageMatchers
  class PageContain
    def initialize(expected)
      @expected = expected.to_s.strip
    end
    def matches?(target)
      @target = target
      return false if @expected.blank?
      @target.include? @expected
    end
    def failure_message
      unless @expected.blank?
        "expected #{@target.inspect} to contain #{@expected.inspect}"
      else
        "this contained value is a blank string, you can't check if a blank string is contained in your page"
      end
    end
    def negative_failure_message
      "expected #{@target.inspect} to not contain #{@expected.inspect}"
    end
  end

  def contain(expected)
    PageContain.new expected
  end
end

RSpec.configure do |config|
  config.include(PageMatchers)
end