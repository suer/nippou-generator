require 'nippou/github/issue'
:w
module Nippou
  module Github
    class SearchResult
      def initialize(issues)
        @issues = issues
      end

      def to_markdown
        per_repo = {}
        issues.each do |issue|
          per_repo[issue.repository] = [] unless per_repo[issue.repository]
          per_repo[issue.repository] << issue
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
      attr_reader :issues
    end
  end
end
