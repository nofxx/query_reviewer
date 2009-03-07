# Include hook code here
require 'active_record'
require 'query_reviewer'

def include_mysql
  ActiveRecord::ConnectionAdapters::MysqlAdapter.send(:include, QueryReviewer::MysqlAdapterExtensions)
  rescue => e
  puts e
end

def include_postgresql
  ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.send(:include, QueryReviewer::PostgresqlAdapterExtensions)
  rescue => e
  puts e
end

if QueryReviewer.enabled?
  include_mysql
  include_postgresql
  ActionController::Base.send(:include, QueryReviewer::ControllerExtensions)
  Array.send(:include, QueryReviewer::ArrayExtensions)

  if ActionController::Base.respond_to?(:append_view_path)
    ActionController::Base.append_view_path(File.dirname(__FILE__) + "/lib/query_reviewer/views")
  end
end
