class RecipeSearch::Recipe

attr_accessor :name, :ingredients, :steps, :url

def self.scrape_recipe(url)
  doc = Nokogiri::HTML(open(url))
  ingredient_list = []
  list_steps = []

  #getting ingredients
  doc.search("ul.td-arrow-list li").each do |ingred|
    ingredient = ingred.text
    ingredient_list << ingredient
  end

  #getting directions span.dropcap
  doc.search(".td-post-content p").collect do |p|
    text = p.text
    binding.pry
    if text != "Ingredients:" || text != " "
      binding.pry
      until text[0].to_i == 0
          text = text[1..-1]
      end
      list_steps << text
    end
  end

  binding.pry
  recipe = self.new
  recipe.ingredients = ingredient_list
  recipe.steps = list_steps
  recipe.name = doc.search("h1.entry-title").text
  recipe.url = url
  recipe
end



end #ends Recipe class
