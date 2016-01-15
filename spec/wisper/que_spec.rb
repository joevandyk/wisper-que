require 'spec_helper'
require 'pg'

Que.connection = PG::Connection.open(ENV['DATABASE_URL'] || "postgres://localhost/wisper-que-test")
Que.mode = :sync

describe Wisper::Que do
  it 'has a version number' do
    expect(Wisper::Que::VERSION).not_to be nil
  end

  class Joe
    include Wisper::Publisher
    def call
      broadcast(:sup, 'joe')
    end
  end

  class SomeJob
    def self.sup(args)
    end
  end

  it 'calls SomeJob' do
    joe = Joe.new
    joe.subscribe(SomeJob, async: true)
    joe.subscribe(SomeJob, broadcaster: :que)
    expect(SomeJob).to receive(:sup).with("joe").twice

    joe.call
  end
end
