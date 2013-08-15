class Search < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  belongs_to :shop
end
