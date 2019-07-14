module Nippou
  module Github
    class Issue
      def initialize(issue)
        @title = issue.title
        @url = issue.html_url
      end

      def to_markdown
        "[#{title}](#{url})"
      end

      private
      attr_reader :title, :url
    end
  end
end
