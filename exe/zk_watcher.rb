require 'zk'

class Watcher
  def initialize
    config = {
      znode: '/seth',
      host: 'localhost:2181',
      output_path: '/tmp/seth'
    }

    yield config

    @zk = ZK.new(config[:host], thread: :per_callback)
    @path = config[:znode]
    @output = config[:output_path]
    
  end

  def write_to_file(data)
    File.open(@output, 'w') do |f| 
      f.puts(data)
    end
  end

  def run
    @zk.register(@path) do |event|
      puts 'event start'
      if event.node_changed? or event.node_created?
        data = @zk.get(@path, watch: true).first
        write_to_file data
      end
    end

    puts "Start watching znode"
    @zk.stat(@path, watch: true)

    loop { sleep 1 }
  end
end

# run the watcher
watcher = Watcher.new do |config|
  config[:host] = ENV["SETH_ZK_HOST"]
end
watcher.run
