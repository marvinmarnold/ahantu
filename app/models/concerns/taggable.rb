module Taggable
  def subclass_tags(tag_subclass)
    tags.where(type: tag_subclass.to_s)
  end
end