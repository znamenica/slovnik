## README

This README would normally document whatever steps are necessary to get the
application up and running.

## Status

[![Homepage](http://img.shields.io/badge/home-allslavic.org-blue.svg)](http://allslavic.org)
[![GitHub](http://img.shields.io/badge/github-znamenica/allslavic-blue.svg)](http://github.com/znamenica/allslavic)
[![MIT License](http://b.repl.ca/v1/License-MIT-blue.png)](LICENSE)
[![Rails Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop-rails)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/7b54042517c742398b88d07d304de786)](https://www.codacy.com/gh/znamenica/allslavic/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=znamenica/allslavic&amp;utm_campaign=Badge_Grade)

## Requirements

These requirements are for the ALT linux server:

 1. libhiredis-devel
 2. libsnappy-devel
 3. redis
 4. xclip
 5. sidekiq
 6. postgresql14-server-devel
 7. postgresql14-server

## Setup

    $ cap production setup

### Deploy

    $ cap production deploy

#### Restart server

    $ cap production deploy:restart
