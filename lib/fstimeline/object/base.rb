module Fstimeline
  module Object
    class Base
      def checksum
        raise NotImplementedError
      end
    end
  end
end
