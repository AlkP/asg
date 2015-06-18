class ClientsController < ApplicationController
  #skip_before_filter :verify_authenticity_token, :only => [:send_to_client]
  #def send_to_client
  #  UserMailer.send_to_client(session[:filter], params[:subject], params[:body]).deliver
  #  redirect_to clients_path
  #end
  def index
    @clients = Client.all_alkp(session[:filter]).order('updated_at DESC')
  end
  def filter
    (params[:filter][:name] != "") ? name = params[:filter][:name] : name = nil
    (params[:filter][:sector] != "") ? sector = params[:filter][:sector] : sector = nil

    unless (name.nil?) and (sector.nil?)
      session[:filter] = {name: name, sector: sector}
    else
      session[:filter] = nil
    end
    @clients = Client.all_alkp(session[:filter]).order('updated_at DESC')
  end
  def clear_filter
    session[:filter] = nil
    @clients = Client.all_alkp(session[:filter]).order('updated_at DESC')
  end
  def new
    client = Client.create(name: "Новый клиент")
    if client.save
      $current_client = client.id
      redirect_to clients_path
    else
      redirect_to root_path
    end
  end
  def update
    if params[:client][:sector_id] == "new"
      sector = Sector.new(name: params[:new_sector])
      sector.save
      params[:client][:sector_id] = sector.id
    end
    client = Client.find(params[:id])
    client.update(clients_params)
    @clients = Client.all_alkp(session[:filter]).order('updated_at DESC')
  end
  def show
    @event = Event.new()
    @client = Client.find(params[:id])
    @sectors = Sector.all_alkp
    @notes = Note.all_alkp.where('client_id = ?', params[:id])
    @note = Note.new
    $current_client = @client.id
    respond_to do |format|
      format.js
      format.html
    end
  end
  def destroy
    client = Client.find(params[:id])
    #client.destroy
    Client.destroy client
    @clients = Client.all_alkp(session[:filter]).order('updated_at DESC')
    redirect_to clients_path
    #redirect_to users_path
  end
  private
  def clients_params
    params.require(:client).permit( :name,
                                    :sector_id,
                                    :legal_address,
                                    :actual_address,
                                    :inn,
                                    :kpp,
                                    :account,
                                    :name_bank,
                                    :corr_account,
                                    :bik,
                                    :job_title,
                                    :name_head,
                                    :job_title_genitive,
                                    :name_head_genitive,
                                    :statute,
                                    :email)
  end
end
