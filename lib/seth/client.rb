require 'seth/store'

class Seth::Client

  def initialize()
    config = {
      store: :in_memory
    }

    yield config
    @_store = Seth::Store.create(config)
  end

  # set value for key
  def set(key, value)
    @_store.set(key, value)
  end

  # fetch value given key, return default if value not exists
  def fetch(key, default)
    val = @_store.get(key)
    unless val.nil? 
       val
    else
       @_store.set(key, default)
      default
    end
  end

end
