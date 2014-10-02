# Monkeypatchable

## Currently being developed, nothing useful yet. Please come back

An exception will remind you to check your monkeypatched methods when you update
your ruby or rails version.

## Installation

Add this line to your application's Gemfile:

    gem 'monkeypatchable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install monkeypatchable

## Usage

Adding this file (with your real current versions) to the root of your app

    # ./monkeypatchable.rb
    # Don't fix the version until you checked your monkey patches are working properly
    Monkeypatch::RUBY_VERSION  = '2.1.3'
    Monkeypatch::RAILS_VERSION = '4.1.2'

You can monkeypatch your language / framework methods like so:

    class Date
      Monkeypatch.add do # <= functionality provided by the gem
        def self.safe_parse(value, default: :unparsable_date) # <= new method in foreign class
          Date.parse(value.to_s)
        rescue ArgumentError
          default
        end
      end
    end

    class BigDecimal
      Monkeypatch.override do # <= functionality provided by the gem
        def inspect # <= existing method in external class
          "#<BigDecimal #{to_f}>"
        end
      end
    end

It works by also adding your new methods to an instance of object, so don't do too
fancy stuff in `add` and `override` blocks.

### After changing version

    # TODO: describe the error
    #       provide help on how to fix it

## Contributions are Welcome

1. [Fork it](https://github.com/ecoologic/monkeypatchable/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
