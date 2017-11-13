class RecipeSearch::Recipe

attr_accessor :name, :ingredients, :steps, :url, :prep

def self.scrape_recipe(url)
  doc = Nokogiri::HTML(open(url))
  ingredient_list = []
  list_steps = []
  prep_time = []

  #prep times
  doc.search(".td-recipe-info").each do |preptime|
    prep_time << preptime.text
  end
  binding.pry


  #getting ingredients
  doc.search("ul.td-arrow-list li").each do |ingred|
    ingredient = ingred.text
    ingredient_list << ingredient
  end

  #getting directions span.dropcap
  doc.search(".td-post-content p").collect do |p|
    text = p.text
    #how to remove &nbsp from array  - || text != "\u00A0"
    if text != "Ingredients:"
      until text[0].to_i == 0
          text = text[1..-1]
      end
      list_steps << text
    end
  end
  #remove &nbsp
  list_steps.shift

  recipe = self.new
  recipe.name = doc.search("h1.entry-title").text
  recipe.prep = prep_time.join(" ")
  recipe.ingredients = ingredient_list
  recipe.steps = list_steps
  recipe.url = url
  recipe
end



end #ends Recipe class
