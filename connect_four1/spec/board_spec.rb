require_relative '../lib/board.rb'

describe Board do
  describe '#initialize' do
    subject(:init_board) {described_class.new}
    
    it "creates grid with 6 raws" do
      columns = init_board.grid.transpose 
      expect(init_board.grid.size).to eq(6)
    end

    it "creates grid with 7 columns" do
      columns = init_board.grid.transpose  
      expect(columns.size).to eq(7)
    end
  end
  
  describe '#get_last_empty_column_cell' do
    context 'when given a number of a column where all cells are empty' do
      subject(:board) {described_class.new}
      it 'returns the last empty cell instance in a column' do
        cell = board.get_last_empty_column_cell(6)
        cell.value = "X"
        expect(board.grid[5][6].value).to eq('X')
      end
    end 

    context 'when given a number of a column where one of the cells is filled' do
      subject(:board) {described_class.new}
      it 'returns the last empty cell instance in a column' do
        first_cell = board.get_last_empty_column_cell(1)
        first_cell.value = "X"
        second_cell = board.get_last_empty_column_cell(1)
        second_cell.value = "Y"
        expect(board.grid[4][1].value).to eq('Y')
      end
    end
  end

  describe "#game_over?" do
    subject(:board) {described_class.new}
    context "when grid is full" do
      before do
        allow(board).to receive(:draw?).and_return(true)
      end
      it "returns draw" do
        expect(board.game_over?).to eq(:draw)
      end
    end

    context "when somebody won" do
      before do
        allow(board).to receive(:winner?).and_return(true)
      end
      it "returns winner" do
        expect(board.game_over?).to eq(:winner)
      end
    end
  end

  # describe "#draw?" do
  #   subject(:board) {described_class.new}
  #   context "when there are no empty cells" do
  #     it "returns true" do
  #       board.grid.each { |raw| raw.each {|item| item.value = "x"}}
  #       expect(board.draw?).to be true
  #     end
  #   end
  # end
    
  # describe "#winner?" do
  #   subject(:board) {described_class.new}
    
  #   context "when somebody got 4 items together in a raw" do
  #     it "returns true" do
  #       board.grid.each { |raw| raw.each {|item| item.value = "X"}}
  #       expect(board.winner?).to be true
  #     end
  #   end

  #   context "when nobody won" do
  #     it "returns false" do
  #       expect(board.winner?).to be false
  #     end
  #   end
  # end

  describe '#set_cell' do
    subject(:board) {described_class.new}

    context 'when given number of column 5 and value "X"' do
      it "updates the last empty cell at given column" do
        board.set_cell(6, "X")
        board.set_cell(6, "O")
        expect(board.grid[4][6].value).to eq("O")
      end
    end
  end
end