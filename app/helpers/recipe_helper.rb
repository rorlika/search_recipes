module RecipeHelper
  def default_image(recipe)
    recipe.image.empty? ? 'https://static.toiimg.com/thumb/87282159.cms?width=680&height=512&imgsize=276736' : recipe.image
  end
end
