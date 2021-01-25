class View

  def ask_ingredient
    puts "Enter recipe ingredient:"
    gets.chomp
  end


  def ask_recipe_name
    puts "Enter recipe name:"
    gets.chomp
  end

  def ask_recipe_description
    puts "Enter recipe description:"
    gets.chomp
  end

  def ask_recipe_rating
    puts "Enter recipe rating (1-5):"
    gets.chomp.to_i
  end

  def ask_recipe_index
    puts "Enter index:"
    gets.chomp.to_i - 1
  end

  def ask_recipe_preptime
    puts "Enter recipe preparation time:"
    gets.chomp
  end


  def display(recipes)
    recipes.each_with_index do |recipe, index|
      done = recipe.done? ? '[X]' : '[ ]'
      puts "#{index + 1} #{done} - #{recipe.name}: #{recipe.description} | Rating: #{recipe.rating}/5 - Prep. Time: #{recipe.preptime}"
    end
  end

end
