class StaffsController < ApplicationController
  def index
    if params[:client_id].nil?
      @staffs = Staff.accept_filter(session[:filter_staff])
    else
      @flag_staff = true
      @client_id = params[:client_id]
      @staffs = Staff.all_alkp.order('updated_at DESC').where( 'client_id = ?', params[:client_id] )
      respond_to do |format|
        format.js
        format.html
      end
    end
  end
  def clear_filter
    session[:filter_staff] = nil
    @staffs = Staff.accept_filter
  end
  def filter
    (params[:filter][:name] != "") ? name = params[:filter][:name] : name = nil
    (params[:date][:year] != "") ? year = params[:date][:year] : year = nil
    (params[:date][:month] != "") ? month = params[:date][:month] : month = nil
    (params[:date][:day] != "") ? day = params[:date][:day] : day = nil

    (params[:filter][:sex] != "") ? sex = params[:filter][:sex] : sex = nil
    id_s = []
    if params[:filter][:name] != ""
      client = Client.where('deleted is NULL or deleted = ?',false).by_name params[:filter][:name]
      client.each do |idd|
        id_s += [idd.id]
      end
    end
    if params[:filter][:sector] != ""
      client = Client.where('deleted is NULL or deleted = ?',false).where('sector_id = ?',params[:filter][:sector].to_i)
      client.each do |idd|
        id_s += [idd.id]
      end
    end
    id_s = nil if ((params[:filter][:name] == "") and (params[:filter][:sector] == ""))
    session[:filter_staff] = {client_id: id_s, sex: sex, date: {year: year, month: month, day: day}}

    @staffs = Staff.accept_filter(session[:filter_staff])
  end
  def destroy
    staff = Staff.find(params[:id])
    client_id = staff.client_id
    #staff.destroy
    Staff.destroy staff
    @staffs = Staff.all_alkp.order('updated_at DESC').where( 'client_id = ?', client_id )
    respond_to do |format|
      format.js
      format.html
    end
  end
  def destroy_for_all
    staff = Staff.find(params[:id])
    #client_id = staff.client_id
    #staff.destroy
    Staff.destroy staff
    @staffs = Staff.accept_filter(session[:filter_staff])
    respond_to do |format|
      format.js
      format.html
    end
  end
  def new
    unless params[:client_id].nil?
      staff = Staff.create(surname: "Новый сотрудник", client_id: params[:client_id])
      @client_id = staff.client_id
      @staffs = Staff.all_alkp.order('updated_at DESC').where( 'client_id = ?', @client_id )
      @client = Client.find(@client_id)
    else
      @staffs = Staff.accept_filter(session[:filter_staff])
    end
    respond_to do |format|
      format.js
      format.html
    end
  end
  def show
    @event_staff = Event.new()
    @staff = Staff.find(params[:id])
    @staff_notes = StaffNote.all_alkp.where('staff_id = ?', @staff.id)
    @staff_note = StaffNote.new
    @staff_visa = StaffVisa.new
    @staff_visas = StaffVisa.all_alkp.where('staff_id = ?', @staff.id)
    respond_to do |format|
      format.js
      format.html
    end
  end
  def update
    staff = Staff.find(params[:id])
    staff.update(staffs_params)
    unless params[:client_id].nil?
      @client_id = staff.client_id
      @staffs = Staff.all_alkp.where( 'client_id = ?', @client_id ).order('updated_at DESC')
      @client = Client.find(@client_id)
    else
      @staffs = Staff.accept_filter(session[:filter_staff])
    end
  end
  private
  def staffs_params
    params.require(:staff).permit( :name,
                                    :surname,
                                    :middle_name,
                                    :birthday,
                                    :series,
                                    :issued_by,
                                    :issue_date,
                                    :valid_until,

                                    :international_name,
                                    :international_surname,
                                    :international_middle_name,
                                    :international_series,
                                    :international_issued_by,
                                    :international_issue_date,
                                    :international_valid_until,

                                    :sex,
                                    :post,
                                    :email_1,
                                    :email_2,
                                    :phone_1,
                                    :phone_2,
                                    :phone_3,
                                    :registration,
                                    :lives )
  end
end
