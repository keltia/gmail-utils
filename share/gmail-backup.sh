#! /bin/sh
#
# @author Ollivier Robert <roberto@keltia.net>
#
# $Id: gmail-backup.sh,v f23344581031 2012/11/07 09:25:27 roberto $

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
for i in $*
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
		TSOCKS="tsocks sh"
		shift
		;;
	esac
done
	
cd $BASE
$TSOCKS ./gmvault sync $OPTS $ADDR
