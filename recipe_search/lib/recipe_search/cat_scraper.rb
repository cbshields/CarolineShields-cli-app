class RecipeSearch::Cat_scraper
  attr_accessor :name, :url

  @@all = []


  def initialize(student_hash)
    student_hash.each do |attribute , value|
      self.send("#{attribute}=", value)
    end
    @@all << self
  end

  def self.categories
    #pull categories from food recipe seach site
    food_cat = []
    doc = Nokogiri::HTML(open("http://foodrecipesearch.com/"))
      doc.search("ul.sub-menu li").each do |category|
        cat = category.text
        cat_url = category.at('a')['href']
        food_cat << {:name=>cat,:url=>cat_url}
      end
    food_cat
  end
end #ends category_scaper
