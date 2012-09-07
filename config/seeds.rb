path = File.expand_path "../../", __FILE__

require "#{path}/config/env"

DataMapper.auto_migrate!

users_common = { password: "secret", password_confirmation: "secret" }

USERS = [
  { username: "Piero",    card_code: "012" },
  { username: "Tizio",    card_code: "234" },
  { username: "Caio",     card_code: "567" },
  { username: "Antani",   card_code: "890" },
  { username: "Sblinda",  card_code: "345" },
  { username: "Mario",    card_code: "123" },
  { username: "Luigi",    card_code: "456" },
  { username: "Antonio",  card_code: "789" },
  { username: "admin",  role: "admin"  },
  { username: "shop", role: "shop"  },
  { username: "Playground", role: "shop"  },
  { username: "Zara", role: "shop"  },
]

USERS.each do |user|
  u = User.new user.merge(users_common)
  u.save
  p u.errors if u.errors.size > 0
end