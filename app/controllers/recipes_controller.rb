class RecipesController < ApplicationController
  def index
    recipes
  end

  def show
    recipe
  end

  private

    def recipe
      @recipe ||= Recipe.find(params['id'])
    end

    def recipes
     @recipes = if params['ingredients'].present?
                  Recipe.search_by_ingredients(params['ingredients'])
                else
                  Recipe.limit(8)
                end
    end
end
