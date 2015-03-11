Feature: GET requests

  Scenario: Happy Path
    When I make a GET to "/api"
    Then the response should be OK
    Then the JSON should be:
    """
    {
      "message":"success"
    }
    """