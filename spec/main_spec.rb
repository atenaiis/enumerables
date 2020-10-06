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
      expect(range.my_none?(String)).to be true
    end

    it 'Should return false if one or more elements of a hash pass a condition given in a block' do
      expect(hash.my_none? { |_key, val| val.is_a? String }).to be false
    end
  end

  describe '#my_count' do
    it 'If no block is given return the length of array' do
      expect(arr.my_count).to eq(arr.length)
    end

    it 'will give number of times an specific input is in an array' do
      expect(arr.my_count(9)).to eq(1)
    end

    it 'will count the elements that pass condition in a block' do
      expect(arr.my_count { |x| x > 5 }).to eq(3)
    end

    it 'it will give hash length if block is not given' do
      expect(hash.my_count).to eq(hash.length)
    end

    it 'will return the number of elements that pass the condition in the block' do
      expect(range.my_count(&:even?)).to eq(4)
    end
  end

  describe '#my_map' do
    it 'will return enumerator if block is no given' do
      expect(arr.my_map.class).to eq(Enumerator)
    end

    it 'when block is given will yield on each element in the array' do
      expect(arr.my_map { |x| x * 2 }).to eq([10, 12, 18, 16, 8])
    end

    it 'if block is not given and argument is a proc it calls to run on each element in the array' do
      my_proc = proc { |x| x * 2 }
      expect(arr.my_map(my_proc)).to eq([10, 12, 18, 16, 8])
    end

    it 'if block is given and argument is given as Proc, call it on each element in the array' do
      my_proc = proc { |x| x * 2 }
      expect(arr.my_map(my_proc) { |x| x * 3 }).to eq([10, 12, 18, 16, 8])
    end
  end

  describe '#my_inject' do
    it 'if a symbol operator was given as an argument, it should call it on each array element and return one value' do
      expect(arr.my_inject(:+)).to eq(arr.sum)
    end

    it 'Should return the value from calling the operator on each array element starting with the initial value' do
      expect(arr.my_inject(45, :+)).to eq(arr.sum + 45)
    end

    it 'Should return one value from calling the block on each array element starting with the initial value' do
      expect(arr.my_inject(45) { |sum, x| sum + x }).to eq(arr.sum + 45)
    end

    it 'Should return one value from calling the block on each element of the array' do
      expect(arr.my_inject { |sum, x| sum + x }).to eq(arr.sum)
    end
  end

  describe '#my_select' do
    it 'Should return the enumerator if no block is given' do
      expect(arr.my_select.class).to eq(Enumerator)
    end

    it 'Should return an array of elements that pass a condition provided in the block' do
      expect(arr.my_select { |x| x > 5 }).to eq([6, 9, 8])
    end

    it 'Should be called on objects and execute a condition in a block' do
      expect(hash.my_select { |_k, v| v == 'mexico' }).to eq([[:location, 'mexico']])
    end

    it 'Should be called on ranges and execute a condition in a block' do
      expect(range.my_select { |x| x < 3 }).to eq([0, 1, 2])
    end
  end
end
