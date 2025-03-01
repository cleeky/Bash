#!/bin/bash

# Status Tags
# [INFO ]   -   ${status[0]}
# [WARN ]   -   ${status[1]}
# [ERROR]   -   ${status[2]}
# []

#declare -a status
status=("[INFO ]")
status+=("[WARN ]")
status+=("[ERROR]")

# Functions
 function deleting {
    local source_path=$1
    local source_file=$2
    local file_age="+"$3

    local file_list=($(find $source_path -name $source_file -mtime +$file_age))
    # find $source_path -name $source_file -mtime +$file_age -exec rm -f {} \;
    for each file in $file_list
    do
        #rm $file
        echo $file
        if [ $? = 0 ]
        then
            #Write log with INFO in Log saying delete was successfull
            message="${file} was successfully deleted"
            write-log("DELETE",${status[0]},${message})
        else
            #Write log with ERROR in Log saying delete was unsuccessfull
            message="${file} was not able to be deleted"
            write-log("DELETE",${status[2]},${message})
    done

 }

 function archiving {
    local source_path=$1
    local source_file=$2
    local file_age="+"$3
    local dest_path=$4

    local file_list=($(find $source_path -name $source_file -mtime +$file_age))
    # find $source_path -name $source_file -mtime +$file_age -exec rm -f {} \;
    for each file in $file_list
    do
        #get the file name from the path
        

        #Archive function $file
        #tar -zW [archive-file] $file
        echo "${file} -> ${arachfile}"
        if [ $? = 0 ]
        then
            #Write log with INFO in Log saying delete was successfull
            message="${file} was successfully archived to ${dest_path}"
            write-log("ARCHIVE",${status[0]},${message})
        else
            #Write log with ERROR in Log saying delete was unsuccessfull
            message="${file} was not able to be darchived"
            write-log("ARCHIVE",${status[2]},${message})
    done


 }

 function copying {
    local source_path=$1
    local source_file=$2
    local file_age="+"$3
    local dest_path=$4
    local dest_file=$5

    local file_list=($(find $source_path -name $source_file -mtime +$file_age))
    # find $source_path -name $source_file -mtime +$file_age -exec rm -f {} \;
    if [ -d $dest_path ]
    then
        for each file in $file_list
        do
            #cp $file
            echo $file
            if [ $? = 0 ]
            then
                #Write log with INFO in Log saying delete was successfull
                message="${file} was successfully copied"
                write-log("COPY  ",${status[0]},${message})
            else
                #Write log with ERROR in Log saying delete was unsuccessfull
                message="${file} was not able to be copied"
                write-log("COPY  ",${status[2]},${message})
        done
    else
        message="${dest_path} Does Not exists can not complete the copy Function"
        write-log("COPY  ",${status[2]},${message})
    fi
 }

 function moving {
    local source_path=$1
    local source_file=$2
    local file_age="+"$3
    local dest_path=$4
    local dest_file=$5


 }

 function write-log {
    local operation=$1
    local status=$2
    local message=$3

    LogLine=$(date '+%Y-%m-%d %T.%6N')
    LogLine=$LogLine" ${status} - ${operation} - ${message}"
    echo $LogLine>$LogFile
    #to get date in yyyymmdd format use date '+%Y%m%d'
    # date '+%Y-%m-%d %T.%6N' = 2024-01-17 20:55:52.922511
    
 }

# Main

# -f <Config File>
# -s <Sourece Path and File>
# -d <Destention Path and File>
# -a Action
# -t Number of Days
# -l LOg File path & name
if [ $OPTIND -eq 1 ]; then 
        echo "Usage: -"
        echo "   ./housekeeper.sh -f <Control file Name>"
        echo "   eg. ./housekeeper.sh clean-list.txt"
        exit 1
fi

while getopts ":f:s:d:a:t:l:" opt; do
    case $opt in
        f) ConfigFileName="$OPTARG"
        ;;
        s) Source="$OPTARG"
        ;;
        d) Dest="$OPTARG"
        ;;
        a) Action="$OPTARG"
        ;;
        t) AgeDays="$OPTARG"
        ;;
        l) LogFile="$OPTARG"
        ;;
        \?) echo "Invalid option -$OPTARG" >&2
            echo "Usage: -"
            echo "   ./housekeeper.sh -f <Control file Name>"
            echo "   eg. ./housekeeper.sh clean-list.txt"
            exit 1
        ;;
    esac
done

if [ "$ConfigFileName" != "" ]
then
    if ! [[ -f "$ConfigFileName" ]]
    then
        echo "Error: -"
        echo "   Can not find/Open '$ConfigFileName' control file"
        exit 1
    fi

    # Read the input file line by line
    while read -r LINE
    do
        IFS="|"
        read -a Control <<< "$LINE"
        Action="${Control[0]}"
        SourcePath="${Control[1]}"
        SourceFile="${Control[2]}"
        AgeDays="${Control[3]}"
        TargetPath="${Control[4]}"
        TargetFile="${Control[5]}"
        LogFile=$(echo "${Control[6]}" | tr -d '\r')

        case $Action in
            A)
                # Archive Action
                echo "Archiving"
                ;;
            C)
                # Copy Action
                printf "Copying"
                ;;
            M)
                # Move Action
                printf "Moving"
                ;;
            D)
                # Delete Action
                printf "Deleting"
                ;;
        esac

    done < "$ConfigFileName"
else
    # User Paramters to do a single action
    echo "Use options to process sigle line command"
    
    SourceName="$(basename "${Source}")"
    SourcePath="$(dirname "${Source}")"
    DestName="$(basename "${Dest}")"
    DestPath="$(dirname "${Dest}")"
    #VAR='/home/pax/file.c'
    #DIR="$(dirname "${VAR}")" ; FILE="$(basename "${VAR}")"
    #echo "[${DIR}] [${FILE}]"
    case $Action in
        A)
            # Archive Action
            echo "Archiving"
            ;;
        C)
            # Copy Action
            printf "Copying"
            ;;
        M)
            # Move Action
            printf "Moving"
            ;;
        D)
            # Delete Action
            printf "Deleting"
            ;;
    esac
fi