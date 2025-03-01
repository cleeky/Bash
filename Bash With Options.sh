#!/bin/bash

while getopts ":a:p:" opt; do
    case $opt in
        a) arg1="$OPTARG"
        ;;
        p) arg2="$OPTARG"
        ;;
        \?) echo "Invalid option -$OPTARG" >&2
        ;;
        *) prinf "Default Action"
    esac
done

printf "Argument 1 is %s\n" "$arg1"
printf "Argument 2 is %s\n" "$arg2"
