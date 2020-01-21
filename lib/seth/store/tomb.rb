require 'rb-inotify'

class Seth::Store::Tomb

  def initialize(config)
    @_local_cache = {}
    @_config_path = config[:path]
    Thread.new do
      notifier = INotify::Notifier.new
      notifier.watch(@_config_path, :modify) { update_cache! }
      notifier.run
    end
    update_cache!
  end

  def set(key, value)
    @_local_cache[key] = value
    update_tomb(key, value)
  end

  def get(key)
    @_local_cache[key]
  end

  def delete(key)
    @_local_cache.delete! key
  end


  private 

  def update_tomb!(key, value)
    true
  end

  def start_watching

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
