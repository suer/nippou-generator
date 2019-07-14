require 'yaml'

module Nippou
  class Config

    def initialize(path)
      @config = YAML.load_file(path)
    end

    def github_username
      @config['github']['username']
    end

    def github_token
      @config['github']['token']
    end

    def esa_teams
      @config['esa']['teams']
    end

    def esa_username
      @config['esa']['username']
    end

    def esa_token
      @config['esa']['token']
    end

    private
    attr_reader :config
  end
end
