## README

This README would normally document whatever steps are necessary to get the
application up and running.

## Status

[![Homepage](http://img.shields.io/badge/home-allslavic.org-blue.svg)](http://allslavic.org)
[![Website allslavic.org](https://img.shields.io/website-up-down-green-red/http/api.allslavic.org.svg)](http://allslavic.org/)
[![GitHub](http://img.shields.io/badge/github-znamenica/allslavic-blue.svg)](http://github.com/znamenica/allslavic)
[![GitHub tag](https://img.shields.io/github/tag/znamenica/allslavic.svg)](https://GitHub.com/znamenica/allslavic/tags/)
[![Open Source? Yes!](https://badgen.net/badge/Open%20Source%20%3F/Yes%21/blue?icon=github)](https://github.com/znamenica/allslavic)
[![GPLv2 license](https://img.shields.io/badge/License-GPLv2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt)
[![Rails Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop-rails)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/7b54042517c742398b88d07d304de786)](https://www.codacy.com/gh/znamenica/allslavic/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=znamenica/allslavic&amp;utm_campaign=Badge_Grade)
[![Build Status](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Fznamenica%2Fallslavic%2Fbadge&style=flat&logo=none)](https://actions-badge.atrox.dev/znamenica/allslavic/goto)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](https://github.com/znamenica/allslavic/pulls)
[![Telegram](https://badgen.net/badge/icon/telegram?icon=telegram&labe)](https://t.me/interslavic)

## Requirements

These requirements are for the ALT linux server:

1. libhiredis-devel
2. libsnappy-devel
3. redis
4. xclip
5. sidekiq
6. postgresql14-server-devel
7. postgresql14-server


Install requirements by single line:

```bash
apt-get install libhiredis-devel libsnappy-devel redis xclip sidekiq postgresql14-server-devel postgresql14-server
```

## Setup

```bash
$ cap production setup
```

### Restart server

```bash
$ cap production deploy:restart
```

### Deploy

```bash
$ cap production deploy
```

### Deploy with a server restart

```bash
$ cap production deploy deploy:restart
```
