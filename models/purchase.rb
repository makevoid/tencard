class Purchase
  include DataMapper::Resource

  DISCOUNT = 15 # %

  property :id,      Serial
  property :amount,  Float
  property :notes,   String

  belongs_to :client, 'User'
  belongs_to :shop,   'User'

  attr_accessor :card_code

  def discount
    amount.to_f / 100 * DISCOUNT
  end

end