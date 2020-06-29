module Quickpack
  module Db
#
# for Oracle
# (existing table: dual)
#
# for MySQL:
# > create table `dual` (`dummy` varchar(1) null);
# > insert into `dual` values ('X');
# 
    class Dual < ActiveRecord::Base
      self.table_name=:dual

    end
  end
end
