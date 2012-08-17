module DateHelper  

  def DateHelper::get_week(date)
    #set to Tuesday 3am EST, assumption of when games for prev week is over
    first_tuesday = DateTime.new(2012,9,11,8)
    if date <= first_tuesday
      return 1
    else
      week = 2
      football_tues = first_tuesday + 7
      while date > football_tues
        football_tues += 7
        week += 1
      end
      return week
    end
  end

end