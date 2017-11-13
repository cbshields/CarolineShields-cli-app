class RecipeSearch::Recipe

attr_accessor :name, :ingredients, :steps, :url

@@recipe_info = []
def self.scrape_recipe(url)
  ingredient_list = []
  list_steps = []
  doc = Nokogiri::HTML(open(url))

  #getting ingredients
  doc.search("ul.td-arrow-list li").each do |ingred|
    ingredient = ingred.text
    ingredient_list << ingredient
  end

  #getting directions span.dropcap
  doc.search("h3.Directions p").each do |step|
    #how do I get the directions
    instr = step.text
    list_steps << instr
  end
  binding.pry
end


end #ends Recipe class
