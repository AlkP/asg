class CountriesController < ApplicationController
  def new
    @country = Country.new
  end
  def create
    country = Country.create(countries_params)
    country.save
    @countries = Country.all_alkp.order('updated_at DESC')
  end
  def update
    country = Country.find(params[:id])
    country.update(countries_params)
    @countries = Country.all_alkp.order('updated_at DESC')
  end
  def show
    @country = Country.find(params[:id])
  end
  def destroy
    country = Country.find(params[:id])
    #country.destroy
    Country.destroy country
    @countries = Country.all_alkp.order('updated_at DESC')
  end
  def index
    @countries = Country.all_alkp.order('updated_at DESC')
  end
  private
  def countries_params
    params.require(:country).permit( :name,
                                     :international_name)
  end
end
