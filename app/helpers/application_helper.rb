module ApplicationHelper
	def diver(n)
		(12/n).to_i
	end

  @@appended = {}

  def append_first(base_text, append_text)
    base_text = append_text(base_text, append_text, !@@appended.try(base_text))
    @@appended[base_text] ||= true

    base_text
  end

  def append_text(base_text, append_text, if_true)
    if_true ? "#{base_text} #{append_text}" : base_text
  end

  def admin_preview_language
    @admin_preview_language ||= admin_preview_language_
  end

  def admin_preview_language_
    l_abbr = params[:admin_preview_language]
    (l_abbr.present? && (l = Language.find_by_abbr(l_abbr))) ?
      l : Language.find_by_abbr(I18n.locale)
  end

  def toggle_as_user
    (params[:as_customer] == "true") ? {as_customer: "false"} : {as_customer: "true"}
  end

  # def can_and_want?(a, b)
  #   false
  # end

  # def pretending_to_be_customer?
  #   true
  # end

  def can_and_want?(action, obj)
    can?(action, obj) && !pretending_to_be_customer?
  end

  def pretending_to_be_customer?
    params[:as_customer] == "true"
  end
end
