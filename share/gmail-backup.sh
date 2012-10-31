#! /bin/sh
#
# @author Ollivier Robert <roberto@keltia.net>
#
# TODO: to be rewritten in Ruby
#
# $Id: gmail-backup.sh,v a7821bf8be6d 2012/10/31 14:18:59 roberto $

OPTS="-o -d $HOME/Mail/gmvault-db --no-compression -t quick"
ADDR="keltia@gmail.com"
BASE="$HOME/Downloads/gmvault-v1.7-beta/bin/"
TSOCKS="sh"
args=`getopt rt $*`
errcode=$?
if [ $errcode != 0 ]; then
	echo "Usage $0 [-r] [-t]"
	exit 2
fi

set -- $args
for i
do
	case "$i"
	in
		-r)
		echo 'Resume'
		OPTS="$OPTS --resume"
		shift
		;;
		-t)
		echo 'Using tsocks'
		TSOCKS="tsocks"
		shift
		;;
	esac
done
	
cd $BASE
$TSOCKS ./gmvault sync $OPTS $ADDR
