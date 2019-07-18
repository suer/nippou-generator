require 'octokit'
require 'nippou/github/search_result'
require 'date'

module Nippou
  module Github
    PER_PAGE = 100

    class API
      def initialize(config)
        @config = config
      end

      def list(since_date: Date.today)
        author = search(type: 'author', user: config.github_username, since_date: since_date)
        reviewedBy = search(type: 'reviewed-by', user: config.github_username, since_date: since_date)

        markdown = '**Author**'
        markdown << "\n"
        markdown << SearchResult.new(author).to_markdown(with_status: true)
        markdown << "\n"
        markdown << '**Review**'
        markdown << "\n"
        markdown << SearchResult.new(reviewedBy).to_markdown
        markdown << "\n"
        markdown
      end

      private
      attr_reader :config

      def client
        Octokit::Client.new(access_token: config.github_token)
      end

      def search(type:, user:, since_date:)
        issues = []
        page = 1
        query = "is:pr #{type_query(type: type, user: user)} updated:>=#{since_date.strftime('%Y-%m-%d')}"
        loop do
          result = client.search_issues(query, page: page, per_page: PER_PAGE)
          issues += result.items.map {|issue| Issue.new(issue) }
          break if page * PER_PAGE >= result.total_count
          page += 1
        end
        issues
      end

      def type_query(type:, user:)
        query = "#{type}:#{user}"
        query += " -author:#{user}" if type == 'reviewed-by'
        query
      end
    end
  end
end
