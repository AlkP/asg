module PostDispatchesHelper
  def whom_prn(whom)
    case whom
      when 'client'
        'Клиенты'
      when 'staff'
        'Сотрудники'
      when 'staff_asg'
        'Сотрудники ASG'
      when 'my_list'
        'Свой список'
    end
  end
end
