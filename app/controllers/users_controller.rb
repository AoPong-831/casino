class UsersController < ApplicationController
    def index
        @user = User.find(params[:id])
    end
    
    def new
        @user = User.new 
    end
    
    def create
        require 'date'
        day = Date.today
        #@user =  User.new(name: params[:user][:name], pass: BCrypt::Password.create(params[:user][:pass]), money: 1000, debt: 0, visits: 1, final_date: day)
        @user =  User.new(name: params[:user][:name], password: params[:user][:password], password_confirmation:params[:user][:password_confirmation], money: 1000, debt: 0, visits: 1, final_date: day)
        #@users = User.new(uid: params[:user][:uid], password: params[:user][:password], password_confirmation:params[:user][:password_confirmation])
        if @user.save
            #flash[:notice] = ''
            redirect_to '/'
        else
            #flash[:notice] = 'パスワードとパスワード確認が一致しません'
            render 'new'
            #redirect_to '/'
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
  
    def withdraw
        @user = User.find(params[:id])
    end
    
    def deposit
        @user = User.find(params[:id])
    end
    
    def edit#withdraw, depositで更新するとここに来るはず
        @user = User.find(params[:id])
    end
    
    def update
       @user = User.find(params[:id])
        if params[:type] == "withdraw" then#ATM取引、預入、引出を判断
            #changed_money = @user.money - params[:user][:money].to_i
            Reception.create(user_id: @user.id, money: params[:user][:money], flag: 1)
        elsif params[:type] == "deposit" then
            Reception.create(user_id: @user.id, money: params[:user][:money], flag: 2)
        else#エラー対応
            
        end
        redirect_to "/", notice: "取引を申請中です。"
    end
end
