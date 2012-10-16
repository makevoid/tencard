require 'spec_helper'

describe Purchase do
  context "a shop" do
    it "registers a purchase" do
      client = User.members.first
      shop   = User.shops.first

      purchase = shop.register_purchase client, 15, "acquisto maglietta"

      Purchase.first.should == purchase
      Purchase.first.amount.should == 15
    end
  end
end