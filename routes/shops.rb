class TenCard < Sinatra::Base

  get "/shops" do
    haml :shops
  end

end
