# nippou-generator

## Installation

```
$ gem install specific_install
$ gem specific_install -l ./.git
```

## Configuration

```yaml
github:
  username: (YOUR GITHUB USERNAME)
  token: (YOUR GITHUB TOKEN)
esa:
  teams:
    - (YOUR ESA TEAM1)
    - (YOUR ESA TEAM2)
  username: (YOUR ESA USERNAME)
  token: (YOUR ESA TOKEN)
```

## Usage

```
# fetch from github
$ nippou github -c /path/to/config
# fetch from esa
$ nippou esa -c /path/to/config
# all
$ nippou all -c /path/to/config
```

## Command Line Options

* --config, -c(required): path to configuration
* --since, -s(required): start date to search pull reuqest(default: today)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/nippou-generator.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
