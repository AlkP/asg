class VisasController < ApplicationController
  def index
    @visas = Visa.all_alkp.order('updated_at ASC')
  end
  def new
    @visa = Visa.new
  end
  def create
    visa = Visa.create(visas_params)
    visa.save
    @visas = Visa.all_alkp.order('updated_at DESC')
  end
  def destroy
    visa = Visa.find(params[:id])
    #visa.destroy
    Visa.destroy visa
    @visas = Visa.all_alkp.order('updated_at DESC')
  end
  def show
    @visa = Visa.find(params[:id])
  end
  def update
    visa = Visa.find(params[:id])
    visa.update(visas_params)
    @visas = Visa.all_alkp.order('updated_at DESC')
  end
  private
  def visas_params
    params.require(:visa).permit( :country_id,
                                   :partner_id,
                                   :duration,
                                   :cost )
  end
end
