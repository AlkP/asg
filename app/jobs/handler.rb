require File.dirname(__FILE__) + '/function_lib.rb'

class HandlerJob
  @queue = :alkp

  def self.perform

    # Обработка органайзера
    User.where('deleted is NULL or deleted = ?', false).each do |us|
      eve = Event.where('events.end is NULL and user_id = ? and date <= ?', us.id, Date.today())
      eve.each do |ev|
        if ev.time < Time.now()
          unless ev.end
            UserMailer.send_to_client(us.email, ev.name, ev.description).deliver
            ev.end = true
            ev.save
          end
        end
      end
    end

    # Обработка рассылки
    log = PostDispatchLog.where('created_at > ?', Date.today - 1).where('created_at < ?', Date.today + 1)

    # Одноразовая
    once = PostDispatch.once.where('date = ?', Date.today())
    once.each do |on|
      if check_log(on, log)
        preparation(on)
      end
    end

    # Ежедневная
    day = PostDispatch.day.where('date <= ?', Date.today())
    day.each do |da|
      if check_log(da, log)
        preparation(da)
      end
    end

    # Еженедельная
    week = PostDispatch.week.where('date <= ?', Date.today())
    week.each do |we|
      if we.date.wday == Time.now.wday
        if check_log(we, log) and check_week_day(we)
          preparation(we)
        end
      end
    end

    # Ежемесячеая
    month = PostDispatch.month.where('date <= ?', Date.today())
    month.each do |mo|
      if mo.date.strftime("%d") == Time.now.strftime("%d")
        if check_log(mo, log) and check_week_day(mo)
          preparation(mo)
        end
      end
    end

    puts "Job is done!"
  end
end