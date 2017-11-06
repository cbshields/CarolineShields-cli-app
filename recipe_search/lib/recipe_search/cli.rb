class RecipeSearch::CLI

  def call
    list_categories
    menu_categories
  #  list_recipes
  #  menu_recipes
  #  end_recipe_search
  end

  def list_categories
    puts "Recipe Search by Food Category"
    #here doc - bunch of text
    puts <<-DOC.gsub /^\s*/, ''
      1. Desserts
      2. Chicken
      3. Kids
    DOC
  end

  def menu_categories
    input = nil
    while input != "exit"
      puts "Enter the number of the recipe category or 'exit' to quit or 'list' to view categories again:"
      input = gets.strip.downcase
      case input
      when "1"
        puts "Here are the dessert recipes"
        list_recipes
        menu_recipes

      when "2"
        puts "Here are the chicken recipes"
        list_recipes
        menu_recipes
      when "3"
        puts "Here are the kids recipes"
        list_recipes
        menu_recipes

      when "exit"
        end_recipe_search
      when "list"
        list_categories
      else
        puts "Please enter the number of the recipe category you wish to see"
      end
    end
  end

  def list_recipes
    puts <<-DOC.gsub /^\s*/, ''
      1. Ultimate Fudgy Brownies
      2. Homemade Almond Joy
      3. Brownie Dessert Pizza
    DOC
  end

  def menu_recipes

    input = nil
    while input != "exit"
      #figure out code to exit completely out of program
      #puts "Enter the number of the recipe would you like to see, 'exit' to quit program, 'back' to see the recipe categories or 'list' to view categories again:"
      puts "Enter the number of the recipe would you like to see, 'exit' to see the recipe categories or 'list' to view categories again:"
      input = gets.strip.downcase
      case input
      when "1"
        puts "Fudgy Brownie Recipe-ingredients & directions"
      when "2"
        puts "Homemade Almond Joy Recipe-ingredients & directions"
      when "3"
        puts "Brownie Dessert Recipe-ingredients & directions"
      when "exit"
        #comment out list_categories when figure out exit code
        #end_recipe_search
        list_categories
      when "list"
        list_recipes
      when "back"
        list_categories
      else
        puts "Please enter the number of the recipe you wish to see"
      end
    end
  end

  def end_recipe_search
    puts "Thank you for using the recipe search"

  end

end #ends RecipeSearch
