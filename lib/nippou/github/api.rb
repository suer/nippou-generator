require 'octokit'
require 'nippou/github/search_result'
require 'nippou/github/config'

module Nippou
  module Github
    class API
      def list
        result = client.search_issues 'is:pr reviewed-by:suer', per_page: 100
        SearchResult.new(result).to_markdown
      end

      private
      def client
        Octokit::Client.new(access_token: Config.github_token)
      end
    end
  end
end
