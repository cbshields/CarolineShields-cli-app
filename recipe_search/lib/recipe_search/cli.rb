class RecipeSearch::CLI

  def call
    list_categories
    menu_categories
    #list_recipes
    #recipe_choices
    #recipe_info
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
        @recipe_list = RecipeSearch::Scraper.recipe_cat(the_cat_url)
          if @recipe_list.empty?
            puts "There are no recipes for this category."
            list_categories
          else
            puts "#{the_cat[:name]}"
            list_recipes
            recipe_choices
          end
      elsif input == "list"
        list_categories
      else
        puts "Please enter the number of the recipe category you wish to see"
      end
    end #while loop
  end #ends menu_categories

  def list_recipes
        @recipe_list.each.with_index(1) do |list, i|
          puts "#{i}. #{list[:recipe_name]}"
        end
        #recipe_choices
  end

  def recipe_choices

    input = nil
    while input != "exit"

      #figure out code to exit completely out of program
      #puts "Enter the number of the recipe would you like to see, 'exit' to quit program, 'back' to see the recipe categories or 'list' to view categories again:"
      puts "Enter the number of the recipe would you like to see, 'back' to see the recipe categories,'list' to view categories again or 'exit':"
      input = gets.strip.downcase
      if input.to_i > 0
        the_recipe_info = @recipe_list[input.to_i-1]
        @the_recipe_info_url = the_recipe_info[:recipe_url]
        recipe_info
      elsif input == "list"
        list_recipes
      elsif input == "back"
        list_categories
      else
        puts "Please enter the number of the recipe you wish to see"
      end

    end #ends while loop
  end

  def recipe_info
    recipe = RecipeSearch::Recipe.scrape_recipe(@the_recipe_info_url)
    puts " "
    puts "Name: #{recipe.name}"
    puts "#{recipe.prep}"
    puts "Ingredients:"
    puts "==================================================="
      recipe.ingredients.each.with_index(1) do |list|
        puts "- #{list}"
      end
   puts " "
   puts "Directions:"
   puts "==================================================="
     recipe.steps.each.with_index(1) do |list, i|
       puts "#{i}. #{list}"
     end
   puts " "
   puts " "
  end

  def end_recipe_search
    puts "Thank you for using the recipe search"

  end

end #ends RecipeSearch
