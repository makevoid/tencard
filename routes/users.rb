class TenCard < Sinatra::Base

  get "/users" do
    haml :users
  end

  post "/user" do
    @user = User.create params[:user]
    redirect "/users"
  end

end
