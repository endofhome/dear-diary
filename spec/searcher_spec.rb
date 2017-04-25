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
    expect(searcher.top_ten(['jim', 'bob'])).to eq ['jim', 'bob']
  end

  it 'two words, one in stopwords, returns the other' do
    searcher = described_class.new(['bob'])
    expect(searcher.top_ten(['bob', 'jim'])).to eq ['jim']
  end

  it 'two words, both in stopwords, returns nothing' do
    searcher = described_class.new(['bob', 'jim'])
    expect(searcher.top_ten(['bob', 'jim'])).to eq []
  end

  it 'ten words, none in stopwords, returns all ten in reverse alphabetical order' do
    searcher = described_class.new([])
    expect(searcher.top_ten(%w(a b d c f e g h j i ))).to eq %w(j i h g f e d c b a)
  end

  it 'ten words, five in stopwords, returns other five in reverse alphabetical order' do
    searcher = described_class.new(%w(a c e g h))
    expect(searcher.top_ten(%w(a b d c f e g h j i ))).to eq %w(j i f d b)
  end

  it 'ten words including duplicates, none in stopwords, returns all words without duplicates in reverse alphabetical order' do
    searcher = described_class.new(['jim'])
    expect(searcher.top_ten(%w(bob bob kim kim steve steve thurston thurston lee lee))).to eq %w(thurston steve lee kim bob)
  end

  it 'three words returned in order of frequency of use' do
    searcher = described_class.new(['jim'])
    expect(searcher.top_ten(%w(lee kim kim kim shelley shelley))).to eq %w(kim shelley lee)
  end

end
