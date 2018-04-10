require "test_helper"

describe YAMLCache do
  describe '#write' do
    before do
      @instance = YAMLCache.new('./tmp/write.yml')
      @instance.write('test', 'sure thing chief')
    end

    after do
      File.delete('./tmp/write.yml')
    end

    it 'saves to a file' do
      assert_equal File.exists?('./tmp/write.yml'), true
    end

    it 'captures blocks and saves their output' do
      @instance.write('block_capture') {
        'hello there'
      }

      assert_equal @instance.read('block_capture'), 'hello there'
    end
  end

  describe '#read' do
    before do
      @instance = YAMLCache.new('./tmp/read.yml')
      @instance.write('test_read', 'something')
    end

    after do
      File.delete('./tmp/read.yml')
    end

    it 'returns the stored value' do
      assert_equal @instance.read('test_read'), 'something'
    end

    it 'handles multiple instances at once' do
      second = YAMLCache.new('./tmp/read_2.yml')
      second.write('test_read', 'something_else')

      assert_equal @instance.read('test_read'), 'something'
      assert_equal second.read('test_read'), 'something_else'

      File.delete('./tmp/read_2.yml')
    end
  end

  describe '#cache' do
    before do
      @instance = YAMLCache.new('./tmp/cache.yml')
    end

    after do
      File.delete('./tmp/cache.yml')
    end

    it 'returns the value if the key exists and hasn\'t expired' do
      @instance.cache('test', 10_000) { 'cache test' }
      @instance.cache('test', 1) { 'something else' }

      assert_equal @instance.read('test'), 'cache test'
    end

    it 'runs the block if the key exists and hasn expired' do
      @instance.cache('test', -1) { 'cache test' }
      @instance.cache('test', 1) { 'something else' }

      assert_equal @instance.read('test'), 'something else'
    end
  end
end
