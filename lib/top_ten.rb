#!/usr/bin/ruby

require './lib/searcher'
require 'optparse'

options = {:diary_entries => [], :stopwords => []}

parser = OptionParser.new do |opts|
    opts.on('-d s', 'diary entries') do |diary|
      diary.split.each do |word|
        options[:diary_entries] << word
      end
    end
    opts.on('-s s', 'stopwords') do |stopwords|
      stopwords.split.each do |word|
        options[:stopwords] << word
      end
    end
end

parser.parse!
searcher = Searcher.new(options[:stopwords])
print "#{searcher.top_ten(options[:diary_entries])}\n"