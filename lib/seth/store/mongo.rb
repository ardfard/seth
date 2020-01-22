require 'mongo'

class Seth::Store::Mongo
  def initialize(config)
    @_client = Mongo::Client.new(config[:host], database: config[:database])
    @_collection = @_client.collection[:seth_store]
    @_collection.create_index({key: "hashed"}, {"unique" : "true"}) 
  end

  def set(key, value)
    Rails.cache.write(key, value)
    @_collection.updateOne({ key: key }, { value: value}, upsert: true) 
  end

  def get(key)
    Rails.cache.fetch(key) do
      @_collection.findOne( { key: key } )
    end
  end

  def delete(key)
    Rails.cache.delete(key)
    @_collection.deleteOne( { key: key } )
  end
end
