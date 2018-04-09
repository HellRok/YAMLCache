require 'yaml'

class YAMLStore
  def initialize(path)
    @path = path
    @store = load_store
  end

  def write(key, value=nil, &block)
    if block
      @store[key] = block.call
    else
      @store[key] = value
    end
    File.write(@path, @store.to_yaml)
  end

  def read(key)
    @store[key]
  end

  private
  def load_store
    if File.exists?(@path)
      YAML.load(File.read(@path))
    else
      {}
    end
  end
end
