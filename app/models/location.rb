class Location < ActiveRecord::Base
   has_ancestry

  def to_s
    name
  end
end
