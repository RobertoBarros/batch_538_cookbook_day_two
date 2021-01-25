require_relative 'view'

class Controller
  def initialize(cookbook)
    @view = View.new
    @cookbook = cookbook
  end

  def list
    # 1. Recuperar todas as receitas do cookbook
    recipes = @cookbook.all
    # 2. Mandar as receitas para a view exibir
    @view.display(recipes)
  end

  def create
    # 1. Perguntar para o usuário o nome da receita
    name = @view.ask_recipe_name

    # 2. Perguntar a descrição da receita
    description = @view.ask_recipe_description

    # 3. Perguntar o rating
    rating = @view.ask_recipe_rating

    # 3. Perguntar o rating
    preptime = @view.ask_recipe_preptime

    # 4. Instanciar uma nova receita
    new_recipe = Recipe.new(name, description, rating, preptime)

    # 5. Adicionar ao repositório (cookbook)
    @cookbook.add_recipe(new_recipe)
  end

  def destroy
    # 1. Listar todas as receitas
    list

    # 2. Perguntar o index da receita a ser excluída
    index = @view.ask_recipe_index

    # 3. Cookbook exclui a receita pelo index
    @cookbook.remove_recipe(index)
  end

  def mark
    # 1. Listar todas as receitas
    list

    # Perguntar o index da receita a ser marcada
    index = @view.ask_recipe_index

    @cookbook.mark_as_done(index)
  end


  def import

    # 1. Pergunte o ingrediente da receita
    ingredient = @view.ask_ingredient

    # 2. Instancia o objeto de serviço de scraping
    scrape = ScrapeAllrecipesService.new(ingredient)

    # 3. Chama o scraping que retorna a recipe
    new_recipe = scrape.call

    # 4. Adiciona a nova receita ao repository (cookbook)
    @cookbook.add_recipe(new_recipe)
  end

end
