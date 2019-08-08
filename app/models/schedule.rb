class Schedule < ApplicationRecord

  def self.api_info
    Schedule.all.map{|schedule| {id: schedule.id, name: schedule.name, fee: schedule.fee}}
  end
end
