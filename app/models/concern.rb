class Concern < ApplicationRecord

  def self.api_info
    Concern.all.map{|concern| {id: concern.id, name: concern.name, alert: concern.alert}}
  end
end
