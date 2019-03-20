#!/usr/bin/env bats

@test "invoking date-dedash with non-existing file prints and error" {
    run date-dedash i_dont_exist
    [ "$status" -eq 1 ]
    [ "$output" = "date-dedash: no such file 'i_dont_exist'" ]
}