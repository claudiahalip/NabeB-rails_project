class Business < ApplicationRecord

  belongs_to :neighborhood
  belongs_to :category
  belongs_to :user

  accepts_nested_attributes_for :neighborhood 
  
  validates :name,:description, :phone_number, presence: true
  validates :name, :website, :phone_number, uniqueness: true
   
  # def category_attributes=(attr)
  #   self.category = Category.first_or_create_by(attr)
  # end 

  # # def category_name
  # #   self.category ? self.category.name : nil
  # # end 

  
  def user_name=(name)
    self.user = User.find_or_create_by(username: name)
  end 

  def user_name
    self.user ? self.user.username : nil
  end 

  scope :search_business, -> (params) { where("LOWER(name) LIKE?","%#{params}%" )}

end
