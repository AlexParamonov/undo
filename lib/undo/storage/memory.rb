module Undo
  module Storage
    class Memory < ::Hash
      def initialize(*args)
        super(*args)
      end
    end
  end
end
