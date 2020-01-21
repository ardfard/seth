class InMemory

  def initialize()
    @_store = {}
  end

  def set(key, value)
    @_store[key] = value
  end

  def get(key)
    @_store[key]
  end

  def delete(key)
    @_store.delete!(key)
  end

end
