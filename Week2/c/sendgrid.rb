require 'dotenv'
require 'sendgrid-ruby'
include SendGrid
Dotenv.load
api_key = ENV['sendgrid']
data = JSON.parse("{
 "personalizations": [
    {
      "to": [
        {
          "email": "gescalona@browning.edu"
        }
      ],
      "subject": "Hello World from the SendGrid Ruby Library!"
    }
  ],
  "from": {
    "email": "gescalona@browning.edu"
  },
  "content": [
    {
      "type": "text/plain",
      "value": "Hello, Email!"
    }
  ]
}")
sg = SendGrid::API.new(api_key: api_key)
response = sg.client.mail._("send").post(request_body: data)
puts response.status_code
puts response.body
puts response.headers