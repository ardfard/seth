require 'zk'

class Watcher
  def initialize
    @zk = ZK.new('192.168.241.134:2181', thread: :per_callback)
    @path = '/seth'
    @queue = Queue.new
  end

  def write_to_file(data)

    @queue.push(data)
  end

  def run
    @zk.register(@path) do |event|
      puts 'event start'
      if event.node_changed? or event.node_created?
        data = @zk.get(@path, watch: true).first
      end
    end

    puts "start watching znode"

    puts "node"
    puts @queue.pop
  end
end

# run the watcher
Watcher.new.run
