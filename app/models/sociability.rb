class Sociability < ApplicationRecord

  def self.api_info
    Sociability.all.map{|soc| {id: soc.id, sociability: soc.sociability, alert: soc.alert}}
  end
end
