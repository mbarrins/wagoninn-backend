class Schedule < ApplicationRecord

  def self.api_info
    Schedule.all.map{|schedule| {id: schedule.id, schedule: schedule.schedule, fee: schedule.fee}}
  end
end
