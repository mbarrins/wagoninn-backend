class SpecialNeed < ApplicationRecord

  def self.api_info
    SpecialNeed.select{|need| need.current}.map{|need| {special_need: need.special_need, action_needed: need.action_needed}}
  end
end
