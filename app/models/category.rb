class Category < ApplicationRecord
    has_many :businesses
    has_many :neighborhoods, through: :businesses

end
