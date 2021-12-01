namespace :import do
  task :recipes => :environment do
    recipe_list = JSON.parse(File.read(ENV['FILE']))

    recipe_attributes = Recipe.new.attributes

    recipes = recipe_list.map do |recipe|
      recipe.reject{|k,v| !recipe_attributes.keys.member?(k.to_s) }
    end
    
    Recipe.insert_all(recipes)
    puts 'Done'
  end
end
