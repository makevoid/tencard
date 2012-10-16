class TenCard < Sinatra::Base

  get "/shops" do
    haml :shops
  end

  get "/shops_admin" do
    haml :shops_admin
  end

  get "/shops/:id" do
    @shop = Shop.get params[:id]
    @purchases = @shop.sales if admin?
    haml :shop
  end

end
