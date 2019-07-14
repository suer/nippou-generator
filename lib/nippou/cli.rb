require 'nippou'
require 'thor'

module Nippou
  class Cli < Thor
    desc 'github', 'generate from github activity'
    option 'config', aliases: 'c', type: :string, required: true
    def github(since_date = nil)
      config = Config.new(options['config'])
      s = since_date ? Date.parse(since_date) : Date.today
      puts Github::API.new(config).list(since_date: s)
    end
  end
end
