require_relative 'yaml_store'
require 'minitest/autorun'

describe YAMLStore do
  describe '#write' do
    before do
      @instance = YAMLStore.new('./tmp/write.yml')
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
      @instance = YAMLStore.new('./tmp/read.yml')
      @instance.write('test_read', 'something')
    end

    after do
      File.delete('./tmp/read.yml')
    end

    it 'returns the stored value' do
      assert_equal @instance.read('test_read'), 'something'
    end

    it 'handles multiple instances at once' do
      second = YAMLStore.new('./tmp/read_2.yml')
      second.write('test_read', 'something_else')

      assert_equal @instance.read('test_read'), 'something'
      assert_equal second.read('test_read'), 'something_else'

      File.delete('./tmp/read_2.yml')
    end
  end
end
