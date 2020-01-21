
module Seth::Store
  def self.create(config)
    case config[:store]
    when :mongo
      require 'seth/store/mongo'
      mongo_store = Seth::Store::Mongo.new(config)
      return mongo_store
    when :in_memory
      require 'seth/store/in_memory'
      return Seth::Store::InMemory.new
    when :tomb
      return Seth::Store::Tomb.new(config)
    end
  end
end
