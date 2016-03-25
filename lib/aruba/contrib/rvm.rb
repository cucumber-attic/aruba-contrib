require 'aruba/contrib/rvm/api'

# Aruba
module Aruba
  # Contrib
  module Contrib
    # This adds rvm helpers to aruba
    module Rvm
    end
  end
end

module Aruba
  module Api
    include Aruba::Contrib::Rvm
  end
end
