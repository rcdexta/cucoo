# Cucoo

Cucumber steps and assertions for testing your APIs. This gem offers a DSL on top of webmock, cucumber and json_spec to make testing APIs on rails easier.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cucoo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cucoo

## Configuration

Cucoo comes as a package with the following gems installed

* [json_spec](https://github.com/collectiveidea/json_spec)
* [cucumber](https://github.com/cucumber/cucumber-rails)
* [webmock](https://github.com/bblimke/webmock)

A typical env.rb would look like this:
 
```ruby
require 'cucoo/rails'

ActionController::Base.allow_rescue = false

require File.expand_path('../../../config/environment', __FILE__)

Capybara.default_driver = :selenium

Cucumber::Rails::Database.javascript_strategy = :truncation

Cucoo.config do |config|
  config.app_port = 6666
  config.stub_host = 'localhost'
  config.stub_port = 4080
end
```

This will start your application on port 6666 on localhost and assume the external services are stubbed at specified host and port.

## First Test
Our app responds to a url `/health/ping.json` with ping. The test to assert this is as follows
```cucumber
Scenario: Health Checker
    Given I make a GET to "/health/ping.json"
    Then the response should be OK
    And the response body must be "pong"
```
## Contributing

1. Fork it ( https://github.com/[my-github-username]/cucoo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
