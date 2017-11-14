class RecipeSearch::Scraper
  attr_accessor :name, :cat_url, :recipe_name, :recipe_url

  def self.categories
    #pull categories from food recipe seach site
    food_cat = []
    doc = Nokogiri::HTML(open("http://foodrecipesearch.com/"))
      doc.search("ul.sub-menu li").each do |category|
        cat = category.text
        url = category.at('a')['href']
        food_cat << {:name=>cat,:cat_url=>url}
      end
    food_cat
  end

  def self.recipe_cat(cat_url)
    recipes = []
    doc = Nokogiri::HTML(open(cat_url))
    doc.search("h3.entry-title").each do |recipe|
      title = recipe.text
      url = recipe.at('a')['href']
      recipes << {:recipe_name=>title,:recipe_url=>url}
    end
    recipes
  end


end #ends scaper
