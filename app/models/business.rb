class Business < ApplicationRecord

  belongs_to :neighborhood
  belongs_to :category
  accepts_nested_attributes_for :neighborhood 

end
