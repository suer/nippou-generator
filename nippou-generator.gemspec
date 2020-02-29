
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "nippou/version"

Gem::Specification.new do |spec|
  spec.name          = "nippou-generator"
  spec.version       = Nippou::VERSION
  spec.authors       = ["Ryo SUETSUGU"]
  spec.email         = ["suetsugu.r@gmail.com"]

  spec.summary       = %q{nippou-generator}
  spec.description   = %q{nippou-generator}
  spec.homepage      = "https://suer.hatenablog.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/suer/nippou-generator"
    spec.metadata["changelog_uri"] = "https://github.com/suer/nippou-generator"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "thor", "0.20.3"
  spec.add_dependency "octokit", "4.14.0"
  spec.add_dependency "faraday", "0.15.4"
  spec.add_dependency "google-api-client", "0.11"
end
