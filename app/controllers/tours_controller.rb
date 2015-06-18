class ToursController < ApplicationController
  def index
    if params[:client_id].nil?
      session[:tours] = nil
      @tours = Tour.all_alkp.order('created_at DESC')
    else
      session[:tours] = true
      @client = Client.find(params[:client_id])
      if params[:filter_id] == "nil"
        @tours = Tour.all_alkp.where('client_id = ?',params[:client_id]).current_tours
        #@tours = Tour.where('client_id = ?',params[:client_id]).where
      else
        @tours = Tour.all_alkp.where('client_id = ?',params[:client_id]).arhive_tours
      end
    end
  end
  def new
    @client = Client.find(params[:client_id])
    tour = Tour.create(name: "Новый тур", client_id: params[:client_id], departure: DateTime.now, final: DateTime.now)
    tour.save
    @tours = Tour.all_alkp.where('client_id = ?',params[:client_id]).current_tours
  end
  def show
    @tour = Tour.find(params[:id])
    @tour_note = TourNote.new
    @tour_notes = TourNote.all_alkp.where('tour_id = ?', @tour.id)
    @list_staff_tours = ListStaffTour.where('tour_id = ?', @tour.id)
    @staffs = Staff.all_alkp.where( 'client_id = ?', @tour.client_id ).order('updated_at DESC')
    @list_staff_tour  = ListStaffTour.new
  end
  def destroy
    tour = Tour.find(params[:id])
    @client = Client.find(tour.client_id)
    Tour.destroy tour
    unless session[:tours].nil?
      @tours = Tour.all_alkp.where('client_id = ?', tour.client_id)
    else
      @tours = Tour.all_alkp.order('created_at DESC')
    end
  end
  def update
    tour = Tour.find(params[:id])
    tour.update(tours_params)
    unless session[:tours].nil?
      @tours = Tour.all_alkp.where('client_id = ?', tour.client_id)
      @client = Client.find(tour.client_id)
    else
      @tours = Tour.all_alkp.order('created_at DESC')
    end
  end
  def add_hotel
    @tour = Tour.find(params[:tour_id])
    TourRoom.create(name: "Новая комната", tour_id: params[:tour_id], partner_id: params[:hotel] )
  end
  def add_room
    @tour = Tour.find(params[:tour_id])
    TourRoom.create(name: "Новая комната", tour_id: params[:tour_id], partner_id: params[:partner_id] )
  end
  def select_staff
    @tour = Tour.find(params[:tour_id])
    list_staff_tours = []
    ListStaffTour.where('tour_id = ?', @tour.id).each do |l_s_t|
      list_staff_tours += [l_s_t.staff_id]
    end
    #staffs_arr = Staff.all_alkp.where('client_id = ?', @tour.client_id)
    staffs_arr = Staff.where('id in (?)', list_staff_tours)
    partner_id = TourRoom.find(params[:room_id]).partner_id
    flag_first = true
    id_arr = []
    staffs_arr.each do |s_arr|
      flag = true
      TourRoom.where('tour_id = ?', @tour.id).each do |t_r|
        RoomStaff.where('tour_room_id = ?', t_r.id).each do |r_s|
          flag = false if (r_s.staff_id == s_arr.id) && (t_r.partner_id == partner_id)
        end
      end
      flag_first = false if flag_first
      id_arr += [s_arr.id] if flag
    end
    @staffs = Staff.where('id IN (?)', id_arr)
    @room_id = params[:room_id]
  end
  def add_staff
    #t.integer  "tour_room_id"
    #t.integer  "staff_id"
    if params[:staff_id].length > 0
      RoomStaff.create(tour_room_id: params[:room_id], staff_id: params[:staff_id])
    end
    @tour = Tour.find(params[:tour_id])
  end
  def del_staff
    @tour = Tour.find(params[:tour_id])
    room_staff = RoomStaff.find(params[:staff_id])
    room_staff.destroy
  end
  def del_room
    @tour = Tour.find(params[:tour_id])
    TourRoom.find(params[:room_id]).destroy
  end
  def edit_room
    @room = TourRoom.find(params[:room_id])
  end
  def update_room
    room = TourRoom.find(params[:room_id])
    room.update(name: params[:room_name])
    @tour = Tour.find(room.tour_id)
  end
  private
  def tours_params
    params.require(:tour).permit( :name,
                                  :description,
                                  :note,
                                  :departure,
                                  :final )
  end
end
