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

@test "ten words, none in stopwords, returns all ten" {
  run bash top_ten.sh -d "bob bert kim gordon steve shelley thurston moore lee ranaldo" -s "jim"
  assert_output "bob bert kim gordon steve shelley thurston moore lee ranaldo"
}

@test "ten words, five in stopwords, returns other five" {
  run bash top_ten.sh -d  "bob bert kim gordon steve shelley thurston moore lee ranaldo" -s "bob kim shelley moore lee"
  assert_output "bert gordon steve thurston ranaldo"
}
