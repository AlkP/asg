class PartnersController < ApplicationController
  def index
    if params[:id].nil?
      @partners = Partner.all_alkp.order('updated_at DESC')
      $types_partners_index = nil
    else
      @partners = Partner.all_alkp.where('types_partner_id = ?', params[:id]).order('updated_at DESC')
      $types_partners_index = params[:id].to_i
    end
  end
  def destroy
    partner = Partner.find(params[:id])
    #partner.destroy
    Partner.destroy partner
    @partners = Partner.all_alkp.order('updated_at DESC')
  end
  def new
    partner = Partner.create(name: "Новый партнер")
    partner.save
    @partners = Partner.all_alkp.order('updated_at DESC')
  end
  def show
    @partner = Partner.find(params[:id])
    @countries = Country.all_alkp
    @towns = Town.all_alkp
    @types_partners = TypesPartner.all_alkp
  end
  def update
    partner = Partner.find(params[:id])
    partner.update(partners_params)
    if $types_partners_index.nil?
      @partners = Partner.all_alkp
    else
      @partners = Partner.all_alkp.where('types_partner_id = ?', $types_partners_index).order('updated_at DESC')
    end
  end
  private
  def partners_params
    params.require(:partner).permit( :name,
                                     :address,
                                     :contact_name,
                                     :email,
                                     :phone,
                                     :description,
                                     :types_partner_id,
                                     :country_id,
                                     :town_id )
  end
end
