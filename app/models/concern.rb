class Concern < ApplicationRecord

  def self.api_info
    Concern.all.map{|concern| {concern: concern.concern, alert: concern.alert}}
  end
end
