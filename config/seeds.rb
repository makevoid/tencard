path = File.expand_path "../../", __FILE__

require "#{path}/config/env"

DataMapper.auto_migrate!

users_common = { password: "secret", password_confirmation: "secret" }

USERS = [
  { username: "supermario", first_name: "Mario",    last_name: "Rossi", card_code: "12345678" },
  { username: "pieropiu",   first_name: "Piero",    last_name: "Verdi", card_code: "87654321" },
  { username: "tizi1",     first_name: "Tiziano",  last_name: "Prova"    },
  { username: "anto",       first_name: "Antonio",  last_name: "Bianchi"  },
  { username: "admin",      role: "admin", first_name: "Admin" },
  { username: "shop",       role: "shop", first_name: "Shop prova", address: "viale Redi, 1 - Firenze" },
  { username: "playground", role: "shop", first_name: "Playground", address: "via G. Don Minzoni, 31 - Firenze" },
  { username: "zara",       role: "shop", first_name: "Zara", address: "via Calimala, 17 - Firenze" },
]

USERS.each do |user|
  u = User.new user.merge(users_common)
  u.save
  p u.errors if u.errors.size > 0
end


client = Client.first username: "supermario"
shop = Shop.first username: "shop"
shop.register_purchase client, 20, "maglia"