class TenCard < Sinatra::Base

  get "/purchases" do
    @purchases = if admin?
      Purchase.all
    else
      current_user.sales
    end
    haml :purchases
  end

  get "/purchases/new" do
    @purchase = Purchase.new
    haml :purchases_new
  end

  post "/purchases" do
    shop = current_user
    params[:purchase] = {} unless params[:purchase]
    client = User.first card_code: params[:purchase][:card_code]
    @purchase = shop.register_purchase client, params[:purchase][:amount], params[:purchase][:notes]
    if @purchase.save
      flash[:notice] = "Acquisto registrato!"
      redirect "/purchases"
    else
      haml :purchases_new
    end
  end

end
