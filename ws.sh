#!/bin/bash
#
# ws.sh -- setup illumos workspace for bug fixing
#
WS=rpool/export/home/illumos-dev/code
GATE=illumos-gate
DEVGATE=illumos-$BUG
ZFS=/usr/sbin/zfs
CHOWN=/usr/gnu/bin/chown
NOW=`/usr/gnu/bin/date +%Y%m%d`

# Need Bug ID to run
BUG=$1

if [[ -z "$1" ]]; then
	echo "Need a Bug ID from https://www.illumos.org/projects/illumos-gate/issues?query_id=15"
	exit 0
fi

# Check for todays snapshot
RESULT=$($ZFS list -t snapshot | grep `date +%Y%m%d`)

if [[ -z "$RESULT" ]]; then
	# Create snapshot
	$ZFS snapshot $WS/illumos-gate@$NOW
	echo "Created snapshot.."
	$ZFS list -t snapshot | grep `date +%Y%m%d`
else
	echo $RESULT
	echo "Snapshot exists continuing..."
fi

# Clone to new workspace
echo "Cloning workspace to " $WS/$DEVGATE
$ZFS clone $WD/illumos-gate@$NOW  $WS/$DEVGATE

# Set permissions
echo "Setting permissions to wmd:staff"
sudo $CHOWN wmd:staff $WS/$DEVGATE
/usr/gnu/bin/ls -d $WS/$DEVGATE
