Kinesalite V2
----------

[![Docker Pulls](https://img.shields.io/docker/pulls/leonisandes/local-kinesis-v2.svg)](https://hub.docker.com/r/leonisandes/local-kinesis-v2/)

An implementation of [Amazon's Kinesis](http://docs.aws.amazon.com/kinesis/latest/APIReference/),
focussed<a href="#focussed"><sup>1</sup></a> on correctness and performance, and built on LevelDB
(well, [@rvagg](https://github.com/rvagg)'s awesome [LevelUP](https://github.com/rvagg/node-levelup) to be precise).

The Kinesis V2 equivalent of [kinesis](https://github.com/mhart/kinesalite).
I only added a new feature "initialStreams" thanks you [@mhart](https://github.com/mhart).

To read and write from Kinesis streams in Node.js, consider using the [kinesis](https://github.com/mhart/kinesis)
module.

Example
-------

```sh
$ kinesalite --help

Usage: kinesalite [--port <port>] [--path <path>] [--ssl] [options]

A Kinesis http server, optionally backed by LevelDB

Options:
--help                  Display this help message and exit
--port <port>           The port to listen on (default: 4567)
--path <path>           The path to use for the LevelDB store (in-memory by default)
--ssl                   Enable SSL for the web server (default: false)
--createStreamMs <ms>   Amount of time streams stay in CREATING state (default: 500)
--deleteStreamMs <ms>   Amount of time streams stay in DELETING state (default: 500)
--updateStreamMs <ms>   Amount of time streams stay in UPDATING state (default: 500)
--shardLimit <limit>    Shard limit for error reporting (default: 10)
--initialStreams <file> Json Array of initial streams

Report bugs at github.com/mhart/kinesalite/issues
```

Or programmatically:

```js
// Returns a standard Node.js HTTP server
var kinesalite = require('kinesalite'),
    kinesaliteServer = kinesalite({path: './mydb', createStreamMs: 50})

// Listen on port 4567
kinesaliteServer.listen(4567, function(err) {
  if (err) throw err
  console.log('Kinesalite started on port 4567')
})
```

Once running, here's how you use the [AWS SDK](https://github.com/aws/aws-sdk-js) to connect
(after [configuring the SDK](http://docs.aws.amazon.com/AWSJavaScriptSDK/guide/node-configuring.html)):

```js
var AWS = require('aws-sdk')

var kinesis = new AWS.Kinesis({endpoint: 'http://localhost:4567'})

kinesis.listStreams(console.log.bind(console))
```

Or with the [kinesis](https://github.com/mhart/kinesis) module (currently only works in https mode, when kinesalite is started with `--ssl`):

```js
var kinesis = require('kinesis')

kinesis.listStreams({host: 'localhost', port: 4567}, console.log)
```

InitialStreams Sample File
--------------------------
```
[ 
  {
    "ShardCount": 1,
    "StreamName": "string"
  }
]
```

Installation
------------

With [npm](http://npmjs.org/) do:

```sh
$ npm install -g kinesalite-v2
```

Footnotes
---------

<a id="focussed"><sup>1</sup></a>Hi! You're probably American ([and not a New Yorker editor](https://www.newyorker.com/books/page-turner/the-double-l)) if you're worried about this spelling. No worries –
and no need to open a pull request – we have different spellings in the rest of the English speaking world 🐨
