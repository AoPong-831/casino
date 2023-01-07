class TopController < ApplicationController
  def index
    @users = User.all.order(money: "DESC")
    #@users = User.all
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
      require 'date'
      day = Date.today
      #day = Date.yesterday
      yesterday = user.final_date
      
      user.update(final_date: day)
      if yesterday==day
        #user.update(visits: user.visits + 1)
      else
        user.update(visits: user.visits + 1)
      end
      
      #User.where(name: params[:name]).update(final_date: day)
      #User.where(name: "takaaki").update(name: "day")
      
      session[:login_uid] = params[:name]
      redirect_to root_path
    else
      #render 'error'
      render 'login_page'
    end
  end
  
  def logout
        session.delete(:login_uid)
        redirect_to root_path
  end
  
  def error
    
  end
  
end
