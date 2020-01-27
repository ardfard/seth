module Seth
  module Store
    module KVBackend
      def create(config)
        case config[:kv_backend] 
        when :consul
          require 'seth/store/kv_backend/consul'
          return Consul.new(config)
        when :zookeeper
          requre 'seth/store/kv_backend/zookeeper'
        end
      end
    end
  end
end
