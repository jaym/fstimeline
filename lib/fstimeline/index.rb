require 'find'
require 'fstimeline/object/base'
require 'fstimeline/object/tree'
require 'fstimeline/object/blob'

module Fstimeline
  class Index
    def self.build_index(dir)
      index = Fstimeline::Index.new
      tree = Fstimeline::Index.build_tree(File.expand_path(dir), index)
      index.root = tree
      index
    end

    def self.build_tree(path, index)
      puts path
      stat = File::Stat.new(path)
      if index.modified? path
        if stat.directory?
          objects = []
          Dir.foreach(path) do |x|
            if x == "." || x == ".."
              next
            end
            dirpath = File.join(path, x)
            objects << Fstimeline::Index::build_tree(dirpath, index)
          end
          obj = Object::Tree.new(objects)
          index.add(path, obj, stat)
          obj
        else
          obj = Object::Blob.new <<-EOF
            ino=#{stat.ino}
            mtime=#{stat.mtime}
            size=#{stat.size}
            EOF
          index.add(path, obj, stat)
          obj
        end
      else
        index.lookup(path)
      end
    end

    attr_accessor :root

    def initialize
    end

    def add(path, obj, stat)
      entries[path] = Entry.new(obj, stat)
    end

    def entries
      @entries ||= {}
    end

    def lookup(path)
      entry = entries[path]
      entry.object if entry
    end

    def rebuild

    end

    def modified?(path)
      path = File.expand_path(path)
      entry = entries[path]
      if entry
        stat = File::Stat.new(path)
        return stat.directory? || 
          stat.ino != entry.stat.ino ||
          stat.mtime != entry.stat.mtime ||
          stat.size != entry.stat.size
      else
        true
      end
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



