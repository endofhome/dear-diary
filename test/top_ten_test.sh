#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

@test "single word with no stopwords returns same word" {
  skip "no stopwords is not a valid scenario"
  run bash top_ten.sh -d "bob" -s " "
  assert_output "bob"
}

@test "single word with different stopwords returns same word" {
  run bash top_ten.sh -d "bob" -s "bert"
  assert_output "bob"
}

@test "single word also included in stopwords returns nothing" {
  run bash top_ten.sh -d "bob" -s "bob"
  assert_output ""
}

@test "two words, neither in stopwords, returns both words" {
  run bash top_ten.sh -d "bob bert" -s "kim"
  assert_output "bob bert"
}

@test "two words, one in stopwords, returns the other" {
  run bash top_ten.sh -d "bob bert" -s "bob"
  assert_output "bert"
}

@test "two words, both in stopwords, returns nothing" {
  run bash top_ten.sh -d "bob bert" -s "bob bert"
  assert_output ""
}

@test "ten words, none in stopwords, returns all ten in reverse alphabetical order" {
  run bash top_ten.sh -d "bob bert kim gordon steve shelley thurston moore lee ranaldo" -s "jim"
  assert_output "thurston steve shelley ranaldo moore lee kim gordon bob bert"
}

@test "ten words, five in stopwords, returns other five in reverse alphabetical order" {
  run bash top_ten.sh -d  "bob bert kim gordon steve shelley thurston moore lee ranaldo" -s "bob kim shelley moore lee"
  assert_output "thurston steve ranaldo gordon bert"
}

@test "ten words including duplicates, none in stopwords, returns all ten without duplicates in reverse alphabetical order" {
  run bash top_ten.sh -d "bob bob kim kim steve steve thurston thurston lee lee" -s "jim"
  assert_output "thurston steve lee kim bob"
}

@test "three words returned in order of frequency of use" {
  run bash top_ten.sh -d "lee kim kim kim shelley shelley" -s "jim"
  assert_output "kim shelley lee"
}
