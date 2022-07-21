## README

This README would normally document whatever steps are necessary to get the
application up and running.

## Status

[![Homepage](http://img.shields.io/badge/home-allslavic.org-blue.svg)](http://allslavic.org)
[![GitHub](http://img.shields.io/badge/github-znamenica/allslavic-blue.svg)](http://github.com/znamenica/allslavic)
[![MIT License](http://b.repl.ca/v1/License-MIT-blue.png)](LICENSE)
[![Build Status](https://circleci.com/gh/znamenica/allslavic/tree/master.svg?style=svg)](https://circleci.com/gh/znamenica/allslavic/tree/master)
[![Code Climate](https://codeclimate.com/github/znamenica/allslavic/badges/gpa.svg)](https://codeclimate.com/github/znamenica/allslavic)
[![Test Coverage](https://codeclimate.com/github/znamenica/allslavic/badges/coverage.svg)](https://codeclimate.com/github/znamenica/allslavic)

## Requirements

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
