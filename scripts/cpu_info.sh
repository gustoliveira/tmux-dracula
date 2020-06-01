#!/usr/bin/env bash

get_percent()
{
	arg=$1
	case "$arg" in
		Linux)
			percent=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')
			echo $percent
		;;
		
		Mac)
			percent=$(ps -A -o %cpu | awk '{s+=$1} END {print s "%"}')
		;;

		Windows)
			# TODO - windows compatability
		;;
	esac
}
check_os()
{
	# Check os
	case $(uname -s) in
		Linux)
			get_percent Linux
		;;

		Darwin)
			# Dont have a mac currently, TODO - Mac compatability - May have a solution, testing
			get_percent Mac
		;;

		CYGWIN*|MINGW32*|MSYS*|MINGW*)
			get_percent Windows
			# leaving empty - TODO - windows compatability
		;;

		*)
		;;
	esac
}



main()
{
	cpu_percent=$(check_os)
	echo "CPU $cpu_percent"
	sleep 5
}
#run main driver
main
