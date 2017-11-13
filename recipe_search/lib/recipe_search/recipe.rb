class RecipeSearch::Recipe

attr_accessor :name, :ingredients, :steps, :url

def self.scrape_recipe(url)
  doc = Nokogiri::HTML(open(url))


end



end #ends Recipe class
