class StaffVisasController < ApplicationController
  def create
    staff_visa = StaffVisa.create(staff_visas_params)
    staff_visa.save
    @staff_visas = StaffVisa.all_alkp.where( 'staff_id = ?', staff_visa.staff_id ).order('updated_at DESC')
  end
  def destroy
    staff_visa = StaffVisa.find(params[:id])
    staff_id = staff_visa.staff_id
    StaffVisa.destroy staff_visa
    @staff_visas = StaffVisa.all_alkp.where( 'staff_id = ?', staff_id ).order('updated_at DESC')
  end
  private
  def staff_visas_params
    params.require(:staff_visa).permit(:validity,
                                       :country_id,
                                       :staff_id )
  end
end
