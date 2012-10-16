require "#{PATH}/exts/auth/models/user"

class Shop
  def self.all(params={})
    User.shops.all params
  end

  def self.first(params={})
    User.shops.first params
  end

  def self.create(params={})
    User.shops.create params
  end

  def self.get(id)
    User.get id
  end
end