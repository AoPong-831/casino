class ReceptionsController < ApplicationController
  def index
    @receptions = Reception.all()
  end
  
  def show
    reception = Reception.find(params[:id])
    user = User.find_by(id: reception.user_id)
    
    if reception.flag == 1 then
      user.money -= reception.money
    elsif reception.flag == 2 then
      user.money += reception.money
    else
      
    end
    
    user.save
    reception.delete
  end
  
  def destroy
    reception = Reception.find(params[:id])
    reception.destroy
    
    redirect_back(fallback_location: "receptions/index")
  end
end
