require 'rb-inotify'
require 'seth/store/kv_backend'

module Seth
module Store
class KV

  def initialize(config)
    @_local_cache = {}
    @_config_path = config[:path]
    @_backend = Seth::Store::KVBackend.create(config)
    start_watching_config
    update_cache!
  end

  def set(key, value)
    @_local_cache[key] = value
    update_remote_store(key, value)
  end

  def get(key)
    @_local_cache[key]
  end

  def delete(key)
    @_local_cache.delete! key
  end


  private 

  def update_remote_store(key, value)
    @_backend.update!(local_state_to_kv_format)
  end

  def local_state_to_kv_format
    @_local_cache.reduce ("") do |acc, kv|
      acc.concat("#{kv[0]}=#{kv[1]}\n")
    end
  end

  def start_watching_config
    Thread.new do
      notifier = INotify::Notifier.new
      notifier.watch(@_config_path, :modify) { update_cache! }
      notifier.run
    end
  end
  
  def update_cache!
    @_local_cache = 
      File.readlines(@_config_path).reduce({}) do |acc, line| 
        key, val = line.split("=")
        acc[key.strip] = val.strip
        acc
      end
  end
end
end
end
