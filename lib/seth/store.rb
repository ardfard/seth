require 'seth/store/memory'
require 'seth/store/mongo'

module Seth
  def self.create_store(config)
    case config[:store]
    when :mongo
      mongo_store = MongoStore.new(config[:mongo_host])
      return mongo_store
    when :in_memory
      return MemoryStore.new
    end
  end
end
