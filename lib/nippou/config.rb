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

    private
    attr_reader :config
  end
end
