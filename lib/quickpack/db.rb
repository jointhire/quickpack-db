require "quickpack/db/version"
#require "quickpack/db/base"
#require "quickpack/db/quickpack_two_way_sql"
#require "quickpack/db/quickpack_active_record"

require 'active_support'

#include Quickpack::Db

module Quickpack
  module Db

    extend ActiveSupport::Autoload

    autoload :Base

  end
end
