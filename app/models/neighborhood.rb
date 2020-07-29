class Neighborhood < ApplicationRecord
   
    has_many :businesses
    has_many :categories, through: :businesses 


end
