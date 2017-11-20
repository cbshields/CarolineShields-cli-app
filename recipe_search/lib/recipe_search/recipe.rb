class RecipeSearch::Recipe

attr_accessor :name, :ingredients, :steps, :url, :prep

def initialize(name,ingredients,steps,url,prep)
  @name = name
  @ingredients = ingredients
  @steps = steps
  @url = url
  @prep = prep
end


end #ends Recipe class
