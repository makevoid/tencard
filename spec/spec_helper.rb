path = File.expand_path "../../", __FILE__

ENV["RACK_ENV"] = "test"

require "#{path}/config/env"

DataMapper.auto_migrate!


users_common = { password: "secret", password_confirmation: "secret" }

USERS = [
  { username: "supermario", first_name: "Mario",    last_name: "Rossi", card_code: "12345678" },
  { username: "pieropiu",   first_name: "Piero",    last_name: "Verdi", card_code: "87654321" },
  { username: "anto",       first_name: "Antonio",  last_name: "Bianchi"  },
  { username: "admin",      role: "admin" },
  { username: "playground", role: "shop", first_name: "Playground" },
  { username: "zara",       role: "shop", first_name: "Zara" },
]

USERS.each do |user|
  u = User.new user.merge(users_common)
  u.save
  p u.errors if u.errors.size > 0
end