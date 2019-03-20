#!/usr/bin/env bats

diag() {
    echo "$@" | sed -e 's/^/# /' >&3 ;
}

VERSION="0.1.0"

@test "invoking date-dedash with non-existing file prints and error" {
    run date-dedash i_dont_exist
    [ "$status" -eq 1 ]
    [ "$output" = "date-dedash: no such file 'i_dont_exist'" ]
}

@test "date-dedash accepts multiple files" {
    cd $BATS_TMPDIR
    touch abc def ghi
    output="$(date-dedash abc def ghi | grep -ic processing)"
    [ "$output" -eq 3 ]
    rm abc def ghi
}

@test "date-dedash handles filenames properly with spaces" {
    cd $BATS_TMPDIR
    touch "2019-03-19 File With Spaces"{1..2}

    # Test with double quotes around filename
    run date-dedash "2019-03-19 File With Spaces1"

    [[ "${lines[0]}" = "Processing 2019-03-19 File With Spaces1 ..." ]]
    [ "$(echo $output | grep -io processing | wc -l)" -eq 1 ]

    # Test with escaped spaces in filename
    run date-dedash 2019-03-19\ File\ With\ Spaces2

    [ "${lines[0]}" = "Processing 2019-03-19 File With Spaces2 ..." ]
    [ "$(echo $output | grep -io processing | wc -l)" -eq 1 ]

    # Test multiple filenames each with spaces
    touch "2019-03-20 File With Spaces"{1..3}

    run date-dedash "2019-03-20 File With Spaces1" "2019-03-20 File With Spaces2" "2019-03-20 File With Spaces3"
    [ "$(echo $output | grep -io processing | wc -l)" -eq 3 ]
}

@test "invoking date-dedash with no arguments prints version, copyright, and usage" {
    run date-dedash

    [ "${lines[0]}" = "date-dedash v$VERSION" ]
    [[ "${lines[1]}" =~ "Copyright" ]]
    [[ "${lines[2]}" =~ "Usage: date-dedash" ]]

}

@test "ensure files are passed if supplying options" {
    skip
}

@test "return error if unknown option supplied" {
    skip
}

@test "--dry-run option makes no changes, outputs effects" {
    skip
}