#!/bin/sh
#
# Hides your terminal window before launching an external program and unhides it after quitting.
# Dependencies: sed, xdo
# Usage: devour CMD/ALIAS ...
#        devour CMD/ALIAS ... -- [FILE with spaces]

ARGS=$*

CMD="${ARGS%% -- *}"
FILE="${ARGS##* -- }"

if [ "$FILE" = "$CMD" ]; then
    SAFEFILE=
else
    SAFEFILE=$(echo "$FILE" | sed 's/ /\\ /g')
fi

WID=$(xdo id)

$SHELL -i -c "xdo hide
$CMD $SAFEFILE > /dev/null 2>&1
xdo show $WID
exit"
