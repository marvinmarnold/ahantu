class Language < ActiveRecord::Base

	def self.default
		if (l = Language.where(default: true)).blank?
			l = Language.scoped
		end
		l.first
	end

	 def self.current
    Language.find_by_abbr(I18n.locale) || default
  end
end
