class TopController < ApplicationController
  def index
    @users = User.all
    #if current_user
      #render "main"
    #else
      #render "login"
    #end
  end
  
  def login_page
    
  end
  
  def login
    user = User.find_by(name: params[:name])
    if user && BCrypt::Password.new(user.pass) == params[:pass]
      session[:login_uid] = params[:name]
      redirect_to root_path
    else
      render 'error'
    end
  end
  
  def logout
        session.delete(:login_uid)
        redirect_to root_path
  end
end
