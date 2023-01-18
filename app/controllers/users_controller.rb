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
        passbook.write(day.to_s + ":" + @user.money.to_s + "\n")
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
        File.delete("passbooks/" + b.name + ".txt")
        if session[:login_uid] == admin then
            b.destroy
            
        else
            b.destroy
            session.delete(:login_uid)
        end
        
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
    
    def debt
        @user = User.find(params[:id])
    end
    
    def hensai
        @user = User.find(params[:id])
    end
    
    def yuushi
        @user = User.find(params[:id])
    end
    
    def confirm
        @user = User.find(params[:id])
    end
    
    def edit#withdraw, depositで更新するとここに来るはず
        @user = User.find(params[:id])
    end
    
    def update
        @user = User.find(params[:id])
        message = "初期エラー発生が発生しましたs"#デフォルトメッセージ
        if params[:flag] == "withdraw" then#ATM取引、預入、引出を判断
            if 0 > (@user.money - params[:user][:money].to_i) then#引き出し額が持ち金より多い場合
                message = "引き出し額が所持金を超えています"
                flash[:notice] = message
                redirect_back(fallback_location: "users/withdraw")
                
            elsif params[:user][:money].to_i <= 0 then#入力額が0以下の場合
                message = "入力額が不正です"
                flash[:notice] = message
                redirect_back(fallback_location: "users/withdraw")
                
            else
                Reception.create(user_id: @user.id, money: params[:user][:money], flag: 1)
                message = "取引を申請中です"
                flash[:notice] = message
                redirect_to "/"
            end
        elsif params[:flag] == "deposit" then
            if params[:user][:money].to_i <= 0 then#入力額が0以下の場合
                message = "入力額が不正です"
                flash[:notice] = message
                redirect_back(fallback_location: "users/deposit")
                
            else
                Reception.create(user_id: @user.id, money: params[:user][:money], flag: 2)
                message = "取引を申請中です"
                flash[:notice] = message
                redirect_to "/"
            end
        elsif params[:flag] == "yuushi" then
            @user.update(money: @user.money + 1000, debt: @user.debt + 1)
            message = "融資が完了しました"
            flash[:notice] = message
            redirect_to "/"
            
        elsif params[:flag] == "hensai" then
            if 0 == @user.debt
                message = "そもそも借金はしていません"
                flash[:notice] = message
                redirect_to "/"
                
            elsif 0 > (@user.money - params[:user][:kaisuu].to_i * 1500) then#引き出し額が持ち金より多い場合
                message = "返済額が所持金を超えています"
                flash[:notice] = message
                redirect_back(fallback_location: "users/hensai")
                
            elsif params[:user][:kaisuu].to_i <= 0 then#入力額が0以下の場合
                message = "入力値が不正です"
                flash[:notice] = message
                redirect_back(fallback_location: "users/hensai")
                
            elsif 0 > (@user.debt - params[:user][:kaisuu].to_i)
                @user.update(money: @user.money - 1500 * @user.debt, debt: 0)
                message = "入力値が借金回数より多かったですが返済は正常に完了しました"
                flash[:notice] = message
                redirect_to "/"
                
            else
                @user.update(money: @user.money - 1500 * params[:user][:kaisuu].to_i, debt: @user.debt - params[:user][:kaisuu].to_i)
                message = "返済が完了しました"
                flash[:notice] = message
                redirect_to "/"
            end
            #@user.money += 1000
            #@user.debt += 1
            
            #@user.save
        else#エラー対応
            message = "取引中にエラーが発生しました"
            flash[:notice] = message
            redirect_to "/"
        end
        #flash[:notice] = message
        #redirect_to "/"
    end
    
end
