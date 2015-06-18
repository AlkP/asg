class TownsController < ApplicationController
  def index
    @country = Country.find(params[:country_id])
    @towns = Town.all_alkp.where('country_id = ?', params[:country_id])
  end
  def new
    @country_id = params[:country_id]
    @town = Town.new
  end
  def create
    town = Town.create(towns_params)
    town.save
    @country = Country.find(params[:town][:country_id])
    @towns = Town.all_alkp.where('country_id = ?', params[:town][:country_id]).order('updated_at DESC')
  end
  def destroy
    town = Town.find(params[:id])
    @country = Country.find(town.country_id)
    #town.destroy
    Town.destroy town
    @towns = Town.all_alkp.where('country_id = ?', @country.id).order('updated_at DESC')
  end
  def show
    @town = Town.find(params[:id])
    @country_id = @town.country_id
  end
  def update
    town = Town.find(params[:id])
    town.update(towns_params)
    @towns = Town.all_alkp.where('country_id = ?', params[:town][:country_id]).order('updated_at DESC')
    @country = Country.find(params[:town][:country_id])
  end
  private
  def towns_params
    params.require(:town).permit( :name,
                                  :international_name,
                                  :country_id)
  end
end
