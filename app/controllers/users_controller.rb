class UsersController < ApplicationController
    def index
        @users = User.all
    end
    
    def new
        @users = User.new 
    end
    
    def create
        
        @users =  User.new(name: params[:user][:name], pass: BCrypt::Password.create(params[:user][:pass]))
        #@users = User.new(uid: params[:user][:uid], password: params[:user][:password], password_confirmation:params[:user][:password_confirmation])
        
        
        #@users = User.new(uid: params[:user][:uid], pass: params[:user][:pass])
        if @users.save
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
