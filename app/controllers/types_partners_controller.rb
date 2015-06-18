class TypesPartnersController < ApplicationController
  def index
    @types_partners = TypesPartner.all_alkp.order('updated_at DESC')
  end
  def new
    @types_partner = TypesPartner.new
  end
  def show
    @types_partner = TypesPartner.find(params[:id])
  end
  def update
    types_partner = TypesPartner.find(params[:id])
    types_partner.update(types_partners_params)
    @types_partners = TypesPartner.all_alkp.order('updated_at DESC')
  end
  def create
    types_partner = TypesPartner.create(types_partners_params)
    types_partner.save
    @types_partners = TypesPartner.all_alkp.order('updated_at DESC')
  end
  def destroy
    types_partner = TypesPartner.find(params[:id])
    #types_partner.destroy
    TypesPartner.destroy types_partner
    @types_partners = TypesPartner.all_alkp.order('updated_at DESC')
  end
  private
  def types_partners_params
    params.require(:types_partner).permit( :name )
  end
end
