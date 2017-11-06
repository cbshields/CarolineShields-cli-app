class RecipeSearch::Cat_scraper
  attr_accessor :name

  def self.categories

    cat_1 = self.new
    cat_1.name = "Desserts"

    cat_2 = self.new
    cat_2.name = "Chicken"

    cat_3 = self.new
    cat_3.name = "Kids recipes"

    [cat_1, cat_2, cat_3]
  end

end #ends category_scaper
