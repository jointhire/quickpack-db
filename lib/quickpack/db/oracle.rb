module Quickpack
  module Db
    module Oracle

      def func
        p "===================== Quickpack::Db::Oracle ======================"
      end

      #--------------------------------------
      # Oracleへ直接SQL発行する為のメソッド(General内メソッドの上書き)
      #--------------------------------------
      # convert into oci8's TwoWaySql from sql
      def conv_sql(sql)
        i = 0
        while sql.include?("?") do
          i += 1
          sql.sub!("?",":#{i}")
        end
        return sql 
      end


    end
  end
end

