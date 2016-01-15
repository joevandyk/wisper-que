require 'spec_helper'
require 'pg'

Que.connection = PG::Connection.open("postgres://localhost/wisper-que-test")
Que.mode = :sync

describe Wisper::Que do
  it 'has a version number' do
    expect(Wisper::Que::VERSION).not_to be nil
  end

  # TODO come up with a test that's not stupid.

  class Joe
    include Wisper::Publisher
    def call
      broadcast(:sup, 'joe')
    end
  end

  class SomeJob
    extend Wisper::Publisher
    def self.sup(args)
      $result ||= []
      $result << "i got #{args}"
    end
  end

  it 'calls SomeJob' do
    joe = Joe.new
    joe.subscribe(SomeJob, async: true)
    joe.subscribe(SomeJob, que: true)
    joe.call

    expect($result).to be == ["i got joe", "i got joe"]
  end
end
