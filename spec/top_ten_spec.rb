require 'top_ten'

describe TopTen do

    subject(:top_ten) { described_class.new() }

    it 'single word with no stopword returns same word' do
        expect(top_ten.top_ten('bob', '')).to eq 'bob'
    end

end
