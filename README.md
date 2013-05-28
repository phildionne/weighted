# Weighted

## Getting started

    bundle install
    bundle exec rake db:create
    bundle exec rake db:migrate
    pagekite.py 5000 weighted.pagekite.me
    foreman start


## Running tests

    foreman run bundle exec guard


## Deploying on Heroku
First, deploy to staging:

    git checkout develop
    git push staging develop:master


Ready for production? Alright, let's do this:

    git checkout develop
    git checkout -b release-#
    # @TODO: bump version script
    git commit -a -m 'Bump version to #'
    git checkout master
    git merge --no-ff release-#
    git tag -a #
    git push prodution master


Apply release branch to develop:

    git checkout develop
    git merge --no-ff release-#
    git branch -d release-#
    git push --tags


## Assets
Assets are automatically uploaded on AWS S3 using [asset_sync](https://github.com/rumblelabs/asset_sync) and served through a Cloudfront distribution.

 - Staging `d10qu47grxb9bh.cloudfront.net`
 - Production `d2y5pqdeoz9ati.cloudfront.net`

## Flow

### Registration and Authentication
Registration and authentication are handled with [Devise](https://github.com/plataformatec/devise)

#### Registration flow

1. A user is created
2. An associated profile is created
3. An associated subscription is created. A Stripe Customer is created and associated to the subscription.

*Heads up:* These actions are wrapped in a transaction. If one of these actions fails, everything rollsback and the user is not created.

#### Authentication options

1. Authenticate through [Twitter](https://www.twitter.com)
2. Authenticate with email and password

### Users

#### Profile

#### Subscription
A subscription references a Stripe customer through its `stripe_customer_id`. See [stripe customer](https://stripe.com/docs/api?lang=ruby#customers)

In development, use card number `4242424242424242` with any CVC and a valid expiration date.

##### Webhooks
In order to receive Stripe events via webhooks in development, you must provide a public endpoint. This is achieved with [weighted.pagekite.me](http://weighted.pagekite.me). More infos about [pagekite](http://pagekite.net/)

### Collections

### Contents

### Follow / Unfollow
