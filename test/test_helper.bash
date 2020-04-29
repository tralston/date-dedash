# Defines the $CMD global used in tests. This allows the command to be tested when the bats command
# is run either from the base repo directory, or from within the 'test' folder
export CMD="$(realpath $(dirname $(realpath ${BASH_SOURCE}))/../date-dedash)"