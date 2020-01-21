require 'mongo'

class Seth::Store::Mongo
  def initialize(config)
    @_client = Mongo::Client.new(config[:host], database: config[:database])
    @_collection = @_client.collection[:seth_store]
    @_collection.create_index({key: "hashed"}, {"unique" : "true"}) 
  end

  def set(key, value)
    @_collection.updateOne({ key: key }, { value: value}, upsert: true) 
  end

  def get(key)
    @_collection.findOne( { key: key } )
  end

  def delete(key)
    @_collection.deleteOne( { key: key } )
  end
end
