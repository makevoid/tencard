require_relative "spec_helper"

describe "Shops" do
  it "GET /shops" do
    get "/shops"
    body.should =~ /Shops/
    Shop.all.each do |shop|
      body.should contain shop.name
    end
  end

  it "GET /shop/:id" do
    shop = Shop.first
    get "/shops/#{shop.id}"
    body.should contain shop.name
  end
end