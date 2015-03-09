When(/^I send a POST request to "([^"]*)" with the following:$/) do |url, params|
  Cucoo::Driver.post url, params.hashes.first
end

When(/^I send a POST request to "([^"]*)" with headers "([^"]*)" and the following params:$/) do |url, headers, params|
  header, value = headers.split(':')
  Cucoo::Driver.post_with_header url, {header => value, 'Content-type' => 'text/plain; charset=UTF-8'},  params.hashes.first.to_json
end

When(/^I make a GET request to "([^"]*)"$/) do |url|
  Cucoo::Driver.get url
end

When(/^I send a DELETE request to "([^"]*)"$/) do |url|
  Cucoo::Driver.delete url
end

When(/^I send a POST request to "([^"]*)"$/) do |url|
  Cucoo::Driver.post url
end

When(/^I send a DELETE request to "([^"]*)" with params:$/) do |url, params|
  Cucoo::Driver.delete url, params.hashes.first
end

And(/^the response error message should be "([^"]*)"$/) do |message|
  expect(Cucoo::Driver.response['error']).to eq(message)
end

And(/^the response body must be "([^"]*)"$/) do |body|
  expect(Cucoo::Driver.response.to_s).to eq(body)
end

When(/^I send a PUT request to "([^"]*)" with the following:$/) do |url, params|
  Cucoo::Driver.put url, params.hashes.first
end

