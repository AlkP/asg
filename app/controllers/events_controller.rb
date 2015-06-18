class EventsController < ApplicationController
  def index
    event = Event.where('user_id = ?', current_user.id)
    @my_events_group = event.group("DATE(date)").count
    @events = event.where('date = ?', Date.today)
  end
  def get_events
    date = Date.strptime(params[:date],'%Y-%m-%d')
    @events = Event.where('user_id = ?', current_user.id).where('date = ?', date)
    respond_to do |format|
      format.js
    end
  end
  def new
    @event = Event.new
    @event.date = Date.today()
    @event.time = Time.now()
    respond_to do |format|
      format.js
    end
  end
  def create
    @flag_else = false
    params[:event][:user_id] = current_user.id
    params[:event][:time] = params[:event]['time(4i)'] + ':' + params[:event]['time(5i)']
    event = Event.create(events_params)
    event.client_id = params[:client_id] unless params[:client_id].nil?
    event.staff_id = params[:staff_id] unless params[:staff_id].nil?
    @flag_else = true unless params[:client_id].nil?
    @flag_else = true unless params[:staff_id].nil?
    event.save
    @events = Event.where('user_id = ?', current_user.id).where('date = ?', Date.today)
  end
  def destroy
    Event.find(params[:id]).destroy
    @events = Event.where('user_id = ?', current_user.id).where('date = ?', Date.today)
  end
  def show
    @event = Event.find(params[:id])
  end
  def update
    @event = Event.find(params[:id])
    params[:event][:time] = params[:event]['time(4i)'] + ':' + params[:event]['time(5i)']
    @event.update(events_params)
  end
  private
  def events_params
    params.require(:event).permit( :name,
                                    :description,
                                    :note,
                                    :date,
                                    :time,
                                    :user_id)
  end
end
