path = File.expand_path '../../', __FILE__
APP = "phidgets"

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
# DataMapper.setup :default, "mysql://localhost/phidgets_#{env}"
DataMapper.setup :default, adapter: "in_memory"

require_all "#{path}/models"

require "#{path}/config/sinatra_exts.rb"

DataMapper.finalize


# datas (in-memory)

USERS = [
  { username: "Mario",    card_id: "123" },
  { username: "Luigi",    card_id: "456" },
  { username: "Antonio",  card_id: "789" },
  { username: "Piero",    card_id: "012" },
  { username: "Tizio",    card_id: "234" },
  { username: "Caio",     card_id: "567" },
  { username: "Antani",   card_id: "890" },
  { username: "Sblinda",  card_id: "345" }
]

USERS.each do |user|
  User.create user
end
