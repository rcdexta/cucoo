When(/^I send a POST request to "([^"]*)" with the following:$/) do |url, params|
  Cucoo::Driver.post url, params.hashes.first
end

When(/^I make a GET request to "([^"]*)"$/) do |url|
  Cucoo::Driver.get url
end

Then(/^the response should be OK$/) do
  expect(Cucoo::Driver.response.code).to be_between(200, 201).inclusive
end

Then(/^the response should be 200$/) do
  expect(Cucoo::Driver.response.code).to eq(200)
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

When(/^I send a POST request to "([^"]*)" with headers "([^"]*)" and the following params:$/) do |url, headers, params|
  header, value = headers.split(':')
  Cucoo::Driver.post_with_header url, {header => value, 'Content-type' => 'text/plain; charset=UTF-8'},  params.hashes.first.to_json
end

When(/^I send a SQS trigger to "([^"]*)" with json:$/) do |url, json|
  Cucoo::Driver.post_with_header url, {'Content-type' => 'text/plain; charset=UTF-8'}, {'Type' => 'Notification', 'Message' => json}.to_json
end

When(/^I send a invalid SQS trigger to "([^"]*)" with json:$/) do |url, json|
  Cucoo::Driver.post_with_header url, {'Content-type' => 'text/plain; charset=UTF-8'}, {'Type' => 'Notification', 'Content' => json}.to_json
end