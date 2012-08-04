require "awesome_grid/version"
require "awesome_grid/helpers/grid_helper"

module AwesomeGrid
  # Your code goes here...
end

#ActiveSupport.on_load(:action_view) do
#  include AwesomeGrid::Helpers::GridHelper
#end

ActionView::Base.send :include, AwesomeGrid::Helpers::GridHelper
