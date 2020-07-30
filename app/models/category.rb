class Category < ApplicationRecord
    has_many :businesses
    has_many :neighborhoods, through: :businesses
    validates :name, presence: true 
    validates :name, uniqueness: true


end
