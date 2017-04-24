require 'searcher'

describe Searcher do

  it 'single word with no stopword returns same word' do
    searcher = described_class.new([])
    expect(searcher.top_ten(['bob'])).to eq ['bob']
  end

  it 'single word with different stopword returns same word' do
    searcher = described_class.new(['bert'])
	expect(searcher.top_ten(['bob'])).to eq ['bob']
  end

  it 'single word also included in stopwords returns nothing' do
    searcher = described_class.new(['bob'])
    expect(searcher.top_ten(['bob'])).to eq []
  end

  it 'two words, neither in stopwords, returns both words' do
    searcher = described_class.new([])
    expect(searcher.top_ten(['bob', 'jim'])).to eq ['bob', 'jim']
  end

  it 'two words, one in stopwords, returns the other' do
    searcher = described_class.new(['bob'])
    expect(searcher.top_ten(['bob', 'jim'])).to eq ['jim']
  end

end
