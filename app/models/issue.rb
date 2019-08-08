class Issue < ApplicationRecord

  def self.api_info
    Issue.all.map{|issue| {id: issue.id, name: issue.name, alert: issue.alert}}
  end
end
