class Purchase
  include DataMapper::Resource

  property :id,      Serial
  property :amount,  Float
  property :notes,   String

  belongs_to :user

  attr_accessor :card_code

end