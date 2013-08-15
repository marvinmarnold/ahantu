module RandomHelper
  class << self
    def rand_shop_logo
      rand_file("vendor/assets/hotels/generic/logos")
    end

    def rand_file(folder)
      File.open(Dir[Rails.root.join("#{folder}/*")].sample)
    end

  end
end