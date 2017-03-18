require 'net/http'
require 'json'

client_id = '06f7bc0edbbf022f96e3'
client_secret = '063e06cd211dece95cf154ca6cf4696f'
xapp_token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0OTAzOTc4MzYsImlhdCI6MTQ4OTc5MzAzNiwiYXVkIjoiNThjYzcwMGIyNzViMjQyN2YzMWYwZTY5IiwiaXNzIjoiR3Jhdml0eSIsImp0aSI'
api_url = URI.parse('https://api.artsy.net/api')
response = Net::HTTP.post_form(api_url, client_id: client_id, client_secret: client_secret)
response = JSON.parse(response.body)
puts response.inspect