Given(/^I expect a POST to "([^"]*)" with the following setup:$/) do |url, table|
  params = table.hashes.first
  stub_my_request(:post, url, params)
end

Then(/^the response should be OK$/) do
  expect(Cucoo::Driver.response.code).to be_between(200, 201).inclusive
  assert_all_stubs!
end

Then(/^the response should be NOT FOUND$/) do
  expect(Cucoo::Driver.response.code).to eq(404)
  assert_all_stubs!
end

Then(/^the response should be BAD REQUEST$/) do
  expect(Cucoo::Driver.response.code).to eq(400)
  assert_all_stubs!
end

Then(/^the response code should be "([^"]*)"$/) do |code|
  expect(Cucoo::Driver.response.code).to eq(code.to_i)
  assert_all_stubs!
end

Given(/^I expect a POST to "([^"]*)" with the following json request:$/) do |url, json|
  stub_my_request(:post, url, {request: JSON.parse(json)})
end

Given(/^I expect a PUT to "([^"]*)" with the following json request:$/) do |url, json|
  stub_my_request(:put, url, {request: JSON.parse(json)})
end

And(/^I expect a GET to "([^"]*)" with the following setup:$/) do |url, table|
  params = table.hashes.first
  stub_my_request(:get, url, params)
end

Given(/^I expect a GET to "([^"]*)" and return NOT FOUND$/) do |url|
  stub_my_request(:get, url, {status: 404})
end

And(/^I expect a DELETE to "([^"]*)"$/) do |url|
  stub_my_request(:delete, url, {})
end
