#!/bin/bash

#set -ex

ESC='\e['
ESCEND="m"

HASH_COLOR="${ESC}32${ESCEND}"
TARGET_COLOR="${ESC}31${ESCEND}"
STATUS_COLOR="${ESC}33${ESCEND}"
COLOR_OFF="${ESC}${ESCEND}"

target=$1

#echo -e ${HASH_COLOR}foo${COLOR_OFF}

foo=$(sudo cat /var/log/maillog | grep $target | cut -d ":" -f 4)

for hash in $foo; do
  echo -e $HASH_COLOR''$hash''$COLOR_OFF
  line=$(sudo cat /var/log/maillog \
    | grep $hash \
    | sed -e 's#'$hash'#\'$HASH_COLOR$hash'\'$COLOR_OFF'#g' \
    | sed -e 's#'$target'#\'$TARGET_COLOR$target'\'$COLOR_OFF'#g' \
    | sed -e 's#\(status=\S*\s\)#\'$STATUS_COLOR'\1\'$COLOR_OFF'#g' \
    ; #ケツカンマ
  )
#    | sed -e 's#\([0-9A-F]\{10\}\)#\'$HASH_COLOR$hash'\1\'$COLOR_OFF'#g' \
  #line=$(sudo cat /var/log/maillog | grep $hash | sed -e 's/'$hash'/\\e[31\m'$hash'\\e[m/g')
  echo -e "$line\n"
done

