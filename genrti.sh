#!/bin/bash
#
# genrti.sh -- Generate RTI formatted message
# usage:
#	genrti <BUG-ID> <path-to-webrev>	
#

CAT=/usr/gnu/bin/cat
BUG=$1
DESC=`/usr/bin/git log --pretty=oneline | /usr/gnu/bin/grep " $BUG " | /usr/gnu/bin/awk '{$1=$2=""; print $0}'`
WEBREV=$2
GITWCHNGD=$(/usr/bin/git whatchanged -v origin/master..master)
GITPBCHK=$(/usr/bin/git pbchk)

$CAT > $BUG.txt << EOF

issue:
https://www.illumos.org/issues/$BUG
$DESC

webrev:
http://cr.illumos.org/~webrev/wdowling/$WEBREV

gitwhatchanged:
$ git whatchanged -v origin/master..master
$GITWCHNGD

gitpbchk:
$ git pbchk
$GITPBCHK

testing:

Many thanks,
Will
EOF
