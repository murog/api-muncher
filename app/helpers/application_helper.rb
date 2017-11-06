module ApplicationHelper
  def random_image_url
    images = ["bubbles.gif", "egg.gif", "hamtaro.gif", "jam.gif", "ramen.gif", "squirtle.gif", "stirring.gif"]
    images.shuffle!
    return images.pop
  end
end
