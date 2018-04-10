# YAML Cache ![TravisCI](https://travis-ci.org/HellRok/YAMLCache.svg?branch=master)

This is a simple gem written in plain ruby just to store and cache data in a
yaml file.

## Installation

Add this line to your application's Gemfile:

```ruby gem 'yaml_cache' ```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yaml_cache

## Usage

To save and retrieve simple data all you need to do is:

```
require 'yaml_cache'

store = YAMLCache.new('store.yml')
store.write('example', 'Here is some example text')
store.read('example')
```

`#write` will return the amount of bytes written to the file, this may change
in the past.

To cache a block you'll need to do something more like:

```
require 'yaml_cache'

store = YAMLCache.new('store.yml')

store.cache('key_1', 3600) {
  'Some data'
}

# or

store.cache('key_2', 60) do
  'Some other data'
end
```

The first argument is the key to store the data under while the second argument
is how many seconds to cache this for. If you call `#cache` with the same key
again before it expires it will just return the value intsead of running the
block.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake test` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/HellRok/YAMLCache

## License

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).
