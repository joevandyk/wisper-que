# Wisper::Que

Provides [Wisper](https://github.com/krisleech/wisper) with asynchronous event
publishing using [Que](https://github.com/chanks/que) actors.

## Installation

```ruby
gem 'wisper-que'
```

## Usage

```ruby
class Joe
  include Wisper::Publisher
  def call
    broadcast(:sup, 'joe')
  end
end

class SomeJob
  def self.sup(args)
    puts "i got #{ args }"
  end
end

joe = Joe.new
joe.subscribe(SomeJob, async: true)
joe.call
```

## Contributing

Yes please, either submit a PR or open an issue first to discuss your thoughts.
