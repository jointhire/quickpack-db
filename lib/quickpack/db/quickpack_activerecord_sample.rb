module Quickpack
  module Db

    class QuickpackActiverecordSample < ActiveRecord::Base

#self.abstract_class = true


#      include ActiveRecord::ConnectionAdapters
#      t = @@table_definition = TableDefinition.new(ActiveRecord::Base.connection)
#      t.column :name, :string
#      t.column :demographic, :integer
#      t.column :written_at, :datetime
#
#      def self.columns
#        @columns ||= @@table_definition.columns.map do |c|
#          Column.new(c.name.to_s, c.default, c.sql_type, c.null)
#        end
#      end


#      attr_accessor :id

#    class QuickpackActiveRecord < ActiveRecord::Base
#      self.abstract_class = true

#      before_create :setup_default_create_data
#      before_update :setup_default_update_data

    #todo Rdocコメント
#      private
#      def setup_default_create_data
#        self.stop_use_flg = 0
#        self.del_cd = 0
#        self.disp_no = 0
#        self.ins_tm = DateTime.now
#        self.upd_tm = DateTime.now
#        unless Thread.current[:controller].nil?
#          self.ins_user_id = nil
#          self.ins_module_id = Thread.current[:controller].controller_name + "." + Thread.current[:controller].action_name
#        end
#      end

    #todo Rdocコメント
#      private
#      def setup_default_update_data
#        self.upd_tm = DateTime.now
#        unless Thread.current[:controller].nil?
#          self.last_upd_user_id = nil
#          self.last_upd_module_id = Thread.current[:controller].controller_name + "." + Thread.current[:controller].action_name
#        end
#      end

    end
  end
end
