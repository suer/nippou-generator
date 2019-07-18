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

    def gcal_credentials_path
      @config['gcal']['credentials_path']
    end

    def gcal_token_store_path
      File.join(File::dirname(gcal_credentials_path), 'tokens.yml')
    end

    def gcal_code
      @config['gcal']['code']
    end

    def gcal_calendar_ids
      @config['gcal']['calendar_ids']
    end

    private
    attr_reader :config
  end
end
