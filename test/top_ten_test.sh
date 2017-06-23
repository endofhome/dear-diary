#!/usr/bin/awk BEGIN{a=ARGV[1];sub(/[a-z_.]+$/,"libs/bats/bin/bats",a);system(a"\t"ARGV[1])}

load './libs/bats-support/load'
load './libs/bats-assert/load'

@test "single word with no stopwords returns same word" {
  skip "no stopwords is not a valid scenario"
  run bash ./lib/top_ten.sh -d "bob" -s " "
  assert_output "bob"
}

@test "single word with different stopwords returns same word" {
  run bash ./lib/top_ten.sh -d "bob" -s "bert"
  assert_output "bob"
}

@test "single word also included in stopwords returns nothing" {
  run bash ./lib/top_ten.sh -d "bob" -s "bob"
  assert_output ""
}

@test "two words, neither in stopwords, returns both words" {
  run bash ./lib/top_ten.sh -d "bob bert" -s "kim"
  assert_output "bob bert"
}

@test "two words, one in stopwords, returns the other" {
  run bash ./lib/top_ten.sh -d "bob bert" -s "bob"
  assert_output "bert"
}

@test "two words, both in stopwords, returns nothing" {
  run bash ./lib/top_ten.sh -d "bob bert" -s "bob bert"
  assert_output ""
}

@test "ten words, none in stopwords, returns all ten in reverse alphabetical order" {
  run bash ./lib/top_ten.sh -d "bob bert kim gordon steve shelley thurston moore lee ranaldo" -s "jim"
  assert_output "thurston steve shelley ranaldo moore lee kim gordon bob bert"
}

@test "ten words, five in stopwords, returns other five in reverse alphabetical order" {
run bash ./lib/top_ten.sh -d  "bob bert kim gordon steve shelley thurston moore lee ranaldo" -s "bob kim shelley moore lee"
  assert_output "thurston steve ranaldo gordon bert"
}

@test "ten words including duplicates, none in stopwords, returns all ten without duplicates in reverse alphabetical order" {
  run bash ./lib/top_ten.sh -d "bob bob kim kim steve steve thurston thurston lee lee" -s "jim"
  assert_output "thurston steve lee kim bob"
}

@test "three words returned in order of frequency of use" {
  run bash ./lib/top_ten.sh -d "lee kim kim kim shelley shelley" -s "jim"
  assert_output "kim shelley lee"
}

@test "eleven unique words used repeatedly, top ten are returned" {
  run bash ./lib/top_ten.sh -d "a b b c c c d d d d e e e e e f f f f f f g g g g g g g h h h h h h h h i i i i i i i i i j j j j j j j j j j k k k k k k k k k k k" -s "z"
  assert_output "k j i h g f e d c b"
}

@test "if more than ten words are in the 'top ten', fall back on reverse alphabetical order and never take more than ten" {
  run bash ./lib/top_ten.sh -d "k k j j i i h h g g f e d c b a" -s "z"
  assert_output "k j i h g f e d c b"
}

@test "strip punctuation from entries" {
  run bash ./lib/top_ten.sh -d "one two two three, three three." -s "four"
  assert_output "three two one"
}

@test "a diary entry with date, pairing info and punctuation correctly sorted" {
  run bash ./lib/top_ten.sh -d "Saturday 8th April 2017, worked solo: vim TDD, TDD, TDD, TDD bats bats. bats. bats, bats bats bash bash bash. TDD tmux. tmux vim, vim" -s "Saturday 8th April 2017 worked solo"
  assert_output "bats TDD vim bash tmux"
}

@test "compare using whole diary words not substrings" {
  run bash ./lib/top_ten.sh -d "bash jade a flavour" -s "a"
  assert_output "jade flavour bash"
}

@test "integration using diary entry args and real stopwords file" {
  run bash ./lib/top_ten.sh -d "a above became afterwards back with anywhere Kotlin whereby"
  assert_output "Kotlin"
}

@test "as above with custom stopwords" {
  run bash ./lib/top_ten.sh -d "a above became afterwards back with anywhere Kotlin whereby" -s "a above became afterwards back with anywhere whereby"
  assert_output "Kotlin"
}

@test "another variation which proves there's summin' up with 'a' and 'with'" {
  run bash ./lib/top_ten.sh -d "above became afterwards back anywhere Kotlin whereby" -s "above became afterwards back anywhere whereby"
  assert_output "Kotlin"
}

@test "integration using real diary file and stopwords args" {
  skip "obviously an incredibly flakey test but useful while developing!"
  run bash ./lib/top_ten.sh -s "Ren"
  assert_output "to with the and Paired March 2017 for a"
}

@test "calling with default file paths as arguments should be same as without arguments" {
  run bash ./lib/top_ten.sh -d "$(cat $DIARY_FILE)" -s "$(cat stopwords.txt)"
  assert_output "$(bash ./lib/top_ten.sh)"
}
