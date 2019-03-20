#!/usr/bin/env bats

@test "invoking date-dedash with non-existing file prints and error" {
    run date-dedash i_dont_exist
    [ "$status" -eq 1 ]
    [ "$output" = "date-dedash: no such file 'i_dont_exist'" ]
}

@test "date-dedash accepts multiple files" {
    cd $BATS_TMPDIR
    pwd
    touch abc def ghi
    output="$(date-dedash abc def ghi | grep -ic processing)"
    [ "$output" -eq 3 ]
    rm abc def ghi
}