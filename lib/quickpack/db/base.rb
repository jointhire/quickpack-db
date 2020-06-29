require "quickpack/db/general"

module Quickpack
  module Db
    class Base

      extend General

      unless ActiveRecord::Base.connection_config[:twoway_conv_class].nil? ||
             ActiveRecord::Base.connection_config[:twoway_conv_load].nil?
        require ActiveRecord::Base.connection_config[:twoway_conv_load]
        extend Object.const_get(ActiveRecord::Base.connection_config[:twoway_conv_class])
      end


    end

  end
end
