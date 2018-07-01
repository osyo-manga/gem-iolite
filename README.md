[![Build Status](https://travis-ci.org/osyo-manga/gem-iolite.svg?branch=master)](https://travis-ci.org/osyo-manga/gem-iolite)

# Iolite

Lazy block library.

## Installation

Add this line to your application's Gemfile:

    gem 'iolite'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install iolite

## Usage


```ruby
require "iolite"


#######################################
# Using block
#######################################

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
#######################################

# using arg1, arg2...
include Iolite::Placeholders

p (1..5).map &arg1 + 3
# => [4, 5, 6, 7, 8]

p (1..5).inject &arg1 + arg2
# => 15

p ["homu", "mami", "an"].inject 0, &arg1 + arg2.length
# => 10

p [{name: :homu}, {name: :mami}].map &arg1[:name]
# => [:homu, :mami]


# Use Object#to_lazy
require "iolite/adaptored/object_with_to_lazy"

5.times &to_lazy.p(arg1 + 3)
```

## Contributing

1. Fork it ( https://github.com/osyo-manga/gem-iolite )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Release note

### v0.2.0

* Release New!

### v0.0.3

* Fix dcs typo.

### v0.0.2

* Fix Iolite::Statement module method.
* Add `iolite/adaptored/proc_with_callable`.

### v0.0.1

* Release


