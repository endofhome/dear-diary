class Searcher

  def initialize(stopwords)
    @stopwords = stopwords
    @result = []
  end

  def top_ten(diary_entry)
    sorted_less_punctutation = diary_entry.map { |word| word.gsub(/[^a-zA-Z0-9]/, '') }.sort
    less_stopwords = sorted_less_punctutation.select { |e| !@stopwords.include? e }
    result_map = create_map(less_stopwords)
    by_frequency = result_map.sort_by {|word, frequency| [frequency, word] }
    remove_frequency(by_frequency)
        .reverse
        .take(10)
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