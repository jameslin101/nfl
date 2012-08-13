module PlayerHelper
  
  def self.age(dob)
    dob = dob.to_time
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
  
  def self.get_stat(doc, row, column, type)
    css_string = "table:nth-child(5) :nth-child(%i) .yspscores:nth-child(%i)" % [row, column]
    puts css_string
    stat = doc.at_css(css_string).text.strip if !(doc.at_css(css_string)).nil?
    case type
      when "Float"
        stat = stat.to_f
      when "Integer"
        stat = stat.to_i
    end
    puts "return from playerhelp:" + stat.to_s
    return stat
  end
end
