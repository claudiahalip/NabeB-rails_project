class Business < ApplicationRecord

  belongs_to :neighborhood
  belongs_to :category

  accepts_nested_attributes_for :neighborhood 
  
  validation :name, :website, :phone_number, presence: true
  validation :name, :website, :phone_number, uniqueness: true
end
