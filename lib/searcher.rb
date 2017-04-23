class Searcher

  def initialize(stopwords)
    @stopwords = stopwords
    @result = []
  end

  def top_ten(diary_entry)
    diary_entry.each do |e| 
      if !@stopwords.include? e
        @result << e
      end
    end
    @result
  end

end