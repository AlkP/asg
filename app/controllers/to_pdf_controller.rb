# encoding: utf-8
class ToPdfController < ApplicationController
  def list
    respond_to do |format|
      format.html
      format.pdf do
        pdf = Prawn::Document.new
        pdf.font "#{Prawn::BASEDIR}/data/fonts/verdana.ttf"
        pdf.text "Список участников тура"
        pdf.move_down 20

        list_staff_tours = []
        ListStaffTour.where('tour_id = ?', params[:tour_id]).each do |l_s_t|
          list_staff_tours += [l_s_t.staff_id]
        end

        staffs_arr = Staff.where('id in (?)', list_staff_tours)
        list_staff = ["Фамилия"]
        Staff.where('id in (?)', list_staff_tours).each do |f|
          pdf.text f.surname + " " + f.name + " " + f.middle_name
        end
        send_data pdf.render, filename: "Список группы.pdf"
      end
    end
  end

  def hotel
    @tour = Tour.find(params[:tour_id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = Prawn::Document.new
        pdf.font "#{Prawn::BASEDIR}/data/fonts/verdana.ttf"
        pdf.text "Rooming List"
        pdf.move_down 20
        (TourRoom.where('tour_id = ?', @tour.id)).select("DISTINCT(partner_id)").each do |hotel_list|
          partner = Partner.find(hotel_list.partner_id)
          @arr = []
          pdf.move_down 10
          pdf.text Town.find(partner.town_id).name+':'+partner.name
          @arr += [["Комната", "Проживающие"]]
          (TourRoom.where('tour_id = ?', @tour.id).where('partner_id = ?',hotel_list.partner_id).order('name')).each do |each_room|
            room = each_room.name
            first = true
            RoomStaff.where('tour_room_id = ?', each_room.id).each do |each_staff|
              staff = Staff.find(each_staff.staff_id).surname + " " + Staff.find(each_staff.staff_id).name + " " + Staff.find(each_staff.staff_id).middle_name
              first ? @arr += [[room, staff]] : @arr += [["", staff]]
              first = false if first
            end
          end
          pdf.table(@arr, :width => 500)
        end
        send_data pdf.render, filename: "Rooming List.pdf"
      end
    end
  end
end
