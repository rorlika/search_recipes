class Recipe < ApplicationRecord
  scope :search_by_ingredients, ->(query) {
    quoted_query = ActiveRecord::Base.connection.quote_string(query)
    q = quoted_query.split(',').map{ |str| str.gsub(/\s+/, "") }.join('&')
    where("to_tsvector('simple', unaccent(ingredients::text) || ingredients::text) @@ :q", q: q)
    .or(self.where("word_similarity(ingredients::text, :q) > 0.05", q: quoted_query))
    .order(Arel.sql("#{rank_recipes(q)} DESC"), Arel.sql("word_similarity(ingredients::text, '#{quoted_query}') DESC"))
    .limit(8)
  }

  private

    def self.rank_recipes(query)
      <<-RANK
        ts_rank(
          to_tsvector('simple', unaccent(ingredients::text) || ingredients::text),
          to_tsquery('simple', '#{query}')
        )
      RANK
    end
end
