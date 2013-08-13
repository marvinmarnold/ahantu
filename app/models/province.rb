class Province < ActiveRecord::Base
	validates :name,
		presence: true
end
