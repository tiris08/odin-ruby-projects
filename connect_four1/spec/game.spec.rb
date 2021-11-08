require_relative '../lib/game.rb'

describe Game do
  describe '#get_move' do
    let(:board) { instance_double(Board) }
    subject(:game) {described_class.new([1,1], board)}
    
    context "when given invalid number and then valid" do
     
      before do
        valid = "2"
        invalid = "192"
        allow(game).to receive(:gets).and_return(invalid, valid)
      end

      it "returns error massage" do
        error = "Error, Please enter a correct number between 0 and 6"
        expect(game).to receive(:puts).with(error).once
        game.get_move
      end
    end

    context 'when given valid number' do
      before do
        valid = "3"
        allow(game).to receive(:gets).and_return(valid)
      end

      it "does not reises error message" do
        error = "Error, Please enter a correct number between 0 and 6"
        expect(game).not_to receive(:puts).with(error)
      end
    end

    context 'when given letter then valid number' do
      
      before do
        letter = "ew"
        valid_number = "5"
        allow(game).to receive(:gets).and_return(letter, valid_number)
      end
      
      it "reises an error once" do
        error = "Error, Please enter a correct number between 0 and 6"
        expect(game).to receive(:puts).with(error).once
        game.get_move
      end
    end
  end
end