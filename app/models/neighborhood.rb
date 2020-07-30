class Neighborhood < ApplicationRecord
   
    has_many :businesses
    has_many :categories, through: :businesses 

    validation :name, :city, :state, :zipcode, presence: true
    validation :name, :city, uniqueness: {scope: :zipcode, message: "the neighborhood already exist in this zipcode area " }
end
