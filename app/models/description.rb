class Description < ActiveRecord::Base
  belongs_to :language
  belongs_to :describable
end
