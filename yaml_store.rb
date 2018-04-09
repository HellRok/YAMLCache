require 'yaml'

class YAMLStore
  def initialize(path)
    @path = path
    @store = load_store
  end

  def write(key, value)
    @store[key] = value
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
