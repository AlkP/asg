class PostDispatch < ActiveRecord::Base

  has_many :post_dispatch_log, dependent: :destroy

  #:subject      - Тема письма
  #:body         - Тело письма
  #:whom         - Кому рассылка   Свой список email,
  #                                Список клиентов,
  #                                Список сотрудников,
  #                                Сотрудникам турфирмы
  #:list         - Список рассылки Список email
  #                                Список ID клиентов
  #                                Список ID сотрудников
  #                                nil если рассылка по турфирме
  #:periodicity  - Периодичность   Единоразово      | once
  #                                Ежедневная       | day
  #                                Еженедельная     | week
  #                                Ежемесячная      | month
  #:date         - Дата отправки   День
  #                                nil
  #                                День недели
  #                                Число месяца
  #:time         - Время отправки  С точностью до 15 минут



  #scope :day, ->(day) { where ["LOWER(name) LIKE :name", :name => "%#{name}%".mb_chars.downcase]}

  scope :once,   :conditions => { :periodicity => 'once' }
  scope :day,   :conditions => { :periodicity => 'day' }
  scope :week,   :conditions => { :periodicity => 'week' }
  scope :month,   :conditions => { :periodicity => 'month' }

end
