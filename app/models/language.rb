class Language < ActiveRecord::Base

	def self.default
		if (l = Language.where(default: true)).blank?
			l = Language.scoped
		end
		l.first
	end
end
