class Issue < ApplicationRecord

  def self.api_info
    Issue.all.map{|issue| {id: issue.id, issue: issue.issue, alert: issue.alert}}
  end
end
