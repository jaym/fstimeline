require 'fstimeline/object/base'
require 'digest/sha1'

module Fstimeline
  module Object
    class Blob < Base
      def initialize(blob)
        @blob = blob
      end

      def checksum
        Digest::SHA1.hexdigest('BLOB:' + blob)
      end
    end
  end
end
