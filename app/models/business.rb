class Business < ApplicationRecord

  belongs_to :neighborhood
  belongs_to :category

  accepts_nested_attributes_for :neighborhood 
  
  validates :name,:description, :phone_number, presence: true
  validates :name, :website, :phone_number, uniqueness: true




  def self.alpha_sort
    self.order(:name)
  end 

  def self.search_business(params)
    where("LOWER(name) LIKE?","%#{params}%" )
  end 
end
