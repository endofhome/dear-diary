class Searcher

  def initialize(stopwords)
    @stopwords = stopwords
    @result = []
  end

  def top_ten(diary_entry)
    diary_entry.each do |e|
      unless @stopwords.include? e
        @result << e
      end
    end
    @result.sort.reverse
  end

end