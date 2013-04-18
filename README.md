# Weighted

## Getting started

    bundle install
    bundle exec rake db:create
    bundle exec rake db:migrate
    foreman start


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


## Running tests

    foreman run bundle exec guard

## Assets
Assets are automatically uploaded on AWS S3 using (asset_sync)[https://github.com/rumblelabs/asset_sync] and served through a Cloudfront distribution.
