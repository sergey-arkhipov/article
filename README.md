# README

## This is work in process on example Rails 7 app with

- Rails 7
- importmap
- elasticsearch
- bulma
  
The application is designed to create articles with the ability to quickly search, edit articles with version storage, quickly create a new version of an article based on an existing one.
You can view and delete versions.
The application works with the Russian language and supports localization.

## Version

1. ruby 3.1.2p20 (2022-04-12 revision 4491bb740a) [x86_64-darwin20]
2. Rails 7.0.4
3. Elasticsearch Version: 8.5.1
4. Postgres pg_ctl (PostgreSQL) 14.5 (Homebrew)

## Configuration

### Install elasticsearch

**Two ways:**

1. [Download and unzip Elasticsearch](https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.5.2-darwin-x86_64.tar.gz)
2. brew install elasticsearch

**The difference between ways**

1. Current version 8.5.2
2. Curent version

```console
% brew info elasticsearch
==> elasticsearch: stable 7.10.2 (bottled)
Distributed search & analytics engine
https://www.elastic.co/products/elasticsearch
Disabled because it is switching to an incompatible license. Check out `opensearch` instead!
Not installed
From: https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/elasticsearch.rb
License: Apache-2.0
```

## Installation

### Install postgress

```console
% brew install postgress
```

### Download app

```console
% git clone git@github.com:sergey-arkhipov/article.git
```

### Install

```console
% cd article
% bundle install
```

### Configure

```console
% vim config/database.yml  #Postgres connect
% vim vim config/initializers/elasticsearch.rb # Elasticsearch config
% vim Procfile # Configure path to elasticsearch
```

ELASTIC_PASSWORD and CERT_FINGERPRINT required if elasticseach has been installed by first way or you simply preffered secure connection between app and elastic.

```console
% rails db:setup #Create DB, fill with seeds.rb
```

## Run tests

```console
% ./bin/rails t
% ./bin/rspec --color -f d
```
