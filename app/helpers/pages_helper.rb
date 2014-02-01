module PagesHelper
  def rwanda_pictures
    Dir.glob("public/images/rwanda/*")
  end
end
