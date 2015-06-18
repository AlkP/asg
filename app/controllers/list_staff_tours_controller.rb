class ListStaffToursController < ApplicationController
  def create
    ListStaffTour.where('tour_id = ?', params[:tour_id] ).destroy_all
    params[:list_staff_tour].each_key do |s|
      ListStaffTour.create(tour_id: params[:tour_id], staff_id: s)
    end
  end
end
