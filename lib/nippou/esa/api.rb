require 'date'
require 'json'
require 'nippou/esa/post'

module Nippou
  module Esa
    class API
      def initialize(config)
        @config = config
      end

      def list(since_date: Date.today)
        markdown = "**esa**\n"
        config.esa_teams.each do |team|
          markdown << "* #{team}\n"
          posts = fetch_posts(team: team, since_date: since_date)
          markdown << posts.map {|post| "    * #{post.to_markdown}" }.join("\n")
          markdown << "\n"
        end
        markdown
      end

      private
      attr_reader :config

      END_POINT = "https://api.esa.io"
      def fetch_posts(team:, since_date:)
        conn = Faraday.new(url: END_POINT) do |builder|
          builder.request  :url_encoded
          # builder.response :logger
          builder.adapter  :net_http
        end

        page = 1
        posts = []
        path = "/v1/teams/#{team}/posts?sort=created&q=user%3A#{config.esa_username}+updated%3A%3E#{since_date.strftime('%Y-%m-%d')}"
        loop do
          response = conn.get do |req|
            req.url path, page: page, per_page: 100
            req.headers['Authorization'] = "Bearer #{config.esa_token}"
          end
          json = JSON.parse(response.body)
          posts += JSON.parse(response.body)['posts'].map {|post| Post.new(post)}
          page = json['next_page']
          break unless page
        end
        posts
      end
    end
  end
end
