class TenCard < Sinatra::Base

  enable :sessions
  use Rack::Session::Cookie


  def login_required
    redirect "/login" unless current_user
  end

  def member_required
    halt 403, haml_mod(:member_required) unless member?
  end

  def admin_required
    halt 403, haml_mod(:admin_required) unless admin?
  end


  def current_user
    return self.class.current_user if defined?(self.class.current_user) # for test sake
    if id = session[:user_id]
      User.get id
    end
  end

  def logged_in?
    current_user
  end

  def admin?
    current_user && current_user.admin?
  end

  def shop?
    current_user && (admin? || current_user.shop?)
  end

  def member?
    current_user && (admin? || current_user.member?)
  end

  def me?
    @user == current_user
  end

  get "/login" do
    haml_mod :login
  end

  post "/sessions" do
    @user = User.first(username: params[:user][:username]) if params[:user]
    if @user && @user.password?(params[:user][:password])
      flash[:notice] = "Accesso effettuato!"
      session[:user_id] = @user.id
      redirect "/"
    else
      flash[:alert] = "Username o password non validi."
      haml_mod :login
    end
  end

  post "/logout" do
    session[:user_id] = nil
    redirect "/"
  end
end