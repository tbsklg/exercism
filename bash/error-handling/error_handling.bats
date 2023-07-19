#!/usr/bin/env bats
load bats-extra

# local version: 0.0.1

@test "correct arguments" {
  run bash error_handling.sh Alice

  assert_success
  assert_output "Hello, Alice"
}

@test "one long argument" {
  run bash error_handling.sh "Alice and Bob"

  assert_success
  assert_output "Hello, Alice and Bob"
}

@test "incorrect arguments" {
  run bash error_handling.sh Alice Bob

  assert_failure
  assert_output "Usage: error_handling.sh <person>"
}

@test "print usage banner with no value given" {
  run bash error_handling.sh

  assert_failure
  assert_output "Usage: error_handling.sh <person>"
}

@test "empty argument" {
  run bash error_handling.sh ""

  assert_success
  assert_output "Hello, "
}
