class Searcher

  def initialize(stopwords)
    @stopwords = stopwords
    @result = []
  end

  def top_ten(diary_entry)
    less_stopwords = diary_entry.select { |e| !@stopwords.include? e }
    result_map = create_map(less_stopwords.sort)
    by_frequency = result_map.sort_by {|word, frequency| [frequency, word] }
    remove_frequency(by_frequency).reverse
  end

  def remove_frequency(words_map_by_freq)
    words = []
    words_map_by_freq.each do |word, frequency|
      words << word
    end
    words
  end

  def create_map(words)
    result_map = {}
    words.each { |item| result_map[item] = words.count(item) }
    result_map
  end

end