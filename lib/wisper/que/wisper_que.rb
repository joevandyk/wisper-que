require 'singleton'

class WisperQue
  include Singleton

  attr_accessor :queue_name

  def initialize
    @queue_name = Que.default_queue
  end

  def self.configure
    yield self.instance
  end
end
