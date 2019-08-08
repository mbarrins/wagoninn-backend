class Sociability < ApplicationRecord

  def self.api_info
    Sociability.all.map{|soc| {id: soc.id, name: soc.name, alert: soc.alert}}
  end
end
