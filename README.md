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

## Ping Pong Test
Our app responds to a url `/health/ping.json` with ping. The test to assert this is as follows
```cucumber
Scenario: Health Checker
    Given I make a GET to "/health/ping.json"
    Then the response should be OK
    And the response body must be "pong"
```

## More examples

In all the examples, lets assume we are asserting calls to an external service with the url `/external_service/***`

1) Simple hello world service that accepts two post body params `message` and `says` and calls an external service. 
```cucumber
Scenario: Post Hello World
    Given I expect a POST to "/external_service/post_hello" with:
      | request                                   |
      | {"message":"Hello World", "says": "John"} |
    When I make a POST to "/hello_world" with:
      | message     | says |
      | Hello World | John |
    Then the response should be OK
```

The last line does two things. It checks if the response code is 200 and also if the expectations were satisfied. So, this must be called at the end of each scenario.

2) Let's build on top of previous example and let the app return back what the external service returns.

```cucumber
Scenario: Post Hello World and accept response
    Given I expect a POST to "/external_service/post_hello" with:
      | request                                  | response                                |
      | {"message":"Hello World","says": "John"} | {"reply":"Get some life John"}         |
    When I make a POST to "/hello_world" with:
      | message     | says |
      | Hello World | John |
    Then the response should be OK
    Then the JSON should be:
    """
    {
       "reply": "Get some life John"
    }
    """
```

Note that if the response from an external service is huge and can be read from a file, the POST expectation step can read from the file

```cucumber
Given I expect a POST to "/external_service/post_hello" with:
      | request                                  | file                                |
      | {"message":"Hello World","says": "John"} | stub/json/hello_world/response.json |
```

The file will be read relative to the rails root path.

3) Asserting a request body larger than hello world.

```cucumber
Scenario: Add a new movie
    Given I expect a POST to "/external_service/add_movie" with json request:
    """
     {
        "name": "The Godfather",
        "director": "Francis Coppola",
        "year": 1972,
        "rating": 9.2,
        "runtime": 175
     }
    """
    When I make a POST to "/movies" with:
      | name          | director        | year | rating | runtime | 
      | The Godfather | Francis Coppola | 1972 | 9.2    | 175     |
    Then the response should be OK
```

4) GET and json assertions

```cucumber
Scenario: Get next token number
    Given I expect a GET to "/external_service/next_free_slot" with:
    | response                                           |
    | {"number": 42, "stats": {"total": 110, "free": 54} |
    When I make a GET to "/next_id"
    Then the response should be OK
    And the JSON response at "stats" should be:
    """
    {"total": 110, "free": 54}
    """
```

In the above example, we have seen a slightly advanced version of asserting for json response. Please refer [json_spec doc](https://github.com/collectiveidea/json_spec#cucumber) for more examples of json response assertion.

We can also check for other response codes:

```cucumber
Then the response should be NOT FOUND #404
Then the response should be BAD REQUEST #400
Then the response code should be "302" #custom response code
```

5) PUT request

```cucumber
Scenario: Update employee details
    Given I expect a PUT to "/external_service/employee/" with json request:
    """
        {
            "id": 812,
            "name": "Steve Balmer",
            "status": "unemployed"
        }
    """
    When I make a PUT to "employees" with:
    | id  | name          | status     |  
    | 812 | Steve Balmer  | unemployed |
    Then the response should be OK
```

6) DELETE request

```cucumber
Scenario: Delete device token
    Given I expect a DELETE to "/external_service/device/ab112321adceadcdf"
    When I make a DELETE to "devices" with:
    | token             |
    | ab112321adceadcdf |
    Then the response should be OK
```

This gem is very much a work-in-progress. We will keep adding more assertions with usage. Contributions welcome

## Contributing

1. Fork it ( https://github.com/[my-github-username]/cucoo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
