require 'nippou'
require 'thor'

module Nippou
  class Cli < Thor
    desc 'github', 'generate from github activity'
    option 'config', aliases: 'c', type: :string, required: true
    option 'since', aliases: 's', type: :string
    def github
      config = Config.new(options['config'])
      since = options['since'] ? Date.parse(options['since']) : Date.today
      puts Github::API.new(config).list(since_date: since)
    end

    desc 'esa', 'generate from esa activity'
    option 'config', aliases: 'c', type: :string, required: true
    option 'since', aliases: 's', type: :string
    def esa
      config = Config.new(options['config'])
      since = options['since'] ? Date.parse(options['since']) : Date.today
      puts Esa::API.new(config).list(since_date: since)
    end

    desc 'gcal', 'generate from Google Calendar'
    option 'config', aliases: 'c', type: :string, required: true
    option 'since', aliases: 's', type: :string
    def gcal
      config = Config.new(options['config'])
      since = options['since'] ? Date.parse(options['since']) : Date.today
      puts GoogleCalendar::API.new(config).list(since_date: since)
    end

    desc 'gcal_prepare', 'get token form Google Calendar API'
    option 'config', aliases: 'c', type: :string, required: true
    option 'since', aliases: 's', type: :string
    def gcal_prepare
      config = Config.new(options['config'])
      GoogleCalendar::API.new(config).prepare
    end

    desc 'all', 'generate all'
    option 'config', aliases: 'c', type: :string, required: true
    option 'since', aliases: 's', type: :string
    def all
      github
      esa
      gcal
    end
  end
end
