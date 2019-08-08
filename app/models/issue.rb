class Issue < ApplicationRecord

  def self.api_info
    Issue.all.map{|issue| {issue: issue.issue, alert: issue.alert}}
  end
end
