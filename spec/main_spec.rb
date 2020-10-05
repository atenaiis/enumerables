require_relative '../main'

describe 'Enumerables' do
  let(:arr) { [5, 6, 9, 8, 4] }
  let(:hash) { { name: 'Mariana', color: 'blue', location: 'mexico' } }
  let(:range) { (0..7) }

  describe '#my_each' do
    it 'give an enum if not block given' do
      expect((arr.my_each.is_a? Enumerable)).to be(true)
    end

    it 'yield block to given array' do
      arr1 = []
      arr.my_each { |n| arr1 << n * 2 }
      expect(arr1).to eq([10, 12, 18, 16, 8])
    end

    it 'if a hash is given block should yield' do
      color_given = []
      hash.my_each { |_k, v| color_given << v }
      expect(color_given).to eq(%w[Mariana blue mexico])
    end

    it 'when range is given block yield' do
      range2 = []
      range.my_each { |el| range2 << el / 2.0 }
      expect(range2).to eq([0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5])
    end

    it 'Return the elements 1 2 3 4' do
      expect(arr.my_each { |x| x }).to eql(arr)
    end
  end

  describe '#my_each_with_index' do
    it 'Return self' do
      expect(arr.my_each_with_index { |x, y| }).to eql(arr)
    end

    it 'Return an enumerator when no block given' do
      result = arr.my_each_with_index
      expect(result.class).to eq(Enumerator)
    end

    it 'calls the block on a given array and returns it' do
      val = 0
      arr.my_each_with_index { |value, i| val = value if i == 3 }
      expect(val).to eq(8)
    end

    it 'should call the block on a hash and return it' do
      val = ''
      hash.my_each_with_index { |value, i| val = value if i == 2 }
      expect(val).to eq([:location, 'mexico'])
    end

    it 'should call the block on a range and return it' do
      val = 0
      range.my_each_with_index { |value, i| val = value if i == 5 }
      expect(val).to eq(5)
    end
  end

  describe '#my_all?' do
    it 'Should return true if all elements of an array pass a condition given in a block' do
      expect(arr.my_all? { |num| num > 2 }).to be true
    end

    it 'Should return false if all elements of an array do not pass a condition given in a block' do
      expect(arr.my_all? { |num| num > 100 }).to be false
    end

    it 'Should return false if no block is given and there is one element of the array that is falsy' do
      expect([1, nil, 3.14].my_all?).to be false
    end

    it 'Should return false if all elements of a range pass a condition given in a block' do
      expect(range.all?(String)).to be false
    end

    it 'Should return true if all elements of a hash pass a condition given in a block' do
      expect(hash.all? { |_key, val| val.is_a? String }).to be true
    end
  end

  describe '#my_any' do
    it 'Should return true if one of the elements of an array pass a condition given in a block' do
      expect(arr.my_any? { |num| num > 2 }).to be true
    end

    it 'Should return false if there is no single element of an array that pass a condition given in a block' do
      expect(arr.my_any? { |num| num > 100 }).to be false
    end

    it 'Should return true if no block is given and there is one element of the array that is truthy' do
      expect([1, nil, 3.14].my_any?).to be true
    end

    it 'Should return false if no one element of a range pass a condition given in a block' do
      expect(range.any?(String)).to be false
    end

    it 'Should return true if at least one element of a hash passes a condition given in a block' do
      expect(hash.any? { |_key, val| val.is_a? String }).to be true
    end
  end

  describe 'my_none?' do
    it 'Should return true if none of the elements of an array pass a condition given in a block' do
      expect(arr.my_none? { |num| num < 2 }).to be true
    end

    it 'Should return false if one or more elements of an array pass a condition given in a block' do
      expect(arr.my_none? { |num| num < 100 }).to be false
    end

    it 'Should return true if no block is given and there is none of the elements is truthy' do
      expect([nil, false].my_none?).to be true
    end

    it 'Should return true if none of the elements of a range pass a condition given in a block' do
      expect(range.none?(String)).to be true
    end

    it 'Should return false if one or more elements of a hash pass a condition given in a block' do
      expect(hash.none? { |_key, val| val.is_a? String }).to be false
    end
  end
end
