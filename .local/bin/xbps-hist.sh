#!/usr/bin/env bash

#-------------#
# SCRIPT NAME #
#-------------#
declare -r name=${0##*/}
declare -r Version="0.1.2"

#---------------------#
# ENABLE BASH OPTIONS #
#---------------------#
shopt -s extglob nullglob

#--------------------#
# SIMPLE EXIT DIALOG #
#--------------------#
die(){
    printf "%s: %b\n" "${name^}" "$@" >&2
    rm -f $temp
    exit 2
}

#-------------------------#
# EXEC SOME VERIFICATIONS #
#-------------------------#
# check for packages
command -v socklog &> /dev/null || die "Dependency 'socklog-void' not found"

# check for service enable
for srv in socklog-unix nanoklogd; do
    [ -e "/var/service/$srv" ] || die "Service '$srv' not enabled"
done

# check for user membership
read -a groups < <(groups)
[[ ${groups[@]} =~ socklog ]] || die "Add user to 'Socklog' Group Please"
unset groups grp srv


#-------------------#
# GENERAL VARIABLES #
#-------------------#
declare -A options
declare -l ACTION
declare -A stat=( [install]="Installed" [update]="Updated" [remove]="Removed")
declare -r LogDir="/var/log/socklog/xbps"
LogFiles=( $LogDir/{*.[us],current} )

#------------------#
# CREATE TEMP FILE #
#------------------#
read temp < <(mktemp -q /tmp/$name.XXX)

#------------------#
# GET ALL LOG FILE #
#------------------#
for log in ${LogFiles[@]}; { cat $log >> $temp ;}

#------------------------#
# CHECK FOR CORRECT DATE #
#------------------------#
date_check(){
    # check if user insert a correct date format
    read date < <(date -d "$1" +%F 2> /dev/null)
    [ "$date" ] || die "Invalid date '$1'.\ntry '$name -h' for more information"
}

#--------------#
# ALL LOG INFO #
#--------------#
list_func(){

# check date
while read -a line ; do
    # get package name and version
    Pkg=${line[7]:1:-1}
    PkgName=${Pkg%-*}
    PkgVersion=${Pkg##*-}

    # get the log date
    DateTime="${line[0]%.*}"
    DateTime="${DateTime%%T*}"

    # you choose '-s' option
    if [ "${options[s]}" ]; then
        # check if user Pkg match the log pkg
        [ "$PKG" = "$PkgName" ] || continue
    fi

    # you choose '-d' option
    if [ "${options[d]}" ]; then
        [ "${options[S]}" ] || [ "${options[T]}" ] && die "Only one date option is allowed.\nTry '$name -h' for more information."
        date_check "$DATE"
        # check if the user date match the log date
        [[ $DateTime =~ $date ]] || continue
    # you choose "-S" option
    elif [ "${options[S]}" ] && [ -z "$SINCE" ]; then
        date_check "$SDATE"
        [[ $DateTime =~ $date ]] && SINCE=true
    fi

    # start show from SINCE date (-S)
    [ "${options[S]}" ] && [ -z "$SINCE" ] && continue

    # save old date
    old_date="$DateTime"

    # is a trick to show all logs in UNTIL date (-T)
    [ "$UNTIL" ] && {
        [[ $old_date =~ $date ]] || break
    }

    # you choose '-a' option
    if [ "${options[a]}" ]; then
        # check if the user insert a correct action
        [[ $ACTION =~ (install|remove|update) ]] || die "Invalide action "$ACTION".\ntry '$name -h' for more information"

        # check if the action match the log
        action="${stat[$ACTION]}"
        [ "${line[6]}" = "$action" ] || continue
    fi

    # printf the resoult in full and short format with or without color
    [ "${#line[6]}" -lt 9 ] && action="${line[6]}  " || action="${line[6]}"
    if [ "${options[f]}" ]; then
        [ "${line[8]}" = "successfully" ] && printf "%b %b - %b %b %b %b\n" \
                                                "${underline}$DateTime${off}" \
                                                "${color[${line[6]}]}$action${off}" \
                                                "$PkgName" \
                                                "${bold}'$PkgVersion'${off}" \
                                                "${line[8]^}" \
                                                "${line[9]}${line[10]}"
    else
        [ "${line[8]}" = "successfully" ] && printf "%b %b - %s\n" \
                                                "${underline}$DateTime${off}" \
                                                "${color[${line[6]}]}$action${off}" \
                                                "$PkgName"
    fi

    # you choose '-T' option
    if [ "${options[T]}" ]; then
        date_check "$TDATE"
        [[ $DateTime =~ $date ]] && UNTIL=true
    fi

done < $temp
}

#-------------#
# HELP DIALOG #
#-------------#
help_func(){
while read ; do
    printf "%s\n" "$REPLY"
done <<-HELP
${name^^}-$Version: Xbps Log Viewer in Pure Bash
USAGE: $name [OPTIONS] ...

OPTIONS:
    -a <action> Set the <action> you looking for
    -d <date>   Set Date to search
    -s <pkg>    Search for special Package
    -l          List log Info depends on '-a,-d,-s'
    -f          Dispaly Full Log Info
    -c          Enable Colors
    -S <date>   Display all long SINCE a Date
    -T <date>   Dispaly all logs UNTIL a Date
    -h          Show this help dialog and exit
    -v          Show Application version

NOTE:
    the serach start from the day you:
        Install 'socklog-void'
        Enable 'socklog-unix,nanoklogd'
        Add \$USER to socklog Group

    <action>:
        Xbps action like [install,remove,update]

    <date>:
        you can use simple form like 'YYYY-MM-DD'
        or human readable for see 'man date'
HELP
}

#---------------#
# MAIN FUNCTION #
#---------------#
main_func(){
# show this message when nt option giving
[ -z "$1" ] && printf "%s: %b\n" "${name^}" "To start displaying Xbps Log please use '-l' flag" >&2

while getopts ':a:d:s:lfcS:T:hv' OPT; do
    case "$OPT" in
        a ) options[a]=true
            ACTION="$OPTARG" ;;
        d ) options[d]=true
            DATE="$OPTARG" ;;
        s ) options[s]=true
            PKG="$OPTARG" ;;
        l ) options[l]=true ;;
        f ) options[f]=true ;;
        c ) options[c]=true ;;
        S ) options[S]=true
            SDATE="$OPTARG" ;;
        T ) options[T]=true
            TDATE="$OPTARG" ;;
        h ) options[h]=true ;;
        v ) options[v]=true ;;
        : ) die "Option requires an argument -- '$OPTARG'\nTry '$name -h' for more informations." ;;
        * ) die "Invalid option -- '$OPTARG'\nTry '$name -h' for more informations." ;;
    esac
done
}

#-------------------#
# RUN MAIN FUNCTION #
#-------------------#
main_func "$@"

#------------------#
# RUN USER OPTIONS #
#------------------#
if [ "${options[c]}" ]; then
    declare -A color=( [Installed]="\e[32;1m" [Updated]="\e[34;1m" [Removed]="\e[31;1m")
    underline="\e[4m"
    bold="\e[1m"
    off="\e[0m"
fi
[ -z "${options[l]}" ] || list_func
[ -z "${options[h]}" ] || help_func
[ -z "${options[v]}" ] || printf "%s\n" "${name^} Version: $Version"

# remove temp file
rm -f "$temp"
