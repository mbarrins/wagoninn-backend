class SpecialNeed < ApplicationRecord

  def self.api_info
    SpecialNeed.select{|need| need.current}.map{|need| {id: need.id, name: need.name, action_needed: need.action_needed, alert: need.alert}}
  end
end
