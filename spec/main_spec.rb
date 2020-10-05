require_relative '../main'

describe 'Enumerables' do
  let(:arr){[5,6,9,8,4]}
  let(:hash){{name:"Mariana", color:"blue", location:"mexico" }}
  let(:range){(0..7)}

  describe '#my_each' do
    it  'give an enum if not block given' do
      expect(arr.my_each.is_a? Enumerable).to be(true)
	  end

	  it 'yield block to given array'  do
		  arr1 = []
		  arr.my_each{|n| arr1 << n*2}
		  expect(arr1).to eq([10, 12, 18, 16, 8])
	  end
	
	  it 'if a hash is given block should  yield' do
	    color_given = []
	    hash.my_each{|k, v| color_given << v}
      expect(color_given).to eq(["Mariana","blue", "mexico"])
	  end
	
    it 'when range is given block yield'do 
		  range2 = []
		  range.my_each{|el| range2 << el / 2.0}
		  expect(range2).to eq([0,0.5,1,1.5,2,2.5,3,3.5])
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

    it 'return array when given block ' do
      val = 0
      arr.my_each_with_index {|value , i|  val= value if (i==3)}
      expect(val).to eq(8)
    end  
  end

  describe '#my_all?' do
    it 'return true' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eql(true)
    end

    it 'return false' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to eql(false)
    end

    it 'return false' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to eql(true)
    end

    it 'return false' do
      expect([nil, true, 99].my_all?).to eql(false)
    end
    
  end
end
