path = File.expand_path '../', __FILE__

require "#{path}/config/env.rb"

class TenCard < Sinatra::Base
  include Voidtools::Sinatra::ViewHelpers

  set :session_secret, 'antanisblindacomesepiovesse'

  @@path = File.expand_path '../', __FILE__

  require "#{@@path}/lib/app_helpers"
  include AppHelpers
  require "#{@@path}/lib/form_helpers"
  include FormHelpers

  def partial(name, value={})
    locals = if value.is_a? Hash
      value
    else
      hash = {}; hash[name] = value
      hash
    end
    haml "_#{name}".to_sym, locals: locals
  end

  # flash messages

  def flash
    @@flashes ||= {}
  end

  after do
    @@flashes = {}
  end

end

require_all "#{path}/routes"
LOAD_MODULES_ROUTES.call