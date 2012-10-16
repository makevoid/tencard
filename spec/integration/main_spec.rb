require_relative "spec_helper"

describe "TenCard" do
  it "GET /" do
    get "/"
    body.should contain "10Card"
  end
end