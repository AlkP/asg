class SectorsController < ApplicationController
  def new
    @sector = Sector.new
  end
  def show
    @sector = Sector.find(params[:id])
  end
  def update
    sector = Sector.find(params[:id])
    if sector.update(sectors_params)
      redirect_to sectors_path
    else
      render 'show'
    end
  end
  def create
    sector = Sector.new(sectors_params)
    if sector.save
      redirect_to sectors_path
    else
      render 'new'
    end
  end
  def index
    @sectors = Sector.all_alkp
  end
  def destroy
    sector = Sector.find(params[:id])
    #sector.destroy
    Sector.destroy sector

    redirect_to sectors_path
  end
  private
  def sectors_params
    params.require(:sector).permit( :name)
  end
end
