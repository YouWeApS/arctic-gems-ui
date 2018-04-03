# Arctic Core API gem

This gem is used by the arctic receivers to interact with and send data to the
arctic core API.

## Usage

Installation

```
gem 'arctic_core'
```

Then configure it

```ruby
ArcticCore.configure do |config|
  config.token = 'PreSharedReceiverAuthToken'
end
```

Then connect to the producer of data (fx. Dandomain) and retrieve and reformat
the information to Arctic core compatible json.

```ruby
arctic_compatible_json = {
  # arctic compatible jsom goes here
}
ArcticCore.post arctic_compatible_json
```
