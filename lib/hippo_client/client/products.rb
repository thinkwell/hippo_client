module Thinkwell::Hippo
  class Client
    # Defines all api calls related to products
    module Products

      def products
        hydrate :Product, fetch('products')
      end

      def product(productId)
        hydrate :Product, fetch("products/#{productId}")
      end

    end
  end
end
