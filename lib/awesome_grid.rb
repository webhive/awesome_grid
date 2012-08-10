require "awesome_grid/version"
require "awesome_grid/helpers/grid_helper"
require "awesome_grid/models/instance_methods"

module AwesomeGrid
  # Your code goes here...
end

#ActiveSupport.on_load(:action_view) do
#  include AwesomeGrid::Helpers::GridHelper
#end

ActionView::Base.send(:include, AwesomeGrid::Helpers::GridHelper)
ActiveRecord::Base.send(:include, AwesomeGrid::Models::InstanceMethods)

