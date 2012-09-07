class TenCard < Sinatra::Base

  get "/purchases" do
    haml :purchases
  end

  get "/purchases/new" do
    @purchase = Purchase.new
    haml :purchases_new
  end

end
