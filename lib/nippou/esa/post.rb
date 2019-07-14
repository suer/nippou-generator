module Nippou
  module Esa
    class Post
      def initialize(json)
        @full_name = json['full_name']
        @url = json['url']
      end

      def to_markdown
        "[#{full_name}](#{url})"
      end

      private
      attr_reader :full_name, :url
    end
  end
end
