module ApplicationHelper
	def diver(n)
		(12/n).to_i
	end

  def append_first(base_text, append_text)
    @appended ||= {}
    appended_text = append_text(base_text, append_text, !@appended[base_text])
    @appended[base_text] ||= true

    appended_text
  end

  def append_text(base_text, append_text, if_true)
    if_true ? "#{base_text} #{append_text}" : base_text
  end

  def admin_preview_language
    @admin_preview_language ||= admin_preview_language_
  end

  def admin_preview_language_
    l_abbr = admin_preview_language_abbr
    (l_abbr.present? && (l = Language.find_by_abbr(l_abbr))) ?
      l : Language.find_by_abbr(I18n.locale)
  end

  def toggle_as_user
    toggle = {
      t("shared.admin_preview_role.customer") => "false",
      t("shared.admin_preview_role.shop_owner") => "true"
    }[admin_preview_role]
    {admin_preview_role_sym => toggle}
  end

  def admin_preview_role
    @admin_preview_role ||= pretending_to_be_customer? ?
      t("shared.admin_preview_role.customer") :
      t("shared.admin_preview_role.shop_owner")
  end

  def textilize(s)
    RedCloth.new(s).to_html.html_safe
  end

end
