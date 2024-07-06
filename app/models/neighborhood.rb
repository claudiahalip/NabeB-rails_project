class Neighborhood < ApplicationRecord
   
    has_many :businesses
    has_many :categories, through: :businesses 

    validates :name, :city, :state, :zipcode, presence: true
    validates :name, uniqueness: {scope: :zipcode, message: "the neighborhood already exist in this zipcode area " }
   

    scope :search_neighborhood, ->(params) {where("LOWER(name) LIKE?","%#{params}%")}
   
    def self.sort_nebe_businesses
         
        neighborhood = Neighborhood.all  
        n = neighborhood.sort_by { |n| n.businesses.size }
        n.reverse
    end 

    binding.pry
end
