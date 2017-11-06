class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :uid, presence: true



  def add_to_favorites(input_recipe_uri)
    self.favorites << input_recipe_uri
  end

  def included_in_favorites?(input_recipe_uri)
    if self.favorites.include? input_recipe_uri
      return true
    else
      return false
    end
  end

  def remove_from_favorites(input_recipe_uri)
    if self.favorites.delete(input_recipe_uri)
      return true
    else
      return false
    end

  end

  def update_recent_searches
    if self.recent_searches.length > 5
      while self.recent_searches.length > 5
        self.recent_searches.delete_at(0)
      end
      return true
    end
    return false
  end

end
