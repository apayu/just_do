[![Build Status](https://travis-ci.org/apayu/just_do.svg?branch=master)](https://travis-ci.org/apayu/just_do)

# What is this?

this is *just do*

a manage task tool

you know people always think and no want to do it

this help you better and remeber...just do it

# How to deploy?

clone this repositroy, and you can use [heroku](https://heroku.com/ "heroku"), it's easy to deploy

1.login to heroku.

2.install Heroku Cli.

3.use this commend to create new heroku project.

    $ heroku create

4.use git push your project to heroku.

    git push heroku master

5.if first time deploy, remember run rails db:migrate, and don't use SQLite, because heroku doesn't support.

    heroku run rails db:migrate

6.Verifying deploy.... done. if you see this message, congratulation!

enjoy:)
