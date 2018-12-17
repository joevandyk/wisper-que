require 'spec_helper'
require 'uri'
require 'pg'
require 'connection_pool'

uri = URI.parse(ENV['DATABASE_URL'] || "postgres://localhost/wisper-que-test")

Que.connection = ConnectionPool.new(size: 1) do
  PG::Connection.open(
      host:     uri.host,
      user:     uri.user,
      password: uri.password,
      port:     uri.port || 5432,
      dbname:   uri.path[1..-1]
  )
end

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
