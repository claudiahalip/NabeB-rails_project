class Business < ApplicationRecord

  belongs_to :neighborhood
  belongs_to :category

  accepts_nested_attributes_for :neighborhood 
  
  validates :name,:description, :phone_number, presence: true
  validates :name, :website, :phone_number, uniqueness: true
end
