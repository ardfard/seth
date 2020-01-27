require 'zk'

module Seth
  module Store
    module KVBackend
      class Zookeeper
        def initialize(config)
          @_zk = ZK.new(config[:host], thread: :per_callback)
          @_znode_path = config[:znode_path]
        end

        def update!(payload)
          @_zk.set(@_znode_path, payload)
        end
      end
    end
  end
end
