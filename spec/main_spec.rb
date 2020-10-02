require_relative '../main'

describe '#my_each' do
	let (:array) {[5,6,9,8,4]}
  it  'give an enum if not block given' do
    expect(array.my_each.is_a? Enumerable).to be(true)
	end

	it 'yield block to given array'  do
		 arr = [10,12,18,16,8]
		 arr1 = []
		 array.my_each{|n| arr1 << n*2}
		expect(arr1).to eq(arr)
	end
	
	it 'if a hash is given block should  yield' do
	 color = ["Mariana","blue", "mexico"]
	 hash ={name:"Mariana", color:"blue", location:"mexico" }
	 color_given = []
	 hash.my_each{|k, v| color_given << v}
   expect(color_given).to eq(color)
	end
	
  it 'when range is given block yield'do 
  	range = (0..7)
 		result = [0,0.5,1,1.5,2,2.5,3,3.5]
		range2 = []
		range.my_each{|el| range2 << el / 2.0}
		expect(range2).to eq(result)
  end

end