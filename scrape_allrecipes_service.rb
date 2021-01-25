class ScrapeAllrecipesService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    # Scraper do nome e url das receitas do ingredient
    url = "https://www.allrecipes.com/search/results/#{@keyword}"
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')

    # Pegar as top 5 receitas do site
    import_recipes = []
    doc.search('.fixed-recipe-card').first(5).each do |element|
      name = element.search('h3').text.strip
      url = element.search('h3 a').first.attributes['href'].value
      import_recipes << { name: name, url: url }
    end

    # Listar o nome das receitas para o usuário
    import_recipes.each_with_index do |import, index|
      # import = {name: 'feijoada', url: 'https://allrecipes.com/...'}
      puts "#{index + 1} - #{import[:name]}"
    end
    # Pegando o index da receita a ser importada
    puts "Enter recipe index:"
    index = gets.chomp.to_i - 1

    # Pegando nome e URL da receita a ser importada do array de hash import_recipes
    name = import_recipes[index][:name]
    url = import_recipes[index][:url]

    puts "Importing #{name}..."

    # Novo scraping da página de detalhe da receita
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')

    # Obtendo os dados da receita
    description = doc.search('.recipe-summary').text.strip
    rating = doc.search('.review-star-text').first.text.strip.match(/\d\.\d{2}/)[0].to_f.round
    preptime = doc.search('.recipe-meta-item-body')[3]&.text&.strip || "unavailable"

    # Instanciar uma nova receita
    Recipe.new(name, description, rating, preptime)
  end
end
