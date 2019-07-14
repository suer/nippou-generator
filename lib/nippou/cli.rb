require 'nippou'
require 'thor'

module Nippou
  class Cli < Thor
    desc 'github', 'generate from github activity'
    def github(since_date = nil)
      s = since_date ? Date.parse(since_date) : Date.today
      puts Github::API.new.list(since_date: s)
    end
  end
end
