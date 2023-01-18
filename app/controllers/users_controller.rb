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
        #通帳(passbook)作成
        passbook = File.new("passbooks/" + @user.name.to_s + ".txt","w")
        passbook.write(day.to_s + ":" + @user.money.to_s)
        passbook.close
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
        message = "初期エラー発生が発生しましたs"#デフォルトメッセージ
        if params[:type] == "withdraw" then#ATM取引、預入、引出を判断
            if 0 > (@user.money - params[:user][:money].to_i) then#引き出し額が持ち金より多い場合
                message = "引き出し額が所持金を超えています"
            elsif params[:user][:money].to_i <= 0 then#入力額が0以下の場合
                message = "入力額が不正です"
            else
                Reception.create(user_id: @user.id, money: params[:user][:money], flag: 1)
                message = "取引を申請中です"
            end
        elsif params[:type] == "deposit" then
            if params[:user][:money].to_i <= 0 then#入力額が0以下の場合
                message = "入力額が不正です"
            else
                Reception.create(user_id: @user.id, money: params[:user][:money], flag: 2)
                message = "取引を申請中です"
            end
        else#エラー対応
            message = "取引中にエラーが発生しました"
        end
        flash[:notice] = message
        redirect_to "/"
    end
end
