# BellPepper

This is a wrapper on the [Biodiversity Enhanced Location Services (BELS) Georeference API](https://github.com/VertNet/bels). Code follow the spirit/approach of the Gem [serrano](https://github.com/sckott/serrano), and indeed much of the wrapping utility is copied 1:1 from that repo, thanks [@sckott](https://github.com/sckott).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bell_pepper'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install bell_pepper

## Usage

```ruby
 res = BellPepper.bestgeoref(id: "1", locality: "Meadowbrook Park", city: "Urbana", state_province: "Illinois", country_code: "US") #  => MultiJson object
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SpeciesFileGroup/bell_pepper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/SpeciesFileGroup/bell_pepper/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [NCSA/Illinois](https://github.com/SpeciesFileGroup/bell_pepper/blob/main/LICENSE.txt).

## Code of Conduct

Everyone interacting in the BellPepper project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/SpeciesFileGroup/bell_pepper/blob/main/CODE_OF_CONDUCT.md).
