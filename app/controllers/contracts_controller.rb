class ContractsController < ApplicationController
  include RtfTemplater::Generator
  def index
    @contracts = Contract.where('client_id = ?', params[:client_id])
    @client = Client.find(params[:client_id])
  end
  def new
    @contract = Contract.create(name: "Новый контракт", client_id: params[:client_id])
    @client = Client.find(params[:client_id])
    @contracts = Contract.all.order('updated_at DESC').where( 'client_id = ?', @client.id )
    @templates = Template.all
  end
  def update
    contract = Contract.find(params[:id])
    contract.update(contracts_params)
    @contracts = Contract.all.order('updated_at DESC').where( 'client_id = ?', contract.client_id )
    @client = Client.find(contract.client_id)
  end
  def show
    @contract = Contract.find(params[:id])
    @templates = Template.all
  end
  def destroy
    contract = Contract.find(params[:id])
    @client = Client.find(contract.client_id)
    contract.destroy
    @contracts = Contract.all.order('updated_at DESC').where( 'client_id = ?', @client.id )
  end
  def to_rtf
    contract = Contract.find(params[:contract_id])
    client = Client.find(contract.client_id)
    file = Template.find(contract.template_id).att_file.path

    @d_number = contract.number
    @d_date   = contract.date.to_s

    @c_name     = client.name
    @c_address  = client.legal_address
    @c_real_address = client.actual_address
    @c_inn      = client.inn
    @c_kpp      = client.kpp
    @c_account  = client.account
    @c_name_bank  = client.name_bank
    @c_corr_account = client.corr_account
    @c_bik      = client.bik
    @c_name_head  = client.name_head

    File.open File.join(file) do |f|
      content = f.read
      send_data( render_rtf(content), :filename => "print.rtf" )
    end

  end
  private
  def contracts_params
    params.require(:contract).permit( :name,
                                     :number,
                                     :date,
                                     :amount,
                                     :annex,
                                     :template_id,
                                     :client_id )
  end
end
