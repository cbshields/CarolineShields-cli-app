class RecipeSearch::CLI

  def call
    list_categories
    menu_categories
    end_recipe_search
  end

  def list_categories
    puts "Recipe Search by Food Category"
    @categories = RecipeSearch::Scraper.categories
    @categories.each.with_index(1) do |category, i|
      puts "#{i}. #{category[:name]}"
    end
  end


  def menu_categories
    input = nil
    while input != "exit"
      puts "Enter the number of the recipe category or 'exit' to quit or 'list' to view categories again:"
      input = gets.strip.downcase

      if input.to_i > 0
        the_cat = @categories[input.to_i-1]
        the_cat_url = the_cat[:cat_url]
        puts "#{the_cat[:name]}"
        @recipe_list = RecipeSearch::Scraper.recipe_cat(the_cat_url)
        list_recipes
        recipe_choices
      elsif input.to_i == "list"
        list_categories
      else
        puts "Please enter the number of the recipe category you wish to see"
      end
    end
  end

  def list_recipes
    @recipe_list.each.with_index(1) do |list, i|
      puts "#{i}. #{list[:recipe_name]}"
    end

  end

  def recipe_choices

    input = nil
    while input != "exit"
      #figure out code to exit completely out of program
      #puts "Enter the number of the recipe would you like to see, 'exit' to quit program, 'back' to see the recipe categories or 'list' to view categories again:"
      puts "Enter the number of the recipe would you like to see, 'exit' to see the recipe categories or 'list' to view categories again:"
      input = gets.strip.downcase
      if input.to_i > 0
        #Brownie Dessert Recipe-ingredients & directions
        the_recipe_info = @recipe_list[input.to_i-1]
        the_recipe_info_url = the_recipe_info[:recipe_url]
        recipe_info(the_recipe_info_url)
      elsif input == "list"
        list_recipes
      elsif input == "exit"
        #comment out list_categories when figure out exit code
        end_recipe_search
        #list_categories
      elsif input == "back"
        list_categories
      else
        puts "Please enter the number of the recipe category you wish to see"
      end
    end
  end

def recipe_info(recipe_info_url)
  RecipeSearch::Recipe.scrape_recipe(recipe_info_url)


end


  def end_recipe_search
    puts "Thank you for using the recipe search"

  end

end #ends RecipeSearch
