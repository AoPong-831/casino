class ReceptionsController < ApplicationController
  def index
    @receptions = Reception.all()
  end
  
  def show
    reception = Reception.find(params[:id])
    user = User.find_by(id: reception.user_id)
    
    #moneyに変更を加える
    if reception.flag == 1 then
      user.money -= reception.money
    elsif reception.flag == 2 then
      user.money += reception.money
    else
      
    end
    
    #記帳
    require 'date'
    day = Date.today
    passbook = File.open("passbooks/" + user.name + ".txt","a")
    passbook.write(day.to_s + ":" + user.money.to_s + "\n")
    passbook.close
    
    user.save
    reception.delete
  end
  
  def destroy
    reception = Reception.find(params[:id])
    reception.destroy
    
    redirect_back(fallback_location: "receptions/index")
  end
  
end
