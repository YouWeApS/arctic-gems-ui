---
title: Arctic Core API SDK Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - ruby
  - php

toc_footers:
  - <a href='mailto:info@youwe.dk'>Contact us for an account</a>

includes:
  - errors

search: true
---

# Introduction

The Arctic Core API is the central API for easy synchronization and distribution of your e-commerce goods to a wide range or e-commerce platforms.

This SDK gives you a programmable way to interact with the Core API. You can also explore the API in a more interactive and direct way via our [Swagger documentation](https://arctic-core.herokuapp.com).

# Authentication

```ruby
require 'arctic-core-api'

api = Arctic::Core::API.new YOUR_CLIENT_ID, YOUR_CLIENT_SECRET
# => <#Arctic::Core::API>

bearer_token = api.authorize!(email, password)
# => 746cd2cdc74cd5f0f91f2031ab47569377118a247972d29f40fcf1ac4814eedb
```

```php
<?
require 'arctic-core-api';

define("YOUR_CLIENT_ID", "YOUR_CLIENT_ID");
define("YOUR_CLIENT_SECRET", "YOUR_CLIENT_SECRET");

$api = new Arctic::Core::API(YOUR_CLIENT_ID, YOUR_CLIENT_SECRET);
# => <#Arctic::Core::API>

bearer_token = $api->authorize!(email, password);
# => 746cd2cdc74cd5f0f91f2031ab47569377118a247972d29f40fcf1ac4814eedb
?>
```

> Make sure to replace `YOUR_CLIENT_ID`, `YOUR_CLIENT_SECRET`, `email`, and `password` with the credentials we send you when you get your account.

To get a set of credentials, please <a href="mailto:info@youwe.dk">get in touch</a> with us.

After you sign up for an account, you will get a `client_id`, `client_secret`, `email`, and a `password`. All of which you will need to access the API.

The Arctic project account that you sign up for can have multiple users. Under the hood the SDK uses OAuth2 to exchange your personal email and password for a token to access your account.

The `client_id` and the `client_secret` should be stored inside your application. The `email` and `password` should be supplied by the user of your application.

<aside class="notice">For the rest of the documentation it's assumes that we're working with an authenticated API instance object.</aside>

# Account

## Get the user's account

```ruby
api.account
```

```php
<?
$api->account();
?>
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

## Update the user's account

```ruby
api.accountUpdate name: 'New Account Name'
```

```php
<?
$api->accountUpdate({ 'name' => 'New Account Name' });
?>
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

## List your shops

This will return a list of the shops available on your account.

```ruby
api.shops
```

```php
<?
$api->shops();
?>
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
