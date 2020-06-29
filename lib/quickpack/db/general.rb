require "quickpack/db/quickpack_two_way_sql"
require "yaml"

module Quickpack
  module Db
    module General

      def func
        p "===================== Quickpack::Db::General ======================" 
      end

      def insert(sql_path, sql_key, binds = nil, option = 1)
        sql = sql_load(sql_path, sql_key)
        unless binds.nil?
          tws = generate_twowaysql(sql, binds, option)
          ActiveRecord::Base.connection.exec_update(conv_sql(tws.sql), 'INSERT', conv_binds(tws.bound_variables))
        else
          ActiveRecord::Base.connection.exec_update(sql, 'UPDATE')
        end
      end

      def select(sql_path, sql_key, binds = nil, option = 1)
        sql = sql_load(sql_path, sql_key)
        unless binds.nil?
          tws = generate_twowaysql(sql, binds, option)
          ActiveRecord::Base.connection.exec_query(conv_sql(tws.sql), 'SELECT', conv_binds(tws.bound_variables)).to_a
        else
          ActiveRecord::Base.connection.exec_query(sql, 'SELECT').to_a
        end
      end

      def update(sql_path, sql_key, binds = nil, option = 1)
        sql = sql_load(sql_path, sql_key)
        unless binds.nil?
          tws = generate_twowaysql(sql, binds, option)
          ActiveRecord::Base.connection.exec_update(conv_sql(tws.sql), 'UPDATE', conv_binds(tws.bound_variables))
        else
          ActiveRecord::Base.connection.exec_update(sql, 'UPDATE')
        end
      end

      def delete(sql_path, sql_key, binds = nil, option = 1)
        sql = sql_load(sql_path, sql_key)
        unless binds.nil?
          tws = generate_twowaysql(sql, binds, option)
          ActiveRecord::Base.connection.exec_delete(conv_sql(tws.sql), 'DELETE', conv_binds(tws.bound_variables))
        else
          ActiveRecord::Base.connection.exec_delete(sql, 'DELETE')
        end
      end

      # paginate_select
      #
      # options={}で指定できるキー一覧．省略時は()内の値が使用される．
      #
      #          page: 取得するページ番号 1から．(1)
      #      per_page: 1ページあたりの件数(50)
      #         count: カウントSQL発行制御用（will_pagenateのリファレンス参照のこと） (nil)
      # total_entries: 全件の件数．(自前でカウントした場合に設定．will_pagenateはcount-SQLを発行しない)  (nil)
      #        option: 1/QuickpackTwoWaySqlを使用．  0/TwoWaySqlを使用         (1)
      #      ar_class: 行データ返却に使用するレコードクラス(ActiveRecord::Base)  
      #                (未設定時はdatabase.yml設定値(:pagenate_ar_class)を使用、両方未設定時は例外発生．) 
      #
      def paginate_select(sql_path, sql_key, binds=nil, options={})
        #p options
        sql = sql_load(sql_path, sql_key)
        etc_paginate_select(sql, binds, options)
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
          called_model.paginate_by_sql(
                         tws.bound_variables.unshift(tws.sql),
                         options
          )
        else
          called_model.paginate_by_sql(
                         sql,
                         options
          )
        end
      end

      def paginate_model_init
        if $quickpack_db_generate_called_model.nil?
          unless ActiveRecord::Base.connection_config[:pagenate_ar_load].nil? ||
                 ActiveRecord::Base.connection_config[:pagenate_ar_class].nil?
            require ActiveRecord::Base.connection_config[:pagenate_ar_load]
            $quickpack_db_generate_called_model = ActiveRecord::Base.connection_config[:pagenate_ar_class].constantize
#          else
#            $quickpack_db_generate_called_model = Quickpack::Db::SchemaMigrations
          end
        end
      end

      # load SQL from yaml-file
      def sql_load(sql_path, sql_key)
        if $g_quickpack_db_generate_sql_file.nil?
          #p "g_quickpack_db_generate_sql_file initialize."
          $g_quickpack_db_generate_sql_file = {}
        end
        if $g_quickpack_db_generate_sql_file[sql_path].blank?
          #p 'sqlfile_load: ' + sql_path
          $g_quickpack_db_generate_sql_file[sql_path] = YAML.load_file(sql_path)
        end
        $g_quickpack_db_generate_sql_file[sql_path][sql_key]
      end

      # generate TwoWaySql from sql
      def generate_twowaysql(sql, binds, option)
        case option
        when 1
          template = QuickpackTwoWaySql.parse(sql)
        else
          template = TwoWaySQL::Template.parse(sql)
        end
        template.merge(binds)
      end

      def conv_sql(sql)
          return sql
      end

      def conv_binds(binds)
        binds_conv = []
        for i in binds do
          binds_conv.push [nil, i]
        end
        return binds_conv
      end

    end
  end
end
