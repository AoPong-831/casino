class ReceptionsController < ApplicationController
  def index
    @receptions = Reception.all()
  end
end
