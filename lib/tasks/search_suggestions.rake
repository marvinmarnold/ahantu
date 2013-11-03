namespace :search_suggestions do
  desc "Generate search suggestions from shops"
  task :index => :environment do
    SearchSuggestion.index_shops
  end
end