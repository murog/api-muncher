class Recipe
  attr_reader :name, :link, :image, :ingredients, :health_labels, :dietary_information, :uri
  def initialize(name, link, options={})
    raise ArgumentError.new if name==nil || name == "" || link == nil || link == ""
    @name = name
    @link = link
    #optional variables
    @image = options[:image]
    @ingredients = options[:ingredients]
    # binding.pry
    @dietary_information = options[:diet_info]
    @health_labels = options[:health_labels]
    @uri = "#{options[:uri]}"[-32..-1]
  end
end
