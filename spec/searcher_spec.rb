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

  it 'eleven unique words used repeatedly, top ten are returned' do
    searcher = described_class.new(['z'])
    search_words = %w(a b b c c c d d d d e e e e e f f f f f f g g g g g g g h h h h h h h h i i i i i i i i i j j j j j j j j j j k k k k k k k k k k k)
    expect(searcher.top_ten(search_words)).to eq %w(k j i h g f e d c b)
  end

  it 'if more than ten words are in the "top ten", fall back on reverse alphabetical order and never take more than ten' do
    searcher = described_class.new(['z'])
    expect(searcher.top_ten(%w(k k j j i i h h g g f e d c b a))).to eq %w(k j i h g f e d c b)
  end

end
