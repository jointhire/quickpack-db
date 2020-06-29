module Quickpack
  module Db

    class QuickpackTwoWaySql < TwoWaySQL::Template

      #-------------------------------------#
      #SQL文の判別
      #-------------------------------------#
      def self.get_sql_type(sql)
        Rails.logger.debug("==========================")
        Rails.logger.debug("START get_sql_type")
        Rails.logger.debug("==========================")

        select_pos = get_pos("select",sql)
        update_pos = get_pos("update",sql)
        insert_pos = get_pos("insert",sql)
        delete_pos = get_pos("delete",sql)
        sql_type = nil
        if(select_pos >= 0)
          if(0 <= update_pos  && select_pos >  update_pos  )
            sql_type= "update"
          elsif(0 <= insert_pos  && select_pos >  insert_pos  )
            sql_type= "insert"
          else
            sql_type= "select"
          end
        elsif (0 <= update_pos)
          sql_type="update"
        elsif (0 <= insert_pos)
          sql_type="insert"
        elsif (0 <= delete_pos)
          sql_type="delete"
        end
        if sql_type.nil?
          Rails.logger.error("could not get sql_type.")
        end
        Rails.logger.debug("sqltype : " )
        Rails.logger.debug(sql_type)
        Rails.logger.debug("==========================")
        Rails.logger.debug("END get_sql_type")
        Rails.logger.debug("==========================")

        return sql_type
      end


      def self.get_pos(target,sql)
        pos = sql.index(/#{target}/i)
        pos = pos.nil?  ?  -1 : pos
        Rails.logger.debug(target << " pos:" << pos.to_s)
        return pos
      end

    end
  end
end
