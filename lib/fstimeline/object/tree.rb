require 'fstimeline/object/base'
require 'digest/sha1'

module Fstimeline
  module Object
    class Tree < FsTimeline::Object::Base
      def initialize(nodes)
        @nodes = nodes
      end

      def checksum
        hashes = nodes.map {|n| n.hash }
        Digest::SHA1.hexdigest('TREE:' + hashes.sort.join("\n"))
      end
    end
  end
end
