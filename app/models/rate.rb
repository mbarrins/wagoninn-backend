class Rate < ApplicationRecord
  belongs_to :pen_type

  def self.api_info
    Rate.all.map{|rate| {id: rate.id, pen_type_id: rate.pen_type_id, no: rate.no, desc: rate.desc, amount: rate.amount, effective_from: rate.effective_from, effective_to: rate.effective_to}}
  end

  def self.all_current
    Rate.all.select do |rate| 
      rate.effective_from <= Date.today && (!rate.effective_to || rate.effective_to >= Date.today)
    end.map{|rate| {id: rate.id, pen_type_id: rate.pen_type_id, no: rate.no, desc: rate.desc, amount: rate.amount}}
  end
end
