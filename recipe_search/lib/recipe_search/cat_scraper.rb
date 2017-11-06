class RecipeSearch::Cat_scraper

  def self.categories

    puts <<-DOC.gsub /^\s*/, ''
      1. Desserts
      2. Chicken
      3. Kids
    DOC

  end


end #ends category_scaper
