require '../lib/extentions.rb'

describe Array do
  describe "#four_same_in_a_raw?" do
    context "when given an array with 4 same 'X' elements in a row starting at index 1" do
      it 'returns true' do
        expect([1,"X","X","X","X",1,2].four_same_in_a_raw?).to be true
      end
    end
    
    context "when given an array with 4 same 'O' elements in a row starting at index 2" do
      it 'returns true' do
        expect([2,1,"O","O","O","O",1,2].four_same_in_a_raw?).to be true
      end
    end

    context "when given an array with different elements " do
      it 'returns false' do
        expect([1,2,5,6,1,1,2].four_same_in_a_raw?).to be false
      end
    end
  end
end