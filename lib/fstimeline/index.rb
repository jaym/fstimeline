module Fstimeline
  class Index
    def self.build(dirs)

    end

    def initialize(objects)
      @objects = objects
    end

    # Given this index, build a new index with
    # the current state of the FS
    def rebuild

    end

    class Entry
      def initialize(object, stat)
        @object = object
        @stat = stat
      end

      def object
        @object
      end

      def stat
        @stat
      end
    end
  end
end
