require 'nippou/github/issue'
:w
module Nippou
  module Github
    class SearchResult
      def initialize(result)
        @result = result
      end

      def to_markdown
        per_repo = {}
        result.items.each do |issue|
          per_repo[issue.repository_url] = [] unless per_repo[issue.repository_url]
          per_repo[issue.repository_url] << Issue.new(issue)
        end

        markdown = ''
        per_repo.each do |url, issues|
          markdown << "* #{url.split('/').last}\n"
          issues.each do |issue|
            markdown << "    * #{issue.to_markdown}\n"
          end
        end
        markdown
      end

      private
      attr_reader :result
    end
  end
end
