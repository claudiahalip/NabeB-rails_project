class Category < ApplicationRecord
    has_many :businesses
    has_many :neighborhoods, through: :businesses
    validation :name, presence: true 
    validation :name, uniqueness: true

    
end
