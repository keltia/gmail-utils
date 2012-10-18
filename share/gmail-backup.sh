#! /usr/bin/env ruby
#
# @author Ollivier Robert <roberto@keltia.net>
#
# $Id: gmail-backup.sh,v 38db2fb81eac 2012/10/18 16:07:51 roberto $

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
