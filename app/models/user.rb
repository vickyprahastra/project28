class User < ApplicationRecord
  def  next_reminder_time
    year = Date.today.year
    mmdd = birthday.strftime('%m%d')
    year += 1 if mmdd < Date.today.strftime('%m%d')
    mmdd = '0301' if mmdd == '0229' && !Date.parse("#{year}0101").leap?
    at_time = '0900'
    return ActiveSupport::TimeZone[location].parse("#{year}#{mmdd}#{at_time}").utc
  end
end
