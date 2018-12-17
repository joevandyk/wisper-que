# Wisper::Que

Provides [Wisper](https://github.com/krisleech/wisper) with asynchronous event
publishing using [Que](https://github.com/chanks/que) actors.

## Installation

```ruby
gem 'wisper-que'
```

## Configuration

Custom Queue Name

`config/initializers/wisper_que.rb`
```
WisperQue.configure do |c|
  c.queue_name = 'wisper' # or 'default'
end
```

## Usage

```ruby
require 'wisper/que'

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

Run Que with custom queue name:
```bash
 que -q wisper
```


## Contributing

Yes please, either submit a PR or open an issue first to discuss your thoughts.
