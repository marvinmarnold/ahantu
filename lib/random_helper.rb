module RandomHelper
  class << self
    def rand_shop_logo
      rand_file("vendor/hotels/generic/logos")
    end

    def rand_file(folder)
      File.open(Dir[Rails.root.join("#{folder}/*")].sample)
    end

    def r1(n)
    	rand(n) + 1
    end

  end
end