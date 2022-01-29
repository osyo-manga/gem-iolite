# Iolite v2

Lazy block library.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'iolite'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install iolite

## Usage

### Simple

```ruby
require "iolite"

# using arg1, arg2... and Object#to_lazy
using Iolite

p [1, 2, 3].map &arg1 + arg1
# => [2, 4, 6]

p [10, 20, 30].map &arg1.to_s(2)
# => ["1010", "10100", "11110"]


5.times &to_lazy.p(arg1 + 3)
```

### Compare block

```ruby
require "iolite"

using Iolite


#######################################
# Using block
p (1..5).map { |it| it + 3 }
# => [4, 5, 6, 7, 8]

p (1..5).inject { |memo, item| memo + item }
# => 15

p ["homu", "mami", "an"].inject(0) { |memo, item| memo + item.length }
# => 10

p [{name: :homu}, {name: :mami}].map { |it| it[:name] }
# => [:homu, :mami]

5.times{ |it| p it + 5 }


#######################################
# Using iolite
p (1..5).map &arg1 + 3
# => [4, 5, 6, 7, 8]

p (1..5).inject &arg1 + arg2
# => 15

p ["homu", "mami", "an"].inject 0, &arg1 + arg2.length
# => 10

p [{name: :homu}, {name: :mami}].map &arg1[:name]
# => [:homu, :mami]
```

### Convert Lazy object

```ruby
require "iolite"

using Iolite

# return Lazy.new { 42 }.to_s
_42_to_s = 42.to_lazy.to_s(arg1)

pp [2, 8, 16].map &_42_to_s
# => ["101010", "52", "2a"]

1.to_lazy.upto(arg1, &to_lazy.puts("number is ".to_lazy + arg1.to_s)).call(5)
# => number is 1
#    number is 2
#    number is 3
#    number is 4
#    number is 5

result = []
(1..5).map &result.to_lazy << arg1 * arg1
pp result
# => [1, 4, 9, 16, 25]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/osyo-manga/gem-iolite.

## Release note

### v2.0.0

* Release New!
* Refactoring all

### v0.0.3

* Fix dcs typo.

### v0.0.2

* Fix Iolite::Statement module method.
* Add `iolite/adaptored/proc_with_callable`.

### v0.0.1

* Release


