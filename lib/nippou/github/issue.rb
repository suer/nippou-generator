module Nippou
  module Github
    class Issue
      attr_reader :updated_at, :url, :repository
      def initialize(issue)
        @title = issue.title
        @url = issue.html_url
        @repository = issue.repository_url.split('/').last
        @updated_at = issue.updated_at
      end

      def to_markdown
        "[#{title}](#{url})"
      end

      private
      attr_reader :title
    end
  end
end
