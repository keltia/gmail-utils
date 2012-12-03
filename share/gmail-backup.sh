#! /bin/sh
#
# @author Ollivier Robert <roberto@keltia.net>
#
# TODO: to be rewritten in Ruby
#
# $Id: gmail-backup.sh,v dbdfe7377aac 2012/12/03 13:48:59 roberto $

OPTS="-o --no-compression -t quick"
BASE="$HOME/Downloads/gmvault-v1.7-beta/bin/"
GMVAULT="$HOME/Mail/gmvault-db"
TSOCKS="sh"
args=`getopt hrt $*`
errcode=$?
if [ $errcode != 0 ]; then
	echo "Usage $0 [-hrt] email directory"
	exit 2
fi

set -- $args
for i in $*
do
	case "$i"
	in
	    -h)
	    echo "Backup for GMail"
	    echo "$0 [rt] addr base_directory"
	    exit 1
		-r)
		echo 'Resume'
		OPTS="$OPTS --resume"
		shift
		;;
		-t)
		echo 'Using tsocks'
		TSOCKS="tsocks sh -c "
		shift
		;;
	esac
done

ADDR=$1
GMVAULT=$2

cd $BASE
$TSOCKS ./gmvault sync $OPTS -d $GMVAULT $ADDR
