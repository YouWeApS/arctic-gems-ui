---
title: Arctic UI API SDK Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - ruby

toc_footers:
  - <a href='mailto:info@youwe.dk'>Contact us for an account</a>

includes:
  - errors

search: true
---

# Introduction

The Arctic UI API are the available endpoints for building UI applications to view and interact with the Arctic project core.

This SDK gives you a programmable way to interact with the UI API. You can also explore the API in a more interactive and direct way via our [Swagger documentation](https://arctic-core.herokuapp.com).

# Installation

```ruby
gem 'arctic-ui'
```

# Configuration

```ruby
require 'arctic/ui'

Arctic::UI.configure do |config|
  config.client_id = "CLIENT_ID"
  config.client_secret = "CLIENT_SECRET"
end
```

> Make sure to replace `YOUR_CLIENT_ID` and `YOUR_CLIENT_SECRET` with the information from the account given to you.

After we have setup an account for you, you will get a `CLIENT_ID` and `CLIENT_SECRET`.

The `CLIENT_ID` and the `CLIENT_SECRET` should be stored inside your application in a secure way.

To get a set of credentials, please <a href="mailto:info@youwe.dk">get in touch</a> with us.

# Authentication

```ruby
require 'arctic/ui'

api = Arctic::UI::API.new email, password
```

The `email` and `password` should be supplied by the user. The user should be associated with your account.

You can setup, create and manage users for your account in your [Arctic Backoffice](https://arctic.com/backoffice).

<aside class="notice">For the rest of the documentation it's assumes that you have sucessfully completed the Configuration and Authentication steps.</aside>

# Account

## Get account information

```ruby
api.get_account
```

> Example response

```json
{
  "id": "735108ed-55ef-4314-8295-b57fb0d1e05c",
  "name": "Bob's webshop",
  "throttling": {
    "interval": 1,
    "amount": 100,
    "current": 99
  }
}
```

The user's account represents the account object. This is the central object that all users and shops are related to. This also holds your rate limit information (see the Rate Limiting section).

## Update account information

```ruby
api.update_account name: 'New Account Name'
```

> Example response

```json
{
  "id": "735108ed-55ef-4314-8295-b57fb0d1e05c",
  "name": "New Account Name",
  "throttling": {
    "interval": 1,
    "amount": 100,
    "current": 74
  }
}
```

Possible account attributes you can update

Attribute | Description
--------- | -----------
name | The human readable name of your account

# Shops

## List shops

```ruby
api.get_shops
```

> Example response

```json
[
  {
    "id": "2270b57a-80ee-4a44-9cd3-014c0469b39d",
    "name": "Danish shop"
  },
  {
    "id": "a30c348a-0396-4c86-8aee-3af3c782862c",
    "name": "Swedish shop"
  }
]
```

This will return a list of the shops available on your account.

## Update an existing shop's information

```ruby
api.update_shops id: 'a30c348a-0396-4c86-8aee-3af3c782862c', name: 'Norwegian shop'
```

> Example response

```json
{
  "id": "a30c348a-0396-4c86-8aee-3af3c782862c",
  "name": "Norwegian shop"
}
```

Possible shop attributes to update

Attribute | Type | Description
--------- | ---- | -----------
name | String | The human readable identifier of the shop on the Arctic platform
preprocessors | Array | A list of preprocessor IDs to use for your shop

# Preprocessors

## List available preprocessors

```ruby
api.get_preprocessors
```

> Example response

```json
[
  {
    "id": "8680cc9b-12d5-4bbd-a4ff-f176ef90d676",
    "name": "Dandomain"
  },
  {
    "id": "062da138-c0c1-46b2-b0fd-b43f9a2ad888",
    "name": "Amazon UK"
  },
]
```

A preprocessor represents a connection between where you're hosting your webshop (e.g. Dandomain) and our system. A preprocessor will pull the items from your system into the Arctic system, from where they will be distributed throug Postprocessors.
