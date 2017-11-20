class RecipeSearch::Scraper
  attr_accessor :recipe

  def self.categories
    #pull categories from food recipe seach site
    doc = Nokogiri::HTML(open("http://foodrecipesearch.com/"))
      doc.search("ul.sub-menu li").map do |category|
        cat = category.text
        url = category.at('a')['href']
        {:name=>cat,:cat_url=>url}

      #the below code adds a minute to processing time and it adds "nil" as an entry, why?
      #  recipe_list_url = Nokogiri::HTML(open(url))
      #    if !recipe_list_url.search("h3.entry-title").empty?
      #        {:name=>cat,:cat_url=>url}
      #    end
      end
  end

  def self.recipe_cat(cat_url)
    doc = Nokogiri::HTML(open(cat_url))
    binding.pry
    doc.search("h3.entry-title").map do |recipe|
      binding.pry
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
