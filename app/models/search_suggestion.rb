class SearchSuggestion < ActiveRecord::Base
  def self.terms_for(prefix)
    $redis.zrevrange "search-suggestions:#{prefix.downcase}", 0, 9
  end

  def self.index_shops
    Shop.find_each do |shop|
      index_shop shop
    end
  end

  def self.unindex_phrase(phrase, inc = 1)
    if phrase.is_a? String
      unindex_term(phrase, inc)
      phrase.split.each { |t| unindex_term(t, inc) }
    end
  end

  def self.index_phrase(phrase, inc = 1)
    if phrase.is_a? String
      index_term(phrase, inc)
      phrase.split.each { |t| index_term(t, inc) }
    end
  end

  def self.index_shop(shop, inc = 1)
    shop.descriptions.each do |d|
      index_description d
    end
    index_term(shop.city.name, inc)
    index_term(shop.province.name, inc)
  end

  def self.unindex_shop(shop, inc = 1)
    shop.descriptions.each do |d|
      unindex_term(d.name, inc)
      d.name.split.each { |t| unindex_term(t, inc) }
    end
    unindex_term(shop.city.name, inc)
    unindex_term(shop.province.name, inc)
  end

  def self.index_term(term, inc = 1)
    term = term.downcase
    1.upto(term.length - 1) do |n|
      prefix = term[0, n]
      $redis.zincrby "search-suggestions:#{prefix}", inc, term
    end
  end

  def self.unindex_term(term, inc = -1)
    term = term.downcase
    1.upto(term.length - 1) do |n|
      prefix = term[0, n]
      k = "search-suggestions:#{prefix}"
      $redis.zincrby k, inc, term
      $redis.zrem k, term if $redis.zscore(k, term)
    end
  end
end
