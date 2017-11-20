class RecipeSearch::CLI

  def call

    menu_categories

  end

  def list_categories
    @categories = RecipeSearch::Scraper.categories
    puts "Search by Recipe Category"
    @categories.each.with_index(1) do |category, i|
      puts "#{i}. #{category[:name]}"
    end
  end


  def menu_categories
    input = nil
    while input != "exit"
      list_categories
      puts "Enter the number of the recipe category, 'list' to view the recipe categories, or 'exit' to stop the search:"
      input = gets.strip.downcase

      if input.to_i > 0
        the_cat = @categories[input.to_i-1]
        the_cat_url = the_cat[:cat_url]
        @recipe_list = RecipeSearch::Scraper.recipe_cat(the_cat_url)
        if @recipe_list.empty?
            puts "There are no recipes for this category."
          else
            puts "#{the_cat[:name]}"
            list_recipes
            input = recipe_choices
          end

      elsif input == "list"
        ""
      elsif input == "exit"
        end_recipe_search
      else
        puts "You entered an invalid entry."
      end
    end #while loop
  end #ends menu_categories

  def list_recipes
        @recipe_list.each.with_index(1) do |list, i|
          puts "#{i}. #{list[:recipe_name]}"
        end

  end

  def recipe_choices

    input = nil

    while input != "exit" && input != "list"

      puts "Enter the number of the recipe, 'list' to view the recipe categories or 'exit' to stop the search:"
      input = gets.strip.downcase
      if input.to_i > 0
        the_recipe_info = @recipe_list[input.to_i-1]
        @the_recipe_info_url = the_recipe_info[:recipe_url]
        recipe_info
        list_recipes
      elsif input == "list"
        ""
      elsif input == "exit"
        end_recipe_search
      else puts "You have entered an invalid entry."
      end
      if input == "exit"
        return input
      end

    end #ends while loop

  end

  def recipe_info
    recipe = RecipeSearch::Scraper.scrape_recipe(@the_recipe_info_url)
    puts " "
    puts "Name: #{recipe.name}"
    puts "#{recipe.prep}"
    puts "Ingredients:"
    puts "==================================================="
      recipe.ingredients.each.with_index(1) do |list|
        puts "- #{list}"
      end
   puts " "
   recipe.steps.each.with_index(0) do |list, i|
     if i == 0
       puts "Directions: #{list}"
       puts "==================================================="
     else
     puts "#{i}. #{list}"
    end
  end
   puts "==================================================="
   puts " "
   puts "Here are the other recipes:"
  end

  def end_recipe_search
    puts "Thank you for using the recipe search"

  end

end #ends RecipeSearch
