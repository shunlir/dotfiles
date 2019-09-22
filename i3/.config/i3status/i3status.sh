#!/bin/bash
#
# Inject xwindow title. (ref: https://faq.i3wm.org/question/1537/show-title-of-focused-window-in-status-bar.1.html)
#
/usr/bin/i3status | (read line && echo $line && read line && echo $line && while :
do
  read line
  id=$(xprop -root | awk '/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}')
  if [ x$id != x ]; then
    #name=$(xprop -id $id | awk '/_NET_WM_NAME/{$1=$2="";print}' | cut -d'"' -f2)
    name=$(xprop -id $id | awk '/_NET_WM_NAME/{$1=$2="";print}' | sed 's/^[[:space:]]*"\(.*\)"$/\1/')
    name=${name//\\/\\\\}
    name=${name//\"/\\\"}
    dat="[{\"name\":\"title\",\"color\":\"#b5bd68\",\"full_text\":\"$name\"},"
    echo "${line/[/$dat}" || exit 1
  else
    echo "$line" || exit 1
  fi
done)
