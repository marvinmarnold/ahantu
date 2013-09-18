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
end
