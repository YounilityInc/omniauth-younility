# Omniauth Younility Strategy

Version 1.0.0

OAuth2 strategy for [`omniauth`](http://rubygems.org/gems/omniauth) and
[Younility](https://www.younility.com/).

## Installation

Add this line to your application's Gemfile:

```sh
gem 'omniauth-younility'
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install omniauth-younility
```

## Demo

You can see a demo of usage at [our heroku site](https://web-younility.herokuapp.com/)

## Usage

The API is currently only in private beta. Usage instructions to follow.

For now, see the source of the demo app at [our github site](http://github.com/YounilityInc/omniauth-younility-example).

### Ruby

For use in a _Sinatra_ or _Ruby on Rails_ application:

```ruby
# config/initializers/omniauth.rb
module OmniAuth
  module Strategies
    # tell OmniAuth to load the Younility strategy
    autoload :Younility, 'omniauth/strategies/younility'
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :younility, ENV['YOUNILITY_APP_ID'], ENV['YOUNILITY_APP_SECRET']
end
```

## Contributing

1. Fork it ( http://github.com/YounilityInc/omniauth-younility/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

This project is licensed under the terms of the MIT license.
