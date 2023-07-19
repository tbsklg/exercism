# !/usr/bin/env bash

main () {
    if [ $# -ne 1 ]
        then
            echo "Usage: error_handling.sh <person>"
            exit 1
        else
            echo "Hello, $1"
    fi
}

main "$@"
