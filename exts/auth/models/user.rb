class User
  include DataMapper::Resource

  CARD_CODE_LENGTH = 8

  ROLES = [ :member, :shop, :admin ]

  property :id,         Serial
  property :username,   String, length: 100, required: true, unique: true
  property :role,       Enum[*ROLES], default: ROLES[0]
  property :password,   String, required: true, length: 5..50
  property :salt,       String
  property :card_code,  String
  property :first_name, String#, required: true
  property :last_name,  String#, required: true
  property :address,    String
  property :email,      String

  has n, :purchases, child_key: [:client_id]
  has n, :sales, "Purchase", child_key: [:shop_id]

  default_scope(:default).update order: :id.desc

  ROLES.each do |role|
    define_method "#{role}?" do
      self.role == role
    end
  end

  # attributes

  def name
    "#{first_name} #{last_name}".strip
  end

  # filters

  def self.members
    all role: "member"
  end

  def self.shops
    all role: "shop"
  end

  def self.admins
    all role: "admin"
  end

  # actions

  # actions (shop)

  def register_purchase(client, amount, notes=nil)
    self.sales.create amount: amount, notes: notes, client: client
  end

  # card code

  before :create, :genereate_card_code

  def genereate_card_code
    return if self.card_code
    code = ""
    CARD_CODE_LENGTH.times{ code << rand(9).to_s }
    self.card_code = code
  end

  # shop

  def sales_amount
    sales.sum(:amount) || 0
  end

  def sales_count
    sales.count
  end

  # authentication

  require 'digest/sha2'

  attr_accessor :password_confirmation

  validates_confirmation_of :password


  before :create do
    generate_salt
    self.password = crypt_password self.password
  end

  def password?(pass)
    self.password == crypt_password(pass)
  end

  def crypt_password(pass)
    hexdigest "#{self.salt}comesefosse#{pass}"
  end

  def generate_salt
    self.salt = hexdigest "#{Time.now}sblinda"
  end

  def hexdigest(string)
    Digest::SHA2.hexdigest(string)[0..49]
  end

end