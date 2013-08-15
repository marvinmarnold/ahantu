module TagsHelper
	def search_tag_id(tag)
    "search_tag_ids_#{tag.id}"
  end

  def search_tag_name
  	"search[tag_ids][]"
  end
end
