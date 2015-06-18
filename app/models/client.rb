class Client < ActiveRecord::Base
  has_many :note, dependent: :destroy
  has_many :staff, dependent: :destroy
  has_many :tour, dependent: :destroy
  has_many :event, dependent: :destroy
  has_many :contract, dependent: :destroy

  #:name               - Наименование
  #:sector             - Отрасль
  #:legal_address      - Юридический адрес
  #:actual_address     - Фактический адрес
  #:inn                - ИНН
  #:kpp                - КПП
  #:account            - Счет
  #:name_bank          - Наименование банка
  #:corr_account       - Корреспонденский счет
  #:bik                - БИК
  #
  #:job_title          - Должность ПЛ
  #:name_head          - ФИО ПЛ
  #:job_title_genitive - Должность ПЛ в род падеже
  #:name_head_genitive - ФИО ПЛ в род падеже
  #:statute            - Действует на основании

  validates_presence_of :name

  def self.all_alkp(session)
    if session.nil?
      where('deleted is NULL or deleted = ?',false)
    else
      if session[:name].nil? or session[:sector].nil?
        unless session[:name].nil?
          where('deleted is NULL or deleted = ?',false).by_name session[:name]
        else
          where('deleted is NULL or deleted = ?',false).where('sector_id = ?', session[:sector])
        end
      else
        where('deleted is NULL or deleted = ?',false).where('sector_id = ?', session[:sector]).by_name session[:name]
      end
    end
  end

  def self.destroy client
    client = Client.find(client.id)
    client.update(deleted: true)
  end

  scope :by_name, ->(name) { where ["LOWER(name) LIKE :name", :name => "%#{name}%".mb_chars.downcase]}
end
