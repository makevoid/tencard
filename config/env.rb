path = File.expand_path '../../', __FILE__
APP = "tencard"

require "bundler/setup"
Bundler.require :default
module Utils
  def require_all(path)
    Dir.glob("#{path}/**/*.rb") do |model|
      require model
    end
  end
end
include Utils

env = ENV["RACK_ENV"] || "development"
DataMapper.setup :default, "mysql://localhost/tencard_#{env}"
# DataMapper.setup :default, adapter: "in_memory"

require_all "#{path}/models"

require "#{path}/lib/ruby_exts.rb"
require "#{path}/config/sinatra_exts.rb"

DataMapper.finalize