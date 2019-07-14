require 'nippou'
require 'thor'

module Nippou
  class Cli < Thor
    desc 'github', 'generate from github activity'
    def github
      puts Github::API.new.list
    end
  end
end
