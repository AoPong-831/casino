class UsersController < ApplicationController
    def index
        @users = User.all
    end
    
    def new
        @user = User.new 
    end
    
    def create
        @user =  User.new(name: params[:user][:name], pass: BCrypt::Password.create(params[:user][:pass]))
        if @user.save
            redirect_to '/'
        else
            #render 'new'
            redirect_to '/'
        end
    end
    def destroy
        b = User.find(params[:id])
        b.destroy
        redirect_to root_path
    end
  
    def show
        @users = User.find(params[:id])
    end
  
    
  
    
end
