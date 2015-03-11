#json_spec steps
def last_json
  Cucoo::Driver.response.body
end

#API Steps
When /^I make a POST to "([^"]*)" with:$/ do |url, params|
  Cucoo::Driver.post url, params.hashes.first
end

When /^I make a POST to "([^"]*)"$/ do |url|
  Cucoo::Driver.post url
end

When /^I make a POST to "([^"]*)" with headers "([^"]*)" and the following params:$/ do |url, headers, params|
  header, value = headers.split(':')
  Cucoo::Driver.post_with_header url, {header => value, 'Content-type' => 'text/plain; charset=UTF-8'},  params.hashes.first.to_json
end

When /^I make a GET to "([^"]*)"$/ do |url|
  Cucoo::Driver.get url
end

When /^I make a DELETE to "([^"]*)"$/ do |url|
  Cucoo::Driver.delete url
end

When /^I make a DELETE to "([^"]*)" with:$/ do |url, params|
  Cucoo::Driver.delete url, params.hashes.first
end

And /^the response error message should be "([^"]*)"$/ do |message|
  expect(Cucoo::Driver.response['error']).to eq(message)
end

And /^the response body must be "([^"]*)"$/ do |body|
  expect(Cucoo::Driver.response.to_s).to eq(body)
end

When /^I send a PUT request to "([^"]*)" with:$/ do |url, params|
  Cucoo::Driver.put url, params.hashes.first
end

# Stub Steps
Given /^I expect a POST to "([^"]*)" with:$/ do |url, table|
  params = table.hashes.first
  stub_my_request(:post, url, params)
end

Given /^I expect a POST to "([^"]*)" with json request:$/ do |url, json|
  stub_my_request(:post, url, {request: JSON.parse(json)})
end

Given /^I expect a PUT to "([^"]*)" with json request:$/ do |url, json|
  stub_my_request(:put, url, {request: JSON.parse(json)})
end

And /^I expect a GET to "([^"]*)" with:$/ do |url, table|
  params = table.hashes.first
  stub_my_request(:get, url, params)
end

And /^I expect a GET to "([^"]*)" with json response:$/ do |url, json|
  stub_my_request(:get, url, {response: json})
end

Given /^I expect a GET to "([^"]*)" and return NOT FOUND$/ do |url|
  stub_my_request(:get, url, {status: 404})
end

And /^I expect a DELETE to "([^"]*)"$/ do |url|
  stub_my_request(:delete, url, {})
end

Then /^the response should be OK$/ do
  expect(Cucoo::Driver.response.code).to be_between(200, 201).inclusive
  assert_all_stubs!
end

Then /^the response should be NOT FOUND$/ do
  expect(Cucoo::Driver.response.code).to eq(404)
  assert_all_stubs!
end

Then /^the response should be BAD REQUEST$/ do
  expect(Cucoo::Driver.response.code).to eq(400)
  assert_all_stubs!
end

Then /^the response code should be "([^"]*)"$/ do |code|
  expect(Cucoo::Driver.response.code).to eq(code.to_i)
  assert_all_stubs!
end
