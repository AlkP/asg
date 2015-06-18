def preparation(once)
  email_list = eml_list(once)
  send_e = ''
  unless email_list.nil?
    email_list.each do |e_l|
      (send_e.length == 0) ? send_e = e_l.email : send_e += ', ' + e_l.email
    end
    UserMailer.send_to_client(send_e, once.subject, once.body).deliver
    PostDispatchLog.create(post_dispatch_id: once.id)
  end
end
def eml_list(once)
  case once.whom
    when 'client'
      list = once.list.split(', ')
      Client.where('id in (?)', list)
    when 'staff'
      list = once.list.split(', ')
      Staff.where('id in (?)', list)
    when 'staff_asg'
      User.all_alkp
    when 'my_list'
      PostDispatchEmail.where('post_dispatch_id = ?', once.id)
  end
end
def check_log(once, log)
  log.each do |lo|
    return false if ((once.id == lo.post_dispatch_id) or (once.time.strftime("%H:%M") > Time.now().strftime("%H:%M")))
  end
  return true
end
def check_week_day(once)

end