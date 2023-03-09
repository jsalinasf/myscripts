#!/bin/bash
RECEIVER="USAVCC@adistec.com,jrivas@adistec.com"
SUBJECT="USVCCZAD02 notifications"
file_location="/tmp/aec-var-crash-$(date +"%Y%m%d%H%M%S").log"
BODY=""
SUCCESSES=0
FAILURES=0
SIZE=0
TOTALSIZE=0
TOTALSIZEMB=0

BODY+="Cleaning /var/crash folder:"$'\n\n'
BODY+="date,result,file,sizeKB"$'\n'

for f in $(find /var/crash/* -type f -mmin +2)
  do
    logger "Trying to delete: $f"
    SIZE=$(du -sb $f | awk '{ print $1 }')
    SIZE=$(( $SIZE/1024 ))
    TOTALSIZE=$(( $TOTALSIZE + $SIZE ))
    rm $f
    if [ $? -eq 0 ]; then
      logger "aec SUCCESS deleting file $f"      
      LOGDATE=$(date +"%Y-%m-%d")
      LOGTIME=$(date +"%T")
      BODY+="$LOGDATE,$LOGTIME,Success,$f,$SIZE"$'\n'
      let SUCCESSES++
    else
      logger "aec ERROR deleting file $f"
      LOGDATE=$(date +"%Y-%m-%d")
      LOGTIME=$(date +"%T")
      BODY+="$LOGDATE,$LOGTIME,Error,$f,$SIZE"$'\n'
      let FAILURES++
    fi
  done

TOTALSIZEMB=$(( $TOTALSIZE/1024 ))

BODY+=""$'\n'
BODY+="Successful deleted files: $SUCCESSES"$'\n'
BODY+="Total deleted MBs: $TOTALSIZEMB"$'\n\n'
BODY+="Failed deleted files: $FAILURES"$'\n'

cat > $file_location << EOF
To: $RECEIVER
Subject: $SUBJECT

$BODY
EOF


cat $file_location | msmtp -t
rm $file_location
