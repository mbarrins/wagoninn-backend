class Concern < ApplicationRecord

  def self.api_info
    Concern.all.map{|concern| {id: concern.id, concern: concern.concern, alert: concern.alert}}
  end
end
