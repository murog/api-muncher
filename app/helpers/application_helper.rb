module ApplicationHelper
  def random_image_url
    images = ["bubbles.gif", "egg.gif", "hamtaro.gif", "jam.gif", "ramen.gif", "squirtle.gif", "stirring.gif"]
    images.shuffle!
    return images.pop
  end

  def format_length(string)
    if string.length > 64
      return "#{string[0..64]}..."
    else
      return string
    end
  end
end
