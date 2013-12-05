module RandomHelper
  class << self
    def rand_shop_logo
      rand_file("vendor/hotels/generic/logos")
    end

    def rand_file(folder)
      File.open(Dir[Rails.root.join("#{folder}/*")].sample)
    end

    def rand_shop_banner
      rand_file("vendor/hotels/generic/banners")
    end

    def rand_shop_photo
      rand_file("vendor/hotels/generic/photos")
    end

    def r1(n)
    	rand(n) + 1
    end

    #returns v or nil, 50% randomly
    def bi_rand(v)
      rand(2) > 1 ? v : nil
    end

  end
end