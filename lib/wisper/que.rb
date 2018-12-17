require "wisper/que/version"
require "wisper/que/wisper_que"
require "que"
require "wisper"

module Wisper
  class Que

    def broadcast(subscriber, _publisher, event, args)
      Wrapper.enqueue(subscriber.name, event, args, queue: WisperQue.instance.queue_name)
    end

    class Wrapper < ::Que::Job
      def run(class_name, event, args)
        listener = ::Que.constantize(class_name)
        listener.public_send(event, *args)
      end
    end

    def self.register
      Wisper.configure do |config|
        config.broadcaster :que,   Que.new
        config.broadcaster :async, Que.new
      end
    end
  end
end

Wisper::Que.register
