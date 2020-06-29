require "quickpack/db/quickpack_two_way_sql"

module Quickpack
  module Db
    module MySql2

      def func
        p "===================== Quickpack::Db::MySql2 ======================" 
      end

      def insert(sql_path, sql_key, binds = nil, option = 1)
        sql = sql_load(sql_path, sql_key)
        unless binds.nil?
          tws = generate_twowaysql(sql, binds, option)
          sql = pseudo_bind(tws.sql, tws.bound_variables)
        end
        ActiveRecord::Base.connection.exec_update(sql, 'INSERT', nil)
      end

      def select(sql_path, sql_key, binds = nil, option = 1)
        sql = sql_load(sql_path, sql_key)
        unless binds.nil?
          tws = generate_twowaysql(sql, binds, option)
          sql = pseudo_bind(tws.sql, tws.bound_variables)
        end
        ActiveRecord::Base.connection.exec_query(sql, 'SELECT', nil).to_a
      end

      def update(sql_path, sql_key, binds = nil, option = 1)
        sql = sql_load(sql_path, sql_key)
        unless binds.nil?
          tws = generate_twowaysql(sql, binds, option)
          sql = pseudo_bind(tws.sql, tws.bound_variables)
        end
        ActiveRecord::Base.connection.exec_update(sql, 'UPDATE', nil)
      end

      def delete(sql_path, sql_key, binds = nil, option = 1)
        sql = sql_load(sql_path, sql_key)
        unless binds.nil?
          tws = generate_twowaysql(sql, binds, option)
          sql = pseudo_bind(tws.sql, tws.bound_variables)
        end
        ActiveRecord::Base.connection.exec_delete(sql, 'DELETE', nil)
      end


      def etc_paginate_select(sql, binds=nil, options={})

        paginate_model_init

        options[:page] ||= 1
        options[:per_page] ||= 50
        #options[:count]
        #options[:total_entries]
        option = options[:option] ||= 1
        options.delete(:option)

        if options[:ar_class]
           called_model = options[:ar_class]
           options.delete(:ar_class)
        else
           called_model = $quickpack_db_generate_called_model
        end

        if called_model.nil?
          raise 'SET TO options[:ar_class] OR :pagenate_ar_load/:pagenate_ar_class@database.yml '
        end

        unless binds.nil?
          tws = generate_twowaysql(sql, binds, option)
          sql = pseudo_bind(tws.sql, tws.bound_variables)
        end
        called_model.paginate_by_sql(
                         sql,
                         options
        )
      end


      # バインド形式のSQLから埋め込み式へ変換
      def pseudo_bind(sql, binds)
        sql = sql.dup
        placeholders = []
        search_pos = 0
        while pos = sql.index('?', search_pos)
          placeholders.push(pos)
          search_pos = pos + 1
        end
        values = binds.flatten(1) if placeholders.length == binds.flatten(1).length
        raise ArgumentError, "mismatch between placeholders number and values arguments" if placeholders.length != values.length
        while pos = placeholders.pop()
          rawvalue = binds.pop()
          if rawvalue.nil?
            sql[pos] = 'NULL'
          elsif rawvalue.respond_to?(:strftime)
            sql[pos] = "'" + rawvalue.strftime('%Y-%m-%d %H:%M:%S') + "'"
          elsif rawvalue.is_a?(Array)
            sql[pos] = rawvalue.map{|v| "'" + Mysql2::Client.escape(v.to_s) + "'" }.join(",")
          else
            sql[pos] = "'" + Mysql2::Client.escape(rawvalue.to_s) + "'"
          end
        end
        sql
      end

    end
  end
end
