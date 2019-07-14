module Nippou
  module Github
    class Config
      def self.github_token
        IO.popen('git config github-nippou.token') {|io| io.gets.chomp }
      end
    end
  end
end
