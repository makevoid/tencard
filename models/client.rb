require "#{PATH}/exts/auth/models/user"

class Client
  def self.all(params={})
    User.members.all params
  end

  def self.first(params={})
    User.members.first params
  end

  def self.create(params={})
    User.members.create params
  end

  def self.get(id)
    User.get id
  end
end