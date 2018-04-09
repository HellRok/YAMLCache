require 'yaml'

class YAMLStore
  def initialize(path)
    @path = path
    @store = load_store
  end

  def write(key, value=nil, &block)
    store(key, block ? block.call : value)
    File.write(@path, @store.to_yaml)
  end

  def read(key)
    @store[key][:value]
  end

  def cache(key, expiration, &block)
    value = nil
    if @store.has_key?(key)
      if @store[key][:expiration] == nil ||
          (@store[key][:expiration] - Time.now.to_i) <= 0
        value = block.call
        store(key, value, expiration)
      else
        value = @store[key][:value]
      end
    else
      value = block.call
      store(key, value, expiration)
    end

    File.write(@path, @store.to_yaml)

    return value
  end

  private
  def load_store
    if File.exists?(@path)
      YAML.load(File.read(@path))
    else
      {}
    end
  end

  def store(key, value, expiration=nil)
    @store[key] = {
      value: value,
      expiration: expiration ? (Time.now.to_i + expiration) : nil
    }
  end
end
