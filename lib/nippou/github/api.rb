require 'octokit'
require 'nippou/github/search_result'
require 'nippou/github/config'
require 'date'

module Nippou
  module Github
    PER_PAGE = 100

    class API
      def list(since_date: Date.today - 100)
        user = 'suer'
        author = search(type: 'author', user: user, since_date: since_date)
        reviewedBy = search(type: 'reviewed-by', user: user, since_date: since_date)

        markdown = '**Review**'
        markdown << "\n"
        markdown << SearchResult.new(author).to_markdown
        markdown << "\n"
        markdown << '**Author**'
        markdown << "\n"
        markdown << SearchResult.new(reviewedBy).to_markdown
        markdown << "\n"
        markdown
      end

      private
      def client
        Octokit::Client.new(access_token: Config.github_token)
      end

      def search(type:, user:, since_date:)
        issues = []
        page = 1
        query = "is:pr #{type}:#{user} updated:>=#{since_date.strftime('%Y-%m-%d')}"
        loop do
          result = client.search_issues(query, page: page, per_page: PER_PAGE)
          issues += result.items.map {|issue| Issue.new(issue) }
          break if page * PER_PAGE >= result.total_count
          page += 1
        end
        issues
      end
    end
  end
end
