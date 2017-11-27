class RecipeSearch::Scraper
  #why make them Class methods instead of instance methods

  def self.categories
    food_cat = []
    #pull categories from food recipe seach site
    doc = Nokogiri::HTML(open("http://foodrecipesearch.com/"))
    doc.search(".td-mobile-content ul.sub-menu li").map do |category|

        cat = category.text
        url = category.at('a')['href']

      if cat != "Soul Food Recipes" && cat != "Raw Food Recipes"
          food_cat << {:name=>cat,:cat_url=>url}
      else
            recipe_list_url = Nokogiri::HTML(open(url))
           if !recipe_list_url.search("h3.entry-title").empty?
             food_cat << {:name=>cat,:cat_url=>url}
           end
        end
      end
  food_cat
  end

  def self.recipe_cat(cat_url)
    doc = Nokogiri::HTML(open(cat_url))
    doc.search("h3.entry-title").map do |recipe|
      title = recipe.text
      url = recipe.at('a')['href']
      {:recipe_name=>title,:recipe_url=>url}
    end
  end

  def self.scrape_recipe(url)
    doc = Nokogiri::HTML(open(url))
    ingredient_list = []
    list_steps = []
    prep_time = []

    #prep times
    doc.search(".td-recipe-info").each do |preptime|
      prep_time << preptime.text
    end


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

    recipe_name = doc.search("h1.entry-title").text
    recipe_prep = prep_time.join(" ")

    RecipeSearch::Recipe.new(recipe_name, ingredient_list, list_steps, url, recipe_prep)
  end



end #ends scaper
