class Recipe
  attr_reader :name, :description, :rating, :preptime

  def initialize(name, description, rating, preptime, done = false)
    @name = name
    @description = description
    @rating = rating
    @preptime = preptime
    @done = done
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end


  # Substituido pelo attr_reader:
  # def name
  #   return @name
  # end

  # def description
  #   return @description
  # end
end

# Instancia o recipe
# recipe = Recipe.new("feijoada", "arroz e carne de porco")
# recipe.name => "feijoada"
# recipe.description => "arroz e carne de porco"