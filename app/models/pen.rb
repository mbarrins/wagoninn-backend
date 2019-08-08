class Pen < ApplicationRecord
  belongs_to :pen_type

  def self.api_info
    Pen.all.map{|pen| {id: pen.id, pen: pen.pen}}
  end
end
