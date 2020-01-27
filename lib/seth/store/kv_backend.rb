module Seth
  module Store
    module KVBackend
      def create(config, local_state)
        case config[:kv_backend] 
        when :consul
          require 'seth/store/kv_backend/consul'
          raise "KVBackend Not implemented yet"
        when :zookeeper
          require 'seth/store/kv_backend/zookeeper'
          return Zookeeper.new(config, local_state)
        else
          raise "KV Backend not recognized."
        end
      end
    end
  end
end
