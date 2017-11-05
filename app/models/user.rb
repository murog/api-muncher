class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :uid, presence: true



  def add_to_favorites(input_recipe_uri)
    self.favorites << input_recipe_uri
  end
end
