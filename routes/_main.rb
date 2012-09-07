class TenCard < Sinatra::Base
  get "/" do
    haml :index
  end
end
