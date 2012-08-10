module AwesomeGrid
  module Models
    module InstanceMethods
      def to_row_id
        [self.class.name.split('::'), self.id].flatten.join('-').parameterize
      end
    end
  end
end
