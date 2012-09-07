class User

  include DataMapper::Resource

  property :id, Serial
  property :username, String
  property :card_id, String

end